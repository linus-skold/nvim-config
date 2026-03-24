-- nvim-ask  –  :Ah <question>  –  Ask the neovim-helper Copilot skill from Neovim.
--
-- Speed strategy (two-phase):
--   1. Ripgrep the Neovim manual locally (~50 ms) and inject the relevant
--      sections directly into the prompt  →  no doc-reading tool calls needed.
--   2. Configurable model (default: claude-haiku-4.5, ~5× faster than Sonnet).
--
-- Configure via lazy opts:
--   opts = { model = "claude-sonnet-4.6", verbose = true }

local M = {}

M.config = {
	model = "claude-haiku-4.5",
	verbose = false,
}

local DOC_DIR = vim.fn.expand("~/scoop/apps/neovim/current/share/nvim/runtime/doc")
local CONFIG_DIR = vim.fn.stdpath("config")

local SPINNER = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

-- ── ANSI / output helpers ─────────────────────────────────────────────────────

local function strip_ansi(s)
	s = s:gsub("\27%[[%d;]*[A-Za-z]", "")
	s = s:gsub("\27%][^\7]*\7", "")
	s = s:gsub("\27.", "")
	s = s:gsub("\r", "")
	return s
end

local function clean_lines(raw)
	local lines = vim.split(raw, "\n", { plain = true })
	local out = {}
	for _, l in ipairs(lines) do
		table.insert(out, strip_ansi(l))
	end
	while #out > 0 and out[1]:match("^%s*$") do table.remove(out, 1) end
	while #out > 0 and out[#out]:match("^%s*$") do table.remove(out) end
	return #out > 0 and out or { "(no response)" }
end

--- Strip copilot's tool-call progress lines (● Read …, │ path, └ N lines read).
--- These are copilot CLI's own stdout output, not the model's answer.
local TOOL_LINE = "^%s*[●│└├]"
local function is_tool_line(s)
	return s:match(TOOL_LINE) ~= nil
end

--- When verbose=false, extract only the content between <nvim_answer> tags.
--- Falls back to the full cleaned output (minus tool lines) if no tags found.
local function parse_output(raw, verbose)
	if not verbose then
		local answer = raw:match("<nvim_answer>%s*(.-)%s*</nvim_answer>")
		if answer and #answer > 0 then
			return clean_lines(answer)
		end
	end
	-- verbose=true OR no tags found: return everything, optionally keeping tool lines
	local lines = vim.split(raw, "\n", { plain = true })
	local out = {}
	for _, l in ipairs(lines) do
		local stripped = strip_ansi(l)
		if verbose or not is_tool_line(stripped) then
			table.insert(out, stripped)
		end
	end
	while #out > 0 and out[1]:match("^%s*$") do table.remove(out, 1) end
	while #out > 0 and out[#out]:match("^%s*$") do table.remove(out) end
	return #out > 0 and out or { "(no response)" }
end

-- ── floating window ───────────────────────────────────────────────────────────

local function open_float(lines, title)
	local cols, rows = vim.o.columns, vim.o.lines
	local W = math.min(math.max(72, math.floor(cols * 0.72)), cols - 4)
	local H = math.min(math.max(8, #lines + 2), math.floor(rows * 0.72))

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].filetype = "markdown"

	local win_cfg = {
		relative = "editor",
		width = W,
		height = H,
		row = math.floor((rows - H) / 2),
		col = math.floor((cols - W) / 2),
		style = "minimal",
		border = "rounded",
		title = " " .. title .. " ",
		title_pos = "center",
	}
	if vim.fn.has("nvim-0.10") == 1 then
		win_cfg.footer = "  q / <Esc>  dismiss "
		win_cfg.footer_pos = "right"
	end

	local win = vim.api.nvim_open_win(buf, true, win_cfg)
	vim.wo[win].wrap = true
	vim.wo[win].linebreak = true
	vim.wo[win].scrolloff = 3

	local function close()
		if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
	end
	vim.keymap.set("n", "q",     close, { buffer = buf, nowait = true, silent = true })
	vim.keymap.set("n", "<Esc>", close, { buffer = buf, nowait = true, silent = true })

	return buf, win
end

-- ── animated loading window ───────────────────────────────────────────────────

local function open_loading(question)
	local q = #question > 55 and (question:sub(1, 52) .. "…") or question
	local buf, win = open_float({ "", "  ⠋  Asking Copilot…", "", "  " .. q, "" }, "󰚩 neovim-helper")

	vim.bo[buf].modifiable = true

	local frame = 1
	local timer = vim.uv.new_timer()
	timer:start(100, 100, vim.schedule_wrap(function()
		if not vim.api.nvim_buf_is_valid(buf) then
			timer:stop()
			timer:close()
			return
		end
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
			"",
			"  " .. SPINNER[frame] .. "  Asking Copilot…",
			"",
			"  " .. q,
			"",
		})
		frame = (frame % #SPINNER) + 1
	end))

	return win, timer
end

