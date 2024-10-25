nnoremap <C-H> :set hlsearch!<CR>
nnoremap zm :let folddirection=+1<CR>zm:set foldlevel?<CR>
nnoremap zr :let folddirection=-1<CR>zr:set foldlevel?<CR>
nnoremap <expr> z; folddirection>0 ? 'zm:set foldlevel?<CR>' : 'zr:set foldlevel?<CR>'
nnoremap <expr> zu folddirection>0 ? 'zr:set foldlevel?<CR>' : 'zm:set foldlevel?<CR>'
nnoremap <c-g><c-g> <c-g>
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gr :ALEFindReferences<CR>
nnoremap gh :ALEHover<CR>
nnoremap gR :ALERename<CR>
nnoremap <Leader><Leader> :
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>b :buffers<CR>
nnoremap <Leader>N :ene<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>J :tabnext<CR>
nnoremap <Leader>K :tabprev<CR>
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>T :tabnew<bar>GFiles<CR>
nnoremap <Leader>D :tabclose<CR>
nnoremap <Leader>w <C-w>w
nnoremap <Leader>W <C-w>p
nnoremap <Leader>s :split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>q :copen<CR>
nnoremap <Leader>l :lopen<CR>
nnoremap <Leader>Q :cclose<CR>
nnoremap <Leader>L :lclose<CR>
nnoremap <Leader>j )
nnoremap <Leader>k (
nnoremap g/ /\<\><Left><Left>
nnoremap gS :%s///g<Left><Left><Left>
nnoremap <Leader><C-d> yiw/<Bslash>v<C-r>0.*(<Bslash>{<Bar><Bslash>=<Bar>:)<CR>
nnoremap <Leader>g :Gedit :<CR>
nnoremap <Leader>e :GFiles<CR>
nnoremap <Leader>E :GFiles?<CR>
nnoremap <Leader>S :split<bar>GFiles<CR>
nnoremap <Leader>V :vsplit<bar>GFiles?<CR>
nnoremap <Leader>x :close<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>O :Files ~<CR>
nnoremap <Leader>f :BLines<CR>
nnoremap <Leader>a :Ag<CR>
nnoremap <Leader>; :History:<CR>
nnoremap <Leader>/ :History/<CR>
nnoremap <Leader>h :Helptags<CR>
nnoremap <Leader>c :Colors<CR>
nnoremap <Leader>i :Index<CR>
nnoremap <C-w>, 20<C-w><
nnoremap <C-w>. 20<C-w>>
nnoremap ZZ :bdelete<CR>
nnoremap Z1 :2,$bd<CR>
nnoremap Z\ :1, $-1bd<CR>
nnoremap ZX :hide<CR>
nnoremap ZF :bdelete<bar>FZF<CR>
nnoremap ZA :%bdelete<CR>
nnoremap <Leader>rR :let @"=@0 \| let @0=@1 \| let @1=@2 \| let @2=@3 \| register " 0 1 2<CR>
nnoremap <Leader>rf :let @f=@%<CR>
nnoremap <Leader>rp :r !pbpaste<CR>
nnoremap <Leader>Fx :%!xmllint --format -<CR>
nnoremap <Leader>Fj :%!jq .<CR>
nnoremap <Leader>S :set syntax=
nnoremap <C-H> :set hlsearch!<CR>
nnoremap zm :let folddirection=+1<CR>zm:set foldlevel?<CR>
nnoremap zr :let folddirection=-1<CR>zr:set foldlevel?<CR>
nnoremap <expr> z; folddirection>0 ? 'zm:set foldlevel?<CR>' : 'zr:set foldlevel?<CR>'
nnoremap <expr> zu folddirection>0 ? 'zr:set foldlevel?<CR>' : 'zm:set foldlevel?<CR>'
nnoremap <c-g><c-g> <c-g>
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gr :ALEFindReferences<CR>
nnoremap gh :ALEHover<CR>
nnoremap gR :ALERename<CR>
nnoremap <Leader><Leader> :
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>b :buffers<CR>
nnoremap <Leader>N :ene<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>J :tabnext<CR>
nnoremap <Leader>K :tabprev<CR>
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>T :tabnew<bar>GFiles<CR>
nnoremap <Leader>D :tabclose<CR>
nnoremap <Leader>w <C-w>w
nnoremap <Leader>W <C-w>p
nnoremap <Leader>s :split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>q :copen<CR>
nnoremap <Leader>l :lopen<CR>
nnoremap <Leader>Q :cclose<CR>
nnoremap <Leader>L :lclose<CR>
nnoremap <Leader>j )
nnoremap <Leader>k (
nnoremap g/ /\<\><Left><Left>
nnoremap gS :%s///g<Left><Left><Left>
nnoremap <Leader><C-d> yiw/<Bslash>v<C-r>0.*(<Bslash>{<Bar><Bslash>=<Bar>:)<CR>
nnoremap <Leader>g :Gedit :<CR>
nnoremap <Leader>e :GFiles<CR>
nnoremap <Leader>E :GFiles?<CR>
nnoremap <Leader>S :split<bar>GFiles<CR>
nnoremap <Leader>V :vsplit<bar>GFiles?<CR>
nnoremap <Leader>x :close<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>O :Files ~<CR>
nnoremap <Leader>f :BLines<CR>
nnoremap <Leader>a :Ag<CR>
nnoremap <Leader>; :History:<CR>
nnoremap <Leader>/ :History/<CR>
nnoremap <Leader>h :Helptags<CR>
nnoremap <Leader>c :Colors<CR>
nnoremap <Leader>i :Index<CR>
nnoremap <C-w>, 20<C-w><
nnoremap <C-w>. 20<C-w>>
nnoremap ZZ :bdelete<CR>
nnoremap Z1 :2,$bd<CR>
nnoremap Z\ :1, $-1bd<CR>
nnoremap ZX :hide<CR>
nnoremap ZF :bdelete<bar>FZF<CR>
nnoremap ZA :%bdelete<CR>
nnoremap <Leader>rR :let @"=@0 \| let @0=@1 \| let @1=@2 \| let @2=@3 \| register " 0 1 2<CR>
nnoremap <Leader>rf :let @f=@%<CR>
nnoremap <Leader>rp :r !pbpaste<CR>
nnoremap <Leader>Fx :%!xmllint --format -<CR>
nnoremap <Leader>Fj :%!jq .<CR>
nnoremap <Leader>S :set syntax=

inoremap <c-c> <esc>:undo<cr>
nmap <C-n> *
nmap <C-p> #
vmap <C-n> y/<C-r>"<CR>
vmap <C-p> y?<C-r>"<CR>
noremap <Leader>rr :let @x=@" \| let @"=@a \| let @a=@b \| let @b=@x \| register " 0 a b<CR>
xnoremap <silent> <Leader>ry :w !pbcopy<CR>
