let mapleader = "\<Space>"

source ~/dotfiles/nrco/opts.vim
source ~/dotfiles/nrco/plugs.vim  " Before mappings so they can call <Plug>
source ~/dotfiles/nrco/mappings.vim
source ~/dotfiles/nrco/highlight.vim
source ~/dotfiles/nrco/functions.vim

" folding improvements
" display foldlevel on `zm`/`zr`
" allow repeat with `z;`/undo with `zu`
" repeat fold with  `C-S` (single key for easy repeat)
let folddirection=0
" set statusline+=%F

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd InsertEnter * set cursorline cursorcolumn nohlsearch list
autocmd InsertLeave * set nocursorline nocursorcolumn hlsearch nolist



" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

colorscheme gruvbox

" inoremap jk <esc><Right>
" inoremap JK <esc>:undo<CR>
" inoremap jw <esc>:write<CR>

" Buffers
" Tabs
" Windows/splits




" Jump to definition

" nnoremap <Leader>G :Git<bar>wincmd H<bar>vertical resize 80<CR>


" fzf.vim
" :Index shows index.txt (with all key-combinations) using fzf-vim
command! Index silent execute ":help index.txt" | silent execute ":BLines!"

let g:fzf_preview_window = ['up:10']

" windows

" Remove current buffer
" Close window
" Replace current buffer with fzf
" Remove all buffers

autocmd CursorHold * echo
" autocmd TextYankPost * echo len(getreg(v:register))"chars,"len(split(getreg(v:register), '\n'))"lines, <yank>"substitute(getreg(v:register), '\n', ' // ', 'g')[0:50]"</yank>"


