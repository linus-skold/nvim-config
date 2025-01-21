-- vim.g.mapleader = ','
-- vim.g.maplocalleader = ','
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.syntax = "on"



require('user/plugins')

require("plugins/theme")


require("plugins/mason")
require("plugins/lualine")
require("plugins/telescope")
-- require("plugins/nvim-tree")
require("plugins/bufferline")
require("plugins/which-key")

require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}

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

-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--    pattern = "*.cshtml",
--    command = "set filetype=html.cshtml.razor"
-- })
--
-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--    pattern = "*.razor",
--    command = "set filetype=html.cshtml.razor"
-- })

-- vim.api.nvim_set_keymap("i", "<Esc>", "<Nop>", { noremap = true })
