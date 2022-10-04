vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.syntax = "on"
-- vim.opt.colorscheme = "one-monokai"

if jit.os == 'Windows' then
    vim.cmd("source ~/AppData/Local/nvim/user/plugins.vim")
    vim.cmd("source ~/AppData/Local/nvim/user/keymap.vim")
elseif jit.os == 'OSX' then
    require('/user/plugins')
    vim.cmd("source ~/.config/nvim/lua/user/keymap.vim")
end

vim.keymap.set("i", "<C-p>", "CtrlP", {desc = "bruh"})

vim.api.nvim_command [[colorscheme one-monokai"]]
-- let g:ctrlp_map = '<c-p>'
-- let g:ctrlp_cmd = 'CtrlP'
-- let g:LanguageClient_serverCommands = { 'rust':['rust-analyzer'] }

require("telescope").setup({})
require("telescope").load_extension("projects")
require("project_nvim").setup()
require("nvim-treesitter.configs").setup { 
    highlight = { 
        enable = true
    }
}
-- execute printf('source %s/core/%s', stdpath('config'), 'nvim-tree.vim')

require("nvim-tree").setup(
    {
        sort_by = "case_sensetive",
        view = {
            adaptive_size = true
        },
        renderer = {
            indent_markers = {
                enable = false
            },
            highlight_git = true,
            highlight_opened_files = trie,
            root_folder_modifier = ":~",
            add_trailing = true,
            group_empty = true,
            icons = {
                padding = " ",
                symlink_arrow = " >>"
            }
        },
        actions = {
            open_file = {
                window_picker = {
                    enable = true,
                    exclude = {
                        filetype = {"notify", "packer", "qf"},
                        buftype = {"terminal"}
                    }
                }
            }
        },
        respect_buf_cwd = true,
        create_in_closed_folder = false
    }
)

require('which-key').setup { }


vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

if jit.os == 'Windows' then
    vim.cmd("source ~/AppData/Local/nvim/init.vim")
elseif jit.os == 'OSX' then
    -- vim.cmd("source init.vim")
end

-- vim.cmd("colorscheme one-monokai")


