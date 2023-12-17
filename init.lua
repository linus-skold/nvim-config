vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.syntax = "on"

require('/user/plugins')

require('coc')

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
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
    auto_install = true,
    highlight = { 
        enable = true,
        disable = { "txt" }
    }
}

require("nvim-tree").setup{ 
        sync_root_with_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = true
        },
        sort = { 
            -- could be a custom function as well.
            sorter = "case_sensitive"
            -- sorter = function(nodes) table.sort(nodes, function(a,b) return #a.name < #b.name end) end
        },
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
        respect_buf_cwd = true,
        create_in_closed_folder = false
    }



require("bufferline").setup{
    options = {
        --mode = 'tabs',
        offsets = {
            filetype = "NvimTree",
            text = "File explorer",
            separator = true,
            text_align = "center"
    	}
	}
}

require('lspconfig')['rust_analyzer'].setup({ })

require('which-key').setup { }

vim.opt.listchars = { space = '.', tab = '>-' }
vim.opt.list = true

if jit.os == 'Windows' then
	vim.cmd("source ~/AppData/Local/nvim/lua/user/keymap.vim")
elseif jit.os == 'OSX' then
    vim.cmd("source ~/.config/nvim/lua/user/keymap.vim")
end
