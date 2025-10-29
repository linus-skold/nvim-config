vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.syntax = "on"

require('user/plugins')
require("plugins/theme")
require('plugins/bufferline')
require("plugins/mason")
require("plugins/lualine")
require("mini.sessions").setup()
require("mini.completion").setup()
require("mini.bracketed").setup()
require("mini.comment").setup()

vim.opt.listchars = { space = '.', tab = '>-' }
vim.opt.list = true

require("user/keymap")

vim.api.nvim_command("hi Normal guibg=NONE")
vim.api.nvim_command("hi NormalNC guibg=NONE")
vim.api.nvim_command("hi SignColumn guibg=NONE")

-- Disable mini.completion in Snacks.nvim prompts
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'snacks_picker_input', 'snacks_files', 'snacks_pick', 'prompt' },
  callback = function()
    vim.b.minicompletion_disable = true
  end,
})

