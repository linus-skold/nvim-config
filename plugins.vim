" Themes
Plug 'iCyMind/NeoSolarized'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fratajczak/one-monokai-vim'

" file explorer tree
Plug 'kyazdani42/nvim-web-devicons' " icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ahmedkhalf/project.nvim'


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


