let mapleader = "\<Space>"

source ~/dotfiles/nrco/opts.vim
source ~/dotfiles/nrco/plugs.vim  " Before mappings so they can call <Plug>
source ~/dotfiles/nrco/mappings.vim
source ~/dotfiles/nrco/highlight.vim
source ~/dotfiles/nrco/functions.vim

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd InsertEnter * set cursorline cursorcolumn list
autocmd InsertLeave * set nocursorline nocursorcolumn nolist

autocmd FileType bash setlocal iskeyword-=$
autocmd FileType perl setlocal iskeyword+=$

colorscheme OceanicNext

syntax match jsonKey "\<\w\+\ze\s*:\s*" contained
highlight link jsonKey Type
syntax match jsonString '"[^"]*"' contained
highlight link jsonString String

" auto-clear prompt on inactivity
autocmd CursorHold * echo
" autocmd TextYankPost * echo len(getreg(v:register))"chars,"len(split(getreg(v:register), '\n'))"lines, <yank>"substitute(getreg(v:register), '\n', ' // ', 'g')[0:50]"</yank>"

let g:fzf_preview_window = ['up:10']
let g:ranger_map_keys = 1 

" Copilot disable
