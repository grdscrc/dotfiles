" source ~/dotfiles/plug.vim

" Use fzf (fuzzy search)
set rtp+=/usr/local/opt/fzf

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['dir', 'tag', 'line', 'buffertag']
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f'] " Use command instead of Vim's globpath()

Bundle 'nikvdp/ejs-syntax'

source ~/dotfiles/visual-at.vim

runtime macros/matchit.vim " % to bounce from do to end etc.
