inoremap <c-c> <esc>:undo<cr>

nmap <c-h> :set hlsearch!<CR>

nmap <c-t><c-t> :terminal<CR>
nmap <c-t>v :vertical terminal<CR>

nnoremap <C-w>. 20<C-w>>
nnoremap <C-w>, 20<C-w><

nnoremap <Leader><Leader> :
nnoremap <Leader><C-d> yiw/<Bslash>v<C-r>0(<Bslash> <Bar><Bslash>n)*(<Bslash>{<Bar><Bslash>=<Bar>:)<CR>
nnoremap <Leader>Fj :%!jq .<CR>
nnoremap <Leader>Fx :%!xmllint --format -<CR>
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>T :tabnew<bar>GFiles<CR>
nnoremap <Leader>X :tabclose<CR>
nnoremap <Leader>J :tabnext<CR>
nnoremap <Leader>K :tabprev<CR>
nnoremap <Leader>l :lopen<CR>
nnoremap <Leader>L :lclose<CR>
nnoremap <Leader>N :ene<CR>
nnoremap <Leader>q :copen<CR>
nnoremap <Leader>Q :cclose<CR>
nnoremap <Leader>S :set syntax=
nnoremap <Leader>W :w!<CR>
nnoremap <Leader>B :buffers<CR>:buffer<Space>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>D :bufdo bd<CR>
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>rR :let @"=@0 \| let @0=@1 \| let @1=@2 \| let @2=@3 \| register " 0 1 2<CR>
nnoremap <Leader>rr :let @x=@" \| let @"=@a \| let @a=@b \| let @b=@x \| register " 0 a b<CR>
nnoremap <Leader>rf :let @f=@%<CR>
nnoremap <Leader>rp :r !pbpaste<CR>
nnoremap <Leader>ry :<C-u>call system("pbcopy", @0)<CR>
nnoremap <Leader>s :split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :close<CR>

nnoremap <c-n> *
nnoremap <c-p> #

" folding improvements
" display foldlevel on `zm`/`zr`
" allow repeat with `z;`/undo with `zu`
let folddirection=0
nnoremap <expr> <M-f> folddirection>0 ? 'zm:set foldlevel?<CR>' : 'zr:set foldlevel?<CR>'
nnoremap <expr> zu folddirection>0 ? 'zr:set foldlevel?<CR>' : 'zm:set foldlevel?<CR>'
nnoremap zm :silent let folddirection=+1<CR>zm:set foldlevel?<CR>
nnoremap zr :silent let folddirection=-1<CR>zr:set foldlevel?<CR>

nnoremap ga <C-^>:echo "Alternate to " expand('#')<CR>
nnoremap g! :echo system('')<Left><Left>

vmap <C-n> y/<C-r>"<CR>
vmap <C-p> y?<C-r>"<CR>

nnoremap Z1 :2,$bd<CR>
nnoremap ZA :%bdelete<CR>
nnoremap ZF :bdelete<bar>FZF<CR>
nnoremap ZX :hide<CR>
nnoremap Z\ :1, $-1bd<CR>
nnoremap g/ /\<\><Left><Left>
nnoremap gS :%s///g<Left><Left><Left>

""" Plugs mappings
" floaterm.vim
nmap <c-t>f :FloatermNew<CR>
nmap <c-t>n :FloatermNew node<CR>


" fzf.vim
nnoremap <Leader>/ :History/<CR>
nnoremap <Leader>; :History:<CR>
nnoremap <Leader>E :GFiles?<CR>
nnoremap <Leader>O :Files ~<CR>
nnoremap <Leader>a :Ag<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :Colors<CR>
nnoremap <Leader>e :GFiles<CR>
nnoremap <Leader>f :BLines<CR>
nnoremap <Leader>g :Gedit :<CR>
nnoremap <Leader>h :Helptags<CR>
nnoremap <Leader>i :Index<CR>
nnoremap <Leader>k :Rg<CR>
nnoremap K :Rg <C-R>=expand('<cword>')<CR><CR>
nnoremap <Leader>o :Files<CR>
" :Index shows index.txt (with all key-combinations) using fzf-vim
command! Index silent execute ":help index.txt" | silent execute ":BLines!"


" GitGutter.vim
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

" ale.vim
nnoremap gR :ALERename<CR>
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gh :ALEHover<CR>
nnoremap gr :ALEFindReferences<CR>
