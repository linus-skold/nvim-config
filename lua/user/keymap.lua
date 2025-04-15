
-- function remap(mode, key, result, options)
--   vim.api.nvim_set_keymap(mode, key, result, options)
-- end



-- -- Insert mode mapping
-- vim.api.nvim_set_keymap("i", "<C-v>", "<C-o>:<C-r>+", {})

-- -- Normal mode mappings
-- vim.api.nvim_set_keymap("n", "<C-u>", ":FZF<CR>", {})
-- vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {})
-- vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", {})
-- vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {})
-- vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {})
-- vim.api.nvim_set_keymap("n", "<leader>fp", "<cmd>Telescope projects<cr>", {})
-- vim.api.nvim_set_keymap("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", {})

-- -- Terminal mode mapping
-- vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-N>", {})

-- -- Normal mode mappings with silent option
vim.api.nvim_set_keymap("n", "<A-c>", "<cmd>BufferClose<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-,>", "<Cmd>bprevious<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-.>", "<Cmd>bnext<CR>", { silent = true })


--remap("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { silent = true })





-- ""nnoremap <silent>    <[-b> <Cmd>Bu

-- " nnoemap <silent>    <tab> <Cmd>coc#pum#accept()

-- " nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
-- " nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
-- " nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- " nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
-- " nnoremap <leader>fp <cmd>lua require('telescope.builtin').projects()<cr>
