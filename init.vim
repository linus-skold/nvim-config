
execute "source" '~/AppData/Local/nvim//user/plugins.vim'
execute "source" '~/AppData/Local/nvim/user/keymap.vim'

lua require'~/AppData/Local/nvim/user/init.lua'


"  set number
"  let g:ctrlp_map = '<c-p>'
"  let g:ctrlp_cmd = 'CtrlP'
"  let g:LanguageClient_serverCommands = { 'rust':['rust-analyzer'] }



"  lua require'telescope'.setup({})
"  execute printf('source %s/core/%s', stdpath('config'), 'nvim-tree.vim')

"  lua require'nvim-tree'.setup({
"      sort_by = "case_sensetive",
"      view = { 
"          adaptive_size = true,
"      },
"      renderer = {
"          indent_markers.enable = false,
"          highlight_git = true,
"          highlight_opened_files = trie,
"          root_folder_modifier = ":~",
"          add_trailing = true,
"          group_empty = true,
"          icons = { 
"              padding = ' ',
"              symlink = ' >>'
"          }
"      },
"      actions = {
"          open_file = { 
"              window_picker = {
"                  enable = true,
"                  exclude = {
"      \   'filetype': [
"      \     'notify',
"      \     'packer',
"      \     'qf'
"      \   ],
"      \   'buftype': [
"      \     'terminal'
"      \   ]
"      \ }
"              }
"          }
"      },
"      respect_buf_cwd = true,
"      create_in_closed_folder = false,

"  })
"  lua require'project_nvim'.setup()

"  lua require'telescope'.load_extension('projects')


"  " lua require'telescope'.setup { defaults = { mappings = { i = { ["<C-h>"] } } }, pickers = {  }, extensions = { } }

"  " lua require'lspconfig'.rust-analyzer.setup({})

"  if executable('rust-analyzer')
"      au User lsp_setup call lsp#register_server({ 
"                  \ 'name':'Rust Language Server', 
"                  \ 'cmd': {server_info->['rust_analyzer']}, 
"                  \ 'whitelist':['rust'] 
"                  \ }) 
"  endif

"  set tabstop=4
"  set shiftwidth=4
"  set expandtab

"  syntax on
"  colorscheme one-monokai

"  " highlight Normal ctermbg=NONE guibg=NONE
"  " highlight NonText ctermbg=NONE guibg=NONE
"  " highlight SignColumn ctermbg=NONE guibg=NONE

"  " set shm+=I

