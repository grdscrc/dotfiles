inoremap <c-c> <esc>:undo<cr>

nmap <c-h> :set hlsearch!<CR>

nnoremap <C-w>. 20<C-w>>
nnoremap <C-w>, 20<C-w><

nnoremap <Leader><Leader> :

" Search cword in all files
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
nnoremap <Leader>s :split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :close<CR>
" Close all windows except current (z like Zoom)
nnoremap <Leader>z :only<CR>
" List mappings in buffer
nnoremap <Leader>m :redir @m <bar> vnew <bar> silent map <bar> redir END <bar> put m <bar> silent file mappings <bar> silent set readonly syntax=vim <bar>normal gg<CR>

" Rotate registers 0, 1, 2
nnoremap <Leader>rR :let @"=@0 \| let @0=@1 \| let @1=@2 \| let @2=@3 \| register " 0 1 2<CR>
nnoremap <Leader>rr :let @x=@" \| let @"=@a \| let @a=@b \| let @b=@x \| register " 0 a b<CR>
" Store filename into register f
nnoremap <Leader>rf :let @f=@%<bar>echo @f<CR>
" Read from system clipboard
nnoremap <Leader>rp :r !pbpaste<CR>
" Store last yanked register to system clipboard
nnoremap <Leader>ry :<C-u>call system("pbcopy", @0)<bar>echo @0<CR>
" Revert order of next 3 words
nnoremap <Leader>r3 "jdw"kdwe"kp"jp

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
nnoremap <Tab>/ :BLines<CR>
nnoremap <Tab>: :History:<CR>
nnoremap <Tab>; :History/<CR>
nnoremap <Tab>o :Files<CR>
nnoremap <Tab>O :Files ~<CR>
nnoremap <Tab>. :Files ~/dotfiles<CR>
nnoremap <Tab>a :Ag<CR>
nnoremap <Tab>b :Buffers<CR>
nnoremap <Tab>e :GFiles<CR>
nnoremap <Tab>g :GFiles?<CR>
nnoremap <Tab>f :FzfFunky<CR>
nnoremap <Tab>h :Helptags<CR>
nnoremap <Tab>k :Rg<CR>
nnoremap K :Rg <C-R>=expand('<cword>')<CR><CR>
" :Index shows index.txt (with all key-combinations) using fzf-vim
command! Index silent execute ":help index.txt" | silent execute ":BLines!"
nnoremap <Tab>i :Index<CR>
command! -bang -nargs=* GCheckout
      \ call fzf#run({
      \ 'source':  'git branch --sort=-committerdate --format="%(refname:short)"',
      \ 'sink':    '!git checkout',
      \ 'options': '--ansi',
      \ 'down':    '40%'}) |
      \ execute ":Git status"
nnoremap <Tab>c :GCheckout<CR>

imap <c-x>w <plug>(fzf-complete-word)
imap <c-x>p <plug>(fzf-complete-path)
imap <c-x>l <plug>(fzf-complete-line)

" fugitive.vim
nnoremap <Leader>G :Gedit :<CR>
" nnoremap <Leader>L :Gclog<CR>

" GitGutter.vim
nnoremap <C-g>/ /[<bar><>=]\{7}<CR>
nnoremap <C-g>V :bdelete gitgutter<CR>
nnoremap <C-g>C :bdelete gitgutter<CR>
nnoremap <C-g>g :GitGutter<CR>
nnoremap <C-g>n :GitGutterNextHunk<CR>
nnoremap <C-g>p :GitGutterPrevHunk<CR>
nnoremap <C-g>s :GitGutterStageHunk<CR>
nnoremap <C-g>v :GitGutterPreviewHunk<CR>
nnoremap <C-g>c :GitGutterPreviewHunk<CR>
nnoremap <C-g>x :GitGutterUndoHunk<CR>
nnoremap <C-g>e :GFiles?<CR>

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
