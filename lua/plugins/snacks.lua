local vc = require("user.version_checker")

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = true,
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
				{
					text = {
						{ "Neovim", hl = "header" },
						{ " v" },
						{ vc.get_current() },
						{ vc.update_available() and " -> v" .. vc.get_latest(), hl = "Special" },
					},
					align = "center",
				},
			},
		},
		picker = {
			enabled = true,
			finder = "rg",
			projects = {
				patterns = { ".git", "package.json", "config.nu", "*.sln", "*.slnx" },
			},
			sources = {
				explorer = {
					title = "",
				},
			},
		},
		image = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = { enabled = true, shell = "nu" },
		words = { enabled = true },
		styles = {
			notification = {},
			terminal = { position = "right"},
		},
	},
    -- stylua: ignore start
    keys = {
        { "<leader>z",       function() Snacks.zen() end,                                             desc = "Toggle Zen Mode", },
        { "<leader>Z",       function() Snacks.zen.zoom() end,                                        desc = "Toggle Zoom", },
        { "<leader>.",       function() Snacks.scratch() end,                                         desc = "Toggle Scratch Buffer", },
        { "<leader>S",       function() Snacks.scratch.select() end,                                  desc = "Select Scratch Buffer", },
        { "<leader>n",       function() Snacks.notifier.show_history() end,                           desc = "Notification History", },
        { "<leader>bd",      function() Snacks.bufdelete() end,                                       desc = "Delete Buffer", },
        { "<leader>cR",      function() Snacks.rename.rename_file() end,                              desc = "Rename File", },
        { "<leader>gB",      function() Snacks.gitbrowse() end,                                       desc = "Git Browse",                   mode = { "n", "v" }, },
        { "<leader>gb",      function() Snacks.git.blame_line() end,                                  desc = "Git Blame Line", },
        { "<leader>gf",      function() Snacks.lazygit.log_file() end,                                desc = "Lazygit Current File History", },
        { "<leader>gg",      function() Snacks.lazygit() end,                                         desc = "Lazygit", },
        { "<leader>gl",      function() Snacks.lazygit.log() end,                                     desc = "Lazygit Log (cwd)", },
        { "<leader>un",      function() Snacks.notifier.hide() end,                                   desc = "Dismiss All Notifications", },
        { "<c-/>",           function() Snacks.terminal() end,                                        desc = "Toggle Terminal", },
        { "<c-_>",           function() Snacks.terminal() end,                                        desc = "which_key_ignore", },
        { "<leader>tF",      function() Snacks.terminal.open(nil, { win = { style = "float" } }) end, desc = "Toggle Terminal", },
        { "]]",              function() Snacks.words.jump(vim.v.count1) end,                          desc = "Next Reference",               mode = { "n", "t" }, },
        { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                         desc = "Prev Reference",               mode = { "n", "t" }, },
        { "<leader>qp",      function() Snacks.picker.projects() end,                                 desc = "Projects", },
        { "<leader><space>", function() Snacks.picker.files() end,                                    desc = "Find Files", },
        { "<leader>gc",      function() Snacks.picker.git_log() end,                                  desc = "Git Log", },
        { "<leader>gs",      function() Snacks.picker.git_status() end,                               desc = "Git Status", },
        { "<leader>fg",      function() Snacks.picker.git_files() end,                                desc = "Find Git Files", },
        { "<leader>E",       function() Snacks.picker.explorer() end,                                 desc = "File Explorer", },
        { "<leader>sb",      function() Snacks.picker.lines() end,                                    desc = "Buffer Lines" },
        { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                             desc = "Grep Open Buffers" },
        { "<leader>sg",      function() Snacks.picker.grep() end,                                     desc = "Grep" },
        { "<leader>sw",      function() Snacks.picker.grep_word() end,                                desc = "Visual selection or word",     mode = { "n", "x" } },
    },
    -- stylua: ignore stop
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle
                    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle
                    .option("background", { off = "light", on = "dark", name = "Dark Background" })
                    :map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })
    end,
}
