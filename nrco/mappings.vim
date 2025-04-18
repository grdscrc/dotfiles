inoremap <c-c> <esc>:undo<cr>

nmap <c-h> :set hlsearch!<CR>

" Center cursor on page next/prev
nnoremap <c-f> <c-f>M
nnoremap <c-b> <c-b>M
nnoremap <c-d> L<c-d>M
nnoremap <c-u> H<c-u>M
nnoremap n n
nnoremap N N

nnoremap <c-w>. 20<c-w>>
nnoremap <c-w>, 20<c-w><

nnoremap <Leader><Leader> :

" Search cword in all files
nnoremap <Leader><c-d> yiw/<Bslash>v<c-r>0(<Bslash> <Bar><Bslash>n)*(<Bslash>{<Bar><Bslash>=<Bar>:)<CR>

nnoremap <Leader>a :NERDTreeToggle<CR>
nnoremap <Leader>Aa :NERDTreeFocus<CR>
nnoremap <Leader>Af :NERDTreeFind<CR>
nnoremap <Leader>A  :NERDTree
nnoremap <Leader>o  <c-w>w
nnoremap <Leader>O  <c-w>W
nnoremap <Leader>fj :%!jq .<CR>
nnoremap <Leader>fx :%!xmllint --format -<CR>
nnoremap <Leader>f :%!
nnoremap <Leader>t :tab
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tp :-tabnew<CR>
nnoremap <Leader>tN :$tabnext<CR>:call PopupTabs()<CR>
nnoremap <Leader>tP :1tabnext<CR>:call PopupTabs()<CR>
nnoremap <Leader>N :tabmove +1<CR>
nnoremap <Leader>P :tabmove -1<CR>
nnoremap <Leader>X :tabclose<CR>:call PopupTabs()<CR>
nnoremap <Leader>n :tabnext<CR>:call PopupTabs()<CR>
nnoremap <Leader>p :tabprev<CR>:call PopupTabs()<CR>
function! PopupTabs()
  call popup_clear()
  let ls = execute('tabs')
  let lines = split(ls, '\n')
  call popup_notification(lines, #{
        \ line: 0,
        \ col: 0,
        \ time: 1500,
        \ highlight: 'Normal'
        \ })
endfunction

nnoremap <Leader>l :lwindow<CR>
nnoremap <Leader>e :enew<CR>
nnoremap <Leader>E :edit<CR>
nnoremap <Leader>c :cwindow<CR>
nnoremap <Leader>q :qa<CR>
nnoremap <Leader>s :set !<left>
nnoremap <Leader>ssj :set syntax=json<CR>
nnoremap <Leader>ssx :set syntax=xml<CR>
nnoremap <Leader>sfu :set fileformat=unix<Bar>w<CR>
nnoremap <Leader>sfd :set fileformat=dos<Bar>w<CR>
nnoremap <Leader>sfm :set fileformat=mac<Bar>w<CR>
nnoremap <Leader>sl :set list!<CR>
nnoremap <Leader>B :buffers<CR>:buffer<Space>
function! PopupBuffers()
  call popup_clear()
  let ls = execute('ls')
  let lines = split(ls, '\n')
  call popup_notification(lines, #{
        \ line: 0,
        \ col: 0,
        \ time: 1500,
        \ highlight: 'Normal'
        \ })
endfunction
nnoremap <Leader>j :bnext<CR>:call PopupBuffers()<CR>
nnoremap <Leader>k :bprev<CR>:call PopupBuffers()<CR>
nnoremap <Leader>d :buffer #<bar>bdelete #<CR>:call PopupBuffers()<CR>
nnoremap <Leader>D :bufdo bd<CR>:call PopupBuffers()<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>W :write<bar>sleep<bar>echo "Quitting..."<bar>sleep<bar>quit<CR>
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
nnoremap <Leader>ry :silent call system("pbcopy", @0)<bar>echo @0<CR>
" Revert order of next 2 words
" 1. append space at end, 2. clean jk registers, 3. store words 123 to registers jk, paste kj
nnoremap <Leader>r2 2eq<space><esc>2bqjqqkq"jdw"kdw"kp"jp2b
" Revert order of next 3 words
" 1. append space at end, 2. clean jkl registers, 3. store words 123 to registers jkl, paste lkj
nnoremap <Leader>r3 3ea<space><esc>3bqjqqkqqlq"jdw"kdw"ldw"lp"kp"jp3b

