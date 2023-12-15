" Themes
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fratajczak/one-monokai-vim'
Plug 'cpea2506/one_monokai.nvim'
Plug 'navarasu/onedark.nvim'

Plug 'nvim-lualine/lualine.nvim'


" file explorer tree
Plug 'kyazdani42/nvim-web-devicons' " icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ahmedkhalf/project.nvim'
"Plug 'romgrk/barbar.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

" Searching 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag':'0.1.x'}

" Language services 
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'autozimu/LanguageClient-neovim', { 'branch':'next', 'do': 'powershell -executionpolicy bypass -File install.ps1' }
Plug 'neovim/nvim-lspconfig'
Plug 'liuchengxu/vista.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
" Debugger stuff
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" Utils
Plug 'folke/which-key.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch':'release'}
