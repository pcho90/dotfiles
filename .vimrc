
call plug#begin()

Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

call plug#end()

set background=dark
set hidden
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nobackup
set number
set showcmd
set backspace=indent,eol,start
set showmatch
set nohlsearch
set ignorecase
set smartcase
set incsearch
set nowrap
set noerrorbells
set wildmenu
set clipboard=unnamed
set fillchars=fold:\ ,vert:\│
set splitbelow
set splitright
set termguicolors

syntax on
colorscheme onedark
hi Normal guibg=NONE ctermbg=NONE

