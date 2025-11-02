function remap(mode, keybinding, command, options)
	options = options or { noremap = true, silent = true }
	if type(command) == "string" then
		command = "<cmd>" .. command .. "<CR>"
	end
	vim.keymap.set(mode, keybinding, command, options)
end

function nremap(keybinding, command, options)
	remap("n", keybinding, command, options)
end

function imemap(keybinding, command, options)
	remap("i", keybinding, command, options)
end

function tremap(keybinding, command, options)
	remap("t", keybinding, command, options)
end

function vremap(keybinding, command, options)
	remap("v", keybinding, command, options)
end

-- -- Insert mode mapping
-- vim.api.nvim_set_keymap("i", "<C-v>", "<C-o>:<C-r>+", {})

-- -- Terminal mode mapping
-- vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-N>", {})

-- Normal mode mappings
nremap("<A-.>", "bnext", { desc = "Next buffer" })
nremap("<A-,>", "bprevious", { desc = "Previous buffer" })
nremap("<A-c>", "bd", { desc = "Close buffer" })

-- nremap("gh", "Lspsaga finder", {  desc = 'LSP Finder' } )
-- nremap("gd", "Lspsaga goto_definition", {  desc = 'Go to Definition' } )
-- nremap("gr", "Lspsaga rename", {  desc = 'Rename Symbol' } )

nremap("<leader>e", function()
	vim.diagnostic.open_float(0, { scope = "line", focusable = false })
end, { desc = "Show line diagnostics" })

-- Yank to system clipboard
vremap("<leader>Y", '"+yy', { desc = "Yank to system clipboard" })
