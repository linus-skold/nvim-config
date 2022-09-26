call plug#begin('~/AppData/Local/nvim/plugged')

" Themes
Plug 'joshdick/onedark.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fratajczak/one-monokai-vim'

" file explorer tree
Plug 'kyazdani42/nvim-web-devicons' " icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'ctrlpvim/ctrlp.vim'


" Searching 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag':'0.1.x'}

" Language services 
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'autozimu/LanguageClient-neovim', { 'branch':'next', 'do': 'bash install.sh' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'} 

call plug#end()

set number
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:LanguageClient_serverCommands = { 'rust':['rust-analyzer'] }

:execute "GuiFont! FiraCode Nerd Font Mono:h" . 10


lua require'telescope'.setup({})

inoremap <C-v> <C-o>:<C-r>+

nnoremap <C-u> :FZF<CR> 

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

execute printf('source %s/core/%s', stdpath('config'), 'nvim-tree.vim')

lua require'nvim-tree'.setup()
" lua require'telescope'.setup { defaults = { mappings = { i = { ["<C-h>"] } } }, pickers = {  }, extensions = { } }

" lua require'lspconfig'.rust-analyzer.setup({})

if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({ 
                \ 'name':'Rust Language Server', 
                \ 'cmd': {server_info->['rust_analyzer']}, 
                \ 'whitelist':['rust'] 
                \ }) 
endif

set tabstop=4
set shiftwidth=4
set expandtab

" syntax on
" colorscheme one-monokai

"  highlight Normal ctermbg=NONE guibg=NONE
"  highlight NonText ctermbg=NONE guibg=NONE
"  highlight SignColumn ctermbg=NONE guibg=NONE
