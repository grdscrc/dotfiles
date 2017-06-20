let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>e :enew<CR>
nnoremap <Leader>x :bdelete<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>n :bnext<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

imap jk <Esc>

" set backupdir=~/.vim/backup/
" set directory=~/.vim/swap/
" set undodir=~/.vim/undo/

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch

  colorscheme desert
  set bs=2
  set ai
  set ruler
endif

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
