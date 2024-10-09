let mapleader = "\<Space>"

set ttymouse=xterm2
set mouse=a
set confirm
set wildmenu
set hidden " Edited buffers can exist hidden
set noswapfile

set listchars=tab:→\·,eol:↲,nbsp:␣,space:-,trail:•,extends:⟩,precedes:⟨
set showbreak=↪\  " Prefix for wrapped lines

set showcmd
set showmatch
set tabstop=2 " Use 2 spaces to display tab
set softtabstop=2
set shiftwidth=2 " Number of spaces to use for auto indent
set autoindent
set expandtab
set nofixeol
set number relativenumber
set diffopt=filler,iwhite
set hlsearch
nnoremap <C-H> :set hlsearch!<CR>
set incsearch
set foldmethod=indent
set foldlevel=10
set foldclose=all
set foldcolumn=4

" folding improvements
" display foldlevel on `zm`/`zr`
" allow repeat with `z;`/undo with `zu`
" repeat fold with  `C-S` (single key for easy repeat)
let folddirection=0
nnoremap zm :let folddirection=+1<CR>zm:set foldlevel?<CR>
nnoremap zr :let folddirection=-1<CR>zr:set foldlevel?<CR>
nnoremap <expr> z; folddirection>0 ? 'zm:set foldlevel?<CR>' : 'zr:set foldlevel?<CR>'
nnoremap <expr> zu folddirection>0 ? 'zr:set foldlevel?<CR>' : 'zm:set foldlevel?<CR>'
nmap <C-S> z;
set display+=lastline
" set statusline+=%F

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd InsertEnter * set cursorline cursorcolumn nohlsearch list
autocmd InsertLeave * set nocursorline nocursorcolumn hlsearch nolist
inoremap <c-c> <esc>:undo<cr>
set modeline
set modelines=5

highlight clear Search
highlight Search ctermfg=blue ctermbg=black
highlight clear CursorColumn CursorLine
highlight CursorColumn cterm=underline
highlight CursorLine cterm=underline
highlight WhiteSpace ctermfg=DarkGray
highlight SpecialKey ctermfg=grey
highlight NonText ctermfg=darkgray
highlight Folded ctermbg=0 ctermfg=8
highlight FoldColumn ctermfg=DarkGray ctermbg=Black
highlight VertSplit ctermfg=Black ctermbg=DarkGray
highlight MatchParen ctermbg=DarkGray

highlight GitGutterAdd    ctermfg=2 ctermbg=0
highlight GitGutterChange ctermfg=3 ctermbg=0
highlight GitGutterDelete ctermfg=1 ctermbg=0

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" https://github.com/airblade/vim-gitgutter

Plug 'https://github.com/tpope/vim-fugitive.git'
" keep fugitive when hidden
autocmd User FugitiveObject setlocal bufhidden=
augroup fugitive_pager_mappings
  autocmd!
  " <C-F> works better than <C-A> as it would always catch the branch
  " name, even if the cursor is over current branch markers (*/+)
  " autocmd User FugitivePager nnoremap <buffer> X :G branch -D <C-R><C-F>
  autocmd User FugitivePager nnoremap PP &@:<C-U>Git push<CR>
augroup END

Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
nnoremap <c-g><c-g> <c-g>
nmap <c-g>g :GitGutter<CR>
nmap <c-g>v <Plug>(GitGutterPreviewHunk)
nmap <c-g>V :bdelete gitgutter<CR>
nmap <c-g>s <Plug>(GitGutterStageHunk)
nmap <c-g>x <Plug>(GitGutterUndoHunk)
nmap <c-g>n <Plug>(GitGutterNextHunk)
nmap <c-g>p <Plug>(GitGutterPrevHunk)
nmap <c-g>/ /[<bar><>=]\{7}<CR>
autocmd BufWritePost * GitGutter

Plug 'https://github.com/frazrepo/vim-rainbow.git'
Plug 'chrisbra/Colorizer'

Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'metakirby5/codi.vim'

Plug 'joeytwiddle/sexy_scroller.vim'
let g:SexyScroller_MaxTime = 250
let g:SexyScroller_ScrollTime = 150
let g:SexyScroller_CursorTime = 50
let g:SexyScroller_EasingStyle = 3

Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
let g:minimap_width = 80

Plug 'dominikduda/vim_current_word'
let g:vim_current_word#highlight_current_word = 0

nmap <c-t><c-t> :terminal<CR>
nmap <c-t>v :vertical terminal<CR>
Plug 'voldikss/vim-floaterm'
nmap <c-t>f :FloatermNew<CR>
nmap <c-t>n :FloatermNew node<CR>

Plug 'tpope/vim-rsi'

Plug 'dense-analysis/ale'
" Remap usual
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gr :ALEFindReferences<CR>
nnoremap gh :ALEHover<CR>
nnoremap gR :ALERename<CR>
let g:ale_fixers = { 'python': 'ruff' }

" Better color schemes
Plug 'rafi/awesome-vim-colorschemes'

