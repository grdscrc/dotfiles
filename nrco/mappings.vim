inoremap <c-c> <esc>:undo<cr>

nmap <c-t>f :FloatermNew<CR>
nmap <c-t>n :FloatermNew node<CR>
nmap <c-t>v :vertical terminal<CR>

nnoremap <C-w>. 20<C-w>>
nnoremap <Leader>/ :History/<CR>
nnoremap <Leader>; :History:<CR>
nnoremap <Leader><C-d> yiw/<Bslash>v<C-r>0.*(<Bslash>{<Bar><Bslash>=<Bar>:)<CR>
nnoremap <Leader><Leader> :
nnoremap <Leader>D :tabclose<CR>
nnoremap <Leader>E :GFiles?<CR>
nnoremap <Leader>Fj :%!jq .<CR>
nnoremap <Leader>Fx :%!xmllint --format -<CR>
nnoremap <Leader>J :tabnext<CR>
nnoremap <Leader>K :tabprev<CR>
nnoremap <Leader>L :lclose<CR>
nnoremap <Leader>N :ene<CR>
nnoremap <Leader>O :Files ~<CR>
nnoremap <Leader>Q :cclose<CR>
nnoremap <Leader>S :set syntax=
nnoremap <Leader>S :split<bar>GFiles<CR>
nnoremap <Leader>T :tabnew<bar>GFiles<CR>
nnoremap <Leader>V :vsplit<bar>GFiles?<CR>
nnoremap <Leader>W <C-w>p
nnoremap <Leader>a :Ag<CR>
nnoremap <Leader>b :buffers<CR>
nnoremap <Leader>c :Colors<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>e :GFiles<CR>
nnoremap <Leader>f :BLines<CR>
nnoremap <Leader>g :Gedit :<CR>
nnoremap <Leader>h :Helptags<CR>
nnoremap <Leader>i :Index<CR>
nnoremap <Leader>j )
nnoremap <Leader>k (
nnoremap <Leader>l :lopen<CR>
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>q :copen<CR>
nnoremap <Leader>rR :let @"=@0 \| let @0=@1 \| let @1=@2 \| let @2=@3 \| register " 0 1 2<CR>
nnoremap <Leader>rr :let @x=@" \| let @"=@a \| let @a=@b \| let @b=@x \| register " 0 a b<CR>
nnoremap <Leader>rf :let @f=@%<CR>
nnoremap <Leader>rp :r !pbpaste<CR>
nnoremap <Leader>ry :<C-u>call system("pbcopy", @0)<CR>
nnoremap <Leader>s :split<CR>
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>w <C-w>w
nnoremap <Leader>x :close<CR>

nnoremap <c-g>/ /[<bar><>=]\{7}<CR>
nnoremap <c-g><c-g> <c-g>
nnoremap <c-g>V :bdelete gitgutter<CR>
nnoremap <c-g>C :bdelete gitgutter<CR>
nnoremap <c-g>g :GitGutter<CR>
nnoremap <c-g>n :GitGutterNextHunk<CR>
nnoremap <c-g>p :GitGutterPrevHunk<CR>
nnoremap <c-g>s :GitGutterStageHunk<CR>
nnoremap <c-g>v :GitGutterPreviewHunk<CR>
nnoremap <c-g>c :GitGutterPreviewHunk<CR>
nnoremap <c-g>x :GitGutterUndoHunk<CR>

nnoremap <c-n> *
nnoremap <c-p> #

nnoremap <expr> z; folddirection>0 ? 'zm:set foldlevel?<CR>' : 'zr:set foldlevel?<CR>'
nnoremap <expr> zu folddirection>0 ? 'zr:set foldlevel?<CR>' : 'zm:set foldlevel?<CR>'

nnoremap Z1 :2,$bd<CR>
nnoremap ZA :%bdelete<CR>
nnoremap ZF :bdelete<bar>FZF<CR>
nnoremap ZX :hide<CR>
nnoremap ZZ :bdelete<CR>
nnoremap Z\ :1, $-1bd<CR>
nnoremap g/ /\<\><Left><Left>
nnoremap gR :ALERename<CR>
nnoremap gS :%s///g<Left><Left><Left>
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gh :ALEHover<CR>
nnoremap gr :ALEFindReferences<CR>
nnoremap zm :let folddirection=+1<CR>zm:set foldlevel?<CR>
nnoremap zr :let folddirection=-1<CR>zr:set foldlevel?<CR>

vmap <C-n> y/<C-r>"<CR>
vmap <C-p> y?<C-r>"<CR>
