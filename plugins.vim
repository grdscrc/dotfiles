" Use fzf (fuzzy search)
set rtp+=/usr/local/opt/fzf

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['line', 'dir', 'buffertag', 'tag']

Bundle 'nikvdp/ejs-syntax'