nnoremap <c-n> *
nnoremap <c-p> #

" hello world goodbye
" folding improvements ok
" display foldlevel on `zm`/`zr`
" allow repeat with `z;`/undo with `zu`
let folddirection=0
nnoremap <expr> z; folddirection>0 ? 'zm:set foldlevel?<CR>' : 'zr:set foldlevel?<CR>'
nnoremap <expr> zu folddirection>0 ? 'zr:set foldlevel?<CR>' : 'zm:set foldlevel?<CR>'
nnoremap zm :silent let folddirection=+1<CR>zm:set foldlevel?<CR>
nnoremap zr :silent let folddirection=-1<CR>zr:set foldlevel?<CR>

nnoremap ga <c-^>:echo "Alternate to " expand('#')<CR>
nnoremap g! :echo system('')<Left><Left>

vmap <c-n> y/<c-r>"<CR>
vmap <c-p> y?<c-r>"<CR>

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
nnoremap <Tab><Tab> :Buffers<CR>
nnoremap <Tab>/ :History/<CR>
nnoremap <Tab>: :History:<CR>
nnoremap <Tab>; :BLines<CR>
nnoremap <Tab>o :Files<CR>
nnoremap <Tab>O :Files ~<CR>
nnoremap <Tab>. :Files ~/dotfiles<CR>
nnoremap <Tab>a :Ag<CR>
nnoremap <Tab>w :Buffers<CR>
nnoremap <Tab>e :GFiles<CR>
nnoremap <Tab>t :$tabnew<bar>GFiles<CR>
nnoremap <Tab>T :-tabnew<bar>GFiles<CR>
nnoremap <Tab>v :vsplit<bar>GFiles<CR>
nnoremap <Tab>s :GFiles?<CR>
nnoremap <Tab>f :FzfFunky<CR>
nnoremap <Tab>h :Helptags<CR>
nnoremap <Tab>r :Rg<CR>
nnoremap K :Rg <c-r>=expand('<cword>')<CR><CR>
" :Index shows index.txt (with all key-combinations) using fzf-vim
command! Index silent execute ":help index.txt" | silent execute ":BLines!"
nnoremap <Tab>i :Index<CR>

imap <c-x>w <plug>(fzf-complete-word)
imap <c-x>p <plug>(fzf-complete-path)
imap <c-x>l <plug>(fzf-complete-line)

" goyo
nnoremap <Leader>G :Goyo<CR>

" fugitive.vim
nnoremap <Leader>g :0tabnew<bar>:Gedit :<CR>
nnoremap <c-g>f :Gedit :<CR>
" gv.vim - git log browser
nnoremap <Leader>L :GV<CR>
nnoremap <Tab>g :GVBranch<CR>
command! -bang -nargs=* GVBranch
      \ call fzf#run({
      \ 'source':  'git branch --sort=-committerdate --format="%(refname:short)"',
      \ 'sink':    'GV',
      \ 'options': '--ansi',
      \ 'window':    {'width': 0.9, 'height': 0.6}})

" GitGutter.vim
nnoremap <c-g>V :bdelete gitgutter<CR>
nnoremap <c-g>C :bdelete gitgutter<CR>
nnoremap <c-g>g :GitGutter<CR>
nnoremap <c-g>n :GitGutterNextHunk<CR>
nnoremap <c-g>p :GitGutterPrevHunk<CR>
nnoremap <c-g>s :GitGutterStageHunk<CR>
nnoremap <c-g>v :GitGutterPreviewHunk<CR>
nnoremap <c-g>c :GitGutterPreviewHunk<CR>
nnoremap <c-g>x :GitGutterUndoHunk<CR>
nnoremap <c-g>e :GFiles?<CR>
" Find next git conflict
nnoremap <c-g>/ /^[<bar><>=]\{7}$<CR>

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