local function stop_loading(win, timer)
	if timer and not timer:is_closing() then
		timer:stop()
		timer:close()
	end
	if vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_win_close(win, true)
	end
end

-- ── ripgrep context pre-fetch ─────────────────────────────────────────────────

local STOP_WORDS = {
	what=1, does=1, ["do"]=1, how=1, the=1, ["and"]=1, ["for"]=1,
	["with"]=1, that=1, this=1, when=1, where=1, ["from"]=1, about=1,
	["in"]=1, ["is"]=1, can=1, use=1, ["my"]=1, ["to"]=1,
	["a"]=1, ["an"]=1, ["it"]=1, ["or"]=1, ["not"]=1,
}

local function normalise_keys(q)
	q = q:gsub("<[Cc]%-([^>]+)>", function(k) return "CTRL-" .. k:upper() end)
	q = q:gsub("<[AaMm]%-([^>]+)>", function(k) return "META-" .. k:upper() end)
	return q
end

local function build_pattern(question)
	local q = normalise_keys(question)
	local seen, terms = {}, {}
	for token in q:gmatch("[A-Za-z][%w_%-]*") do
		local lo = token:lower()
		if #token >= 4 and not STOP_WORDS[lo] and not seen[lo] then
			seen[lo] = true
			table.insert(terms, vim.pesc(token))
		end
	end
	if #terms == 0 then return nil end
	return table.concat({ unpack(terms, 1, math.min(4, #terms)) }, "|")
end

local function fetch_doc_context(question)
	local pattern = build_pattern(question)
	if not pattern then return "" end

	local result = vim.system(
		{ "rg", "-i", "-A", "7", "-B", "1", "-m", "4", "--trim", "--", pattern, DOC_DIR },
		{ text = true, stdin = false }
	):wait()

	if result.code ~= 0 or not result.stdout or result.stdout == "" then return "" end

	local ctx = result.stdout:gsub(vim.pesc(DOC_DIR) .. "[/\\]?", "")
	return #ctx > 4000 and (ctx:sub(1, 4000) .. "\n…(truncated)") or ctx
end

-- ── prompt builder ────────────────────────────────────────────────────────────

--- Build a single-line --prompt argument (newlines break copilot's arg parser).
--- The ripgrep context is written to a temp file so copilot can read it with
--- one tool call instead of searching the corpus itself.
local function build_prompt(question, ctx_path)
	local parts = { "Use the /neovim-helper skill." }
	if ctx_path then
		table.insert(parts,
			"Pre-fetched Neovim manual context is already saved in " .. ctx_path
			.. " — read that file as your primary doc reference and skip searching other doc files.")
	end
	table.insert(parts, "Answer this question: " .. question)
	return table.concat(parts, " ")
end

-- ── public API ────────────────────────────────────────────────────────────────

function M.ask(question)
	local doc_context = fetch_doc_context(question)
	local loading_win, spinner_timer = open_loading(question)
	local start_ms = vim.uv.now()
	local model = M.config.model

	-- Write pre-fetched context to a temp file so --prompt stays single-line.
	-- (copilot's arg parser stops at the first newline in the prompt value.)
	local ctx_path = nil
	if doc_context ~= "" then
		ctx_path = vim.fn.tempname() .. ".txt"
		vim.fn.writefile(vim.split(doc_context, "\n", { plain = true }), ctx_path)
	end

	vim.system(
		{ "copilot", "--no-alt-screen", "--yolo", "--model", model, "--prompt", build_prompt(question, ctx_path) },
		{
			cwd = CONFIG_DIR,
			env = vim.tbl_extend("force", vim.fn.environ(), { NO_COLOR = "1" }),
			stdin = false,
			text = true,
		},
		function(result)
			vim.schedule(function()
				if ctx_path then vim.fn.delete(ctx_path) end
				stop_loading(loading_win, spinner_timer)

				local elapsed = string.format("%.1fs", (vim.uv.now() - start_ms) / 1000)
				-- Only use stdout — stderr carries copilot's usage/timing stats
				local lines = parse_output(result.stdout or "", M.config.verbose)

				if result.code ~= 0 and lines[1] == "(no response)" then
					lines = {
						"⚠  copilot exited with code " .. result.code,
						"",
						"Make sure `copilot` is in your PATH and you are logged in.",
					}
				end

				table.insert(lines, "")
				table.insert(lines, "─────")
				table.insert(lines, "⏱ " .. elapsed .. "  •  " .. model)

				local q_title = #question > 55 and (question:sub(1, 52) .. "…") or question
				open_float(lines, "󰚩  " .. q_title)
			end)
		end
	)
end

function M.setup(opts)
	M.config = vim.tbl_extend("force", M.config, opts or {})

	vim.api.nvim_create_user_command("Ah", function(o)
		if o.args == "" then
			vim.notify(":Ah <question>  –  ask the neovim-helper skill", vim.log.levels.WARN)
			return
		end
		M.ask(o.args)
	end, { nargs = "+", desc = "Ask the neovim-helper Copilot skill" })
end

return M
