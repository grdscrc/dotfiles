inoremap <c-c> <esc>:undo<cr>

nmap <c-h> :set hlsearch!<CR>

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
nnoremap <Leader>N :enew<CR>
nnoremap <Leader>q :copen<CR>
nnoremap <Leader>Q :cclose<CR>
nnoremap <Leader>S :set syntax=
nnoremap <Leader>W :write!<CR>
nnoremap <Leader>B :buffers<CR>:buffer<Space>
nnoremap <Leader>d :bdelete<CR>
nnoremap <Leader>D :bufdo bd<CR>
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>rR :let @"=@0 \| let @0=@1 \| let @1=@2 \| let @2=@3 \| register " 0 1 2<CR>
nnoremap <Leader>rr :let @x=@" \| let @"=@a \| let @a=@b \| let @b=@x \| register " 0 a b<CR>
nnoremap <Leader>rf :let @f=@%<bar>echo @f<CR>
nnoremap <Leader>rp :r !pbpaste<CR>
nnoremap <Leader>ry :<C-u>call system("pbcopy", @0)<bar>echo @0<CR>
nnoremap <Leader>s :split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :close<CR>
" z like Zoom
nnoremap <Leader>z :only<CR>

nnoremap <c-n> *
nnoremap <c-p> #

" folding improvements
" display foldlevel on `zm`/`zr`
" allow repeat with `z;`/undo with `zu`
let folddirection=0
nnoremap <expr> z; folddirection>0 ? 'zm:set foldlevel?<CR>' : 'zr:set foldlevel?<CR>'
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
nmap <c-t>t :terminal<CR>
nmap <c-t>v :vertical terminal<CR>
nmap <c-t><space> :FloatermNew<CR>
nmap <c-t>n :FloatermNew node<CR>
nmap <c-t>g :FloatermNew sgpt --repl chat<CR>

" fzf-vim
nnoremap <Leader>f/ :BLines<CR>
nnoremap <Leader>f: :History:<CR>
nnoremap <Leader>f; :History/<CR>
nnoremap <Leader>fo :Files<CR>
nnoremap <Leader>fO :Files ~<CR>
nnoremap <Leader>f. :Files ~/dotfiles<CR>
nnoremap <Leader>fa :Ag<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fe :GFiles<CR>
nnoremap <Leader>fg :GFiles?<CR>
nnoremap <Leader>ff :FzfFunky<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fk :Rg<CR>
nnoremap K :Rg <C-R>=expand('<cword>')<CR><CR>
" :Index shows index.txt (with all key-combinations) using fzf-vim
command! Index silent execute ":help index.txt" | silent execute ":BLines!"
nnoremap <Leader>fi :Index<CR>
command! -bang -nargs=* GCheckout
      \ call fzf#run({
      \ 'source':  'git branch --sort=-committerdate --format="%(refname:short)"',
      \ 'sink':    '!git checkout',
      \ 'options': '--ansi',
      \ 'down':    '40%'}) |
      \ execute ":Git status"
nnoremap <Leader>fc :GCheckout<CR>

imap <c-x>w <plug>(fzf-complete-word)
imap <c-x>p <plug>(fzf-complete-path)
imap <c-x>l <plug>(fzf-complete-line)

" fugitive.vim
nnoremap <Leader>GG :Gedit :<CR>
nnoremap <Leader>Gl :Gclog<CR>

" GitGutter.vim
nnoremap <Leader>g/ /[<bar><>=]\{7}<CR>
nnoremap <Leader>gV :bdelete gitgutter<CR>
nnoremap <Leader>gC :bdelete gitgutter<CR>
nnoremap <Leader>gg :GitGutter<CR>
nnoremap <Leader>gn :GitGutterNextHunk<CR>
nnoremap <Leader>gp :GitGutterPrevHunk<CR>
nnoremap <Leader>gs :GitGutterStageHunk<CR>
nnoremap <Leader>gv :GitGutterPreviewHunk<CR>
nnoremap <Leader>gc :GitGutterPreviewHunk<CR>
nnoremap <Leader>gx :GitGutterUndoHunk<CR>
nnoremap <Leader>ge :GFiles?<CR>

" ale.vim
nnoremap gR :ALERename<CR>
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gh :ALEHover<CR>
nnoremap gr :ALEFindReferences<CR>

command! InsDate call append(line('.'), strftime('%c'))
command! InsTime call append(line('.'), strftime('%s000'))

command! DateToTime call YankDateTimeToTimestamp()
function! YankDateTimeToTimestamp()
    let datetime = expand('<cWORD>')
    let timestamp = str2nr(strftime('%s', datetime))
    echom timestamp
    call setreg('+', timestamp)
endfunction
command! TimeToDate call YankTimestampToDateTime()
function! YankTimestampToDateTime()
    let timestamp = expand('<cword>')
    let datetime = strftime('%c', str2nr(timestamp))
    echom datetime
    call setreg('+', datetime)
endfunction
