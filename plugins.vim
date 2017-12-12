" source ~/dotfiles/plug.vim

" Use fzf (fuzzy search)
set rtp+=/usr/local/opt/fzf

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['line', 'dir', 'buffertag', 'tag']

Bundle 'nikvdp/ejs-syntax'

source ~/dotfiles/visual-at.vim

runtime macros/matchit.vim " % to bounce from do to end etc.
