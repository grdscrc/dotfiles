let mapleader = "\<Space>"

source ~/dotfiles/nrco/opts.vim
source ~/dotfiles/nrco/plugs.vim  " Before mappings so they can call <Plug>
source ~/dotfiles/nrco/mappings.vim
source ~/dotfiles/nrco/highlight.vim
source ~/dotfiles/nrco/functions.vim

autocmd InsertEnter * set cursorline cursorcolumn list
autocmd InsertLeave * set nocursorline nocursorcolumn nolist

autocmd FileType bash setlocal iskeyword-=$
autocmd FileType perl setlocal iskeyword+=$

colorscheme OceanicNext


" auto-clear prompt on inactivity
autocmd CursorHold * echo
" autocmd TextYankPost * echo len(getreg(v:register))"chars,"len(split(getreg(v:register), '\n'))"lines, <yank>"substitute(getreg(v:register), '\n', ' // ', 'g')[0:50]"</yank>"

let g:fzf_preview_window = ['up:10']
let g:ranger_map_keys = 1 

" Copilot disable