Plug 'tpope/vim-commentary'

Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1

Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'

Plug 'ap/vim-buftabline'
let g:buftabline_indicators=1 " Display if unsaved buffer

Plug 'wellle/context.vim'

Plug 'preservim/vimux'
Plug 'vim-test/vim-test'
let test#strategy = "vimux"
let g:test#javascript#runner = 'jest'
" let g:test#strategy = 'jest'
" let g:test#javascript#jest#executable = 'jest'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

colorscheme gruvbox
set background=dark

nnoremap <Leader><Leader> :
" inoremap jk <esc><Right>
" inoremap JK <esc>:undo<CR>
" inoremap jw <esc>:write<CR>

" Buffers
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>b :buffers<CR>
nnoremap <Leader>N :ene<CR>
nnoremap <Leader>d :bd<CR>
" Tabs
nnoremap <Leader>J :tabnext<CR>
nnoremap <Leader>K :tabprev<CR>
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>T :tabnew<bar>GFiles<CR>
nnoremap <Leader>D :tabclose<CR>
" Windows/splits
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
nmap <C-n> *
nmap <C-p> #

vmap <C-n> y/<C-r>"<CR>
vmap <C-p> y?<C-r>"<CR>

nnoremap g/ /\<\><Left><Left>
nnoremap gS :%s///g<Left><Left><Left>
" Jump to definition
nnoremap <Leader><C-d> yiw/<Bslash>v<C-r>0.*(<Bslash>{<Bar><Bslash>=<Bar>:)<CR>

" nnoremap <Leader>G :Git<bar>wincmd H<bar>vertical resize 80<CR>
nnoremap <Leader>g :Gedit :<CR>

set splitbelow
set splitright

" fzf.vim
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
" :Index shows index.txt (with all key-combinations) using fzf-vim
command! Index silent execute ":help index.txt" | silent execute ":BLines!"
nnoremap <Leader>i :Index<CR>

let g:fzf_preview_window = ['up:10']

" windows
nnoremap <C-w>, 20<C-w><
nnoremap <C-w>. 20<C-w>>

" Remove current buffer
nnoremap ZZ :bdelete<CR>
nnoremap Z1 :2,$bd<CR>
nnoremap Z\ :1, $-1bd<CR>
" Close window
nnoremap ZX :hide<CR>
" Replace current buffer with fzf
nnoremap ZF :bdelete<bar>FZF<CR>
" Remove all buffers
nnoremap ZA :%bdelete<CR>

autocmd CursorHold * echo
autocmd TextYankPost * echo len(getreg(v:register))"chars,"len(split(getreg(v:register), '\n'))"lines, <yank>"substitute(getreg(v:register), '\n', ' // ', 'g')[0:50]"</yank>"

function! s:CaptureCommand( command )
  redir => l:commandOutput
  silent! execute a:command
  redir END
  redraw  " This is necessary because of the :redir done earlier.
  return split(l:commandOutput, "\n")
endfunction

":[N]Head {cmd}     Show only the first 10 / [N] lines of {cmd}'s output.
function! s:Head( count, command )
  let l:lines = s:CaptureCommand(a:command)
  for l:line in l:lines[0:(a:count ? a:count : 10)]
    echo l:line
  endfor
endfunction

":[N]Tail {cmd}     Show only the last 10 / [N] lines of {cmd}'s output.
function! s:Tail( count, command )
  let l:lines = s:CaptureCommand(a:command)
  for l:line in l:lines[-1 * min([(a:count ? a:count : 10), len(l:lines)]):-1]
    echo l:line
  endfor
endfunction
command! -range=0 -nargs=+ Head call <SID>Head(<count>, <q-args>)
command! -range=0 -nargs=+ Tail call <SID>Tail(<count>, <q-args>)

" https://vim.fandom.com/wiki/Comfortable_handling_of_registers : cycle registers
nnoremap <Leader>r :let @x=@" \| let @"=@a \| let @a=@b \| let @b=@x \| register " 0 a b<CR>
nnoremap <Leader>R :let @"=@0 \| let @0=@1 \| let @1=@2 \| let @2=@3 \| register " 0 1 2<CR>

" nnoremap <Leader>k <C-O>:Tail jumps<CR>
" nnoremap <Leader>j <C-I>:Tail jumps<CR>
" nnoremap <Leader>j :copen<Bar>Tail jumps<C-w>O<CR>

" echo last sourcefile update
" redraw | echo '--- .vimrc sourced --- ' . strftime("%c", getftime(expand('%'))) . ' ---' | redraw

" :redir @" | silent map | redir END | new | put!
function! s:ExecuteAndPaste(command)
  redir @R
  silent execute a:command
  redir END
  new
  put! R
endfunction

highlight LineNr ctermfg=Gray ctermbg=DarkGray
highlight LineNrAbove ctermfg=Black ctermbg=DarkGray
highlight LineNrBelow ctermfg=Black ctermbg=DarkGray
