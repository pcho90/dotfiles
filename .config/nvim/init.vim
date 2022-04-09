
let mapleader=','

call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sainnhe/edge'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

set pumblend=15
set pumheight=20
set cmdheight=1
set showcmd
set incsearch
set showmatch
set number
set ignorecase
set smartcase
set hidden
set splitright
set splitbelow
set updatetime=1000
set nohlsearch
set scrolloff=8
set sidescrolloff=8
set autoindent
set smartindent
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set undofile
set noswapfile
set clipboard+=unnamed
set noerrorbells
set lazyredraw
set nobackup
set fillchars=fold:\ ,vert:\│,eob:\ ,
set listchars=trail:\ ,
set list
set mouse=a
set termguicolors
set matchpairs+=<:>


colorscheme edge

nnoremap <silent> <leader>fg :Rg<cr>
nnoremap <silent> <leader>fw :BLines<cr>
nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>fb :Buffers<cr>

au TextYankPost * lua vim.highlight.on_yank {on_visual = false}

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_layout = { 'down': '40%' }
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
let grep_spec = 'rg --column --line-number --no-heading --color=always --smart-case '
let fzf_preview_spec = {'options': '--delimiter : --nth 4..'}
command! -bang -nargs=* Rg call fzf#vim#grep(grep_spec.shellescape(<q-args>), 1, fzf#vim#with_preview(fzf_preview_spec), <bang>0)

let g:airline_powerline_fonts = 1

hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

