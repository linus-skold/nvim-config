
function remap(mode, keybinding, command, options) 
    vim.api.nvim_set_keymap(mode, keybinding, command, options)
end

-- -- Insert mode mapping
-- vim.api.nvim_set_keymap("i", "<C-v>", "<C-o>:<C-r>+", {})

-- -- Terminal mode mapping
-- vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-N>", {})

-- -- Normal mode mappings with silent option
remap("n", "<A-.>", "<cmd>bnext<CR>", { silent = true, desc = 'Next buffer' } )
remap("n", "<A-,>", "<cmd>bprevious<CR>", { silent = true, desc = 'Previous buffer' } )
remap("n", "<A-c>", "<cmd>bd<CR>", { silent = true, desc = 'Close buffer' } )
