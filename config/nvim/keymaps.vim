scriptencoding utf-8

nnoremap <Up> <C-y>
nnoremap <Down> <C-e>

" Opens line below or above the current line
inoremap <S-CR> <C-O>o
inoremap <C-CR> <C-O>O

" Run the last command
nnoremap <space><space>c :<up>

" Remove whitespace
nnoremap <space>sws :%s/\s\+$//<CR>

" Easier Moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make windows to be basically the same size
nnoremap <space>= <C-w>=

" Sizing window horizontally
nnoremap <c-,> <C-W><
nnoremap <c-.> <C-W>>
nnoremap <A-,> <C-W>5<
nnoremap <A-.> <C-W>5>

" Sizing window vertically
" taller
nnoremap <A-t> <C-W>+

" shorter
nnoremap <A-s> <C-W>-

" Move easily to the next error
nnoremap <space>l :lnext<CR>
nnoremap <space>h :lprevious<CR>

" Undo toggle
nnoremap <space>ut :GundoToggle<cr>

" Helpful delete/change into blackhole buffer
nmap <space>d "_d
nmap <space>c "_c
nmap <space>d "_d
nmap <space>c "_c

" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

" Change the current word in insertmode.
" Auto places you into the spot where you can start typing to change it.
nnoremap <c-w><c-r> :%s/<c-r><c-w>//g<left><left>

" Shrug ¯\_(ツ)_/¯
inoremap ,shrug ¯\_(ツ)_/¯
nnoremap <space>sh <cmd>TSHighlightCapturesUnderCursor<CR>

