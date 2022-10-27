vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.syntax = "on"
-- vim.opt.colorscheme = "one-monokai"

require('/user/plugins')

if jit.os == 'Windows' then
	vim.cmd("source ~/AppData/Local/nvim/lua/user/keymap.vim")
elseif jit.os == 'OSX' then
    vim.cmd("source ~/.config/nvim/lua/user/keymap.vim")
end

require('one_monokai').setup({
	use_cmd = true
})
require('lualine').setup({
    options = {
        theme = 'one_monokai'
    }
})

require("telescope").setup({})
require("telescope").load_extension("projects")
require("project_nvim").setup()
require("nvim-treesitter.configs").setup { 
    highlight = { 
        enable = true,
        disable = { "txt" }
    }
}

require("bufferline").setup{}

require("nvim-tree").setup(
    {
        sync_root_with_cwd = true,
        respect_root_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = true
        },
        sort_by = "case_sensetive",
        view = {
            adaptive_size = true
        },
        renderer = {
            indent_markers = {
                enable = false
            },
            highlight_git = true,
            highlight_opened_files = "all",
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

require('lspconfig')['rust_analyzer'].setup({

})


require('which-key').setup { }


vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- vim.api.nvim_set_keymap('n', '<leader>fp', ":lua require'telescope'.extensions.projects{<CR>", { noremap = true, silent = true })
