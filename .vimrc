set lbr

function! s:Saving_scroll(cmd)
  let save_scroll = &scroll
  execute 'normal! ' . a:cmd
  let &scroll = save_scroll
endfunction
nnoremap <C-J> :call <SID>Saving_scroll("1<C-V><C-D>")<CR>
vnoremap <C-J> <Esc>:call <SID>Saving_scroll("gv1<C-V><C-D>")<CR>
nnoremap <C-K> :call <SID>Saving_scroll("1<C-V><C-U>")<CR>
vnoremap <C-K> <Esc>:call <SID>Saving_scroll("gv1<C-V><C-U>")<CR>

set ignorecase
set smartcase

" enable syntax highlighting
syntax on

" insert spaces instead of tabs
set expandtab

" enable automatic indentation
set autoindent

" >> and << shift 4 spaces
set shiftwidth=2

" <tab> inserts 4 spaces
set tabstop=2

set backspace=indent,eol,start

" keystrokes which may wrap around lines:
"   b          backspace
"   s          space
"   <,>,h,l    arrow keys
"   [,]        arrow keys in insert mode
set whichwrap=b,s,<,>,h,l,[,]

" when truncating the last line in a window, display @
" symbols at the end of the line, instead of one per line
set display=lastline

" show line numbers
set number

" turn on search highlighting
set hls

" save (^\ exits visual mode)
inoremap <F12> <Space><BS><C-\><C-O>:update<CR>

set incsearch

filetype on

filetype plugin on

set ttymouse=xterm2
set mouse=a
