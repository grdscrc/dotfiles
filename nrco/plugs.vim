let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

call plug#begin()

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim' 

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" https://github.com/airblade/vim-gitgutter

Plug 'https://github.com/tpope/vim-fugitive.git'
" autocmd BufEnter fugitive file fugitive
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

Plug 'dominikduda/vim_current_word'
let g:vim_current_word#highlight_current_word = 0

Plug 'voldikss/vim-floaterm'

Plug 'tpope/vim-rsi'


" Better color schemes
Plug 'rafi/awesome-vim-colorschemes'

Plug 'tpope/vim-commentary'

Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1

Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'

Plug 'ap/vim-buftabline'
let g:buftabline_indicators=1 " Display if unsaved buffer

Plug 'wellle/context.vim'
" autocmd VimEnter * if &diff | ContextDisable | endif " Disable on vimdiff

Plug 'preservim/vimux'
Plug 'vim-test/vim-test'
let test#strategy = "vimux"
let g:test#javascript#runner = 'jest'

Plug 'sedm0784/vim-rainbow-trails'

Plug 'rhysd/conflict-marker.vim'

Plug 'vim-scripts/AnsiEsc.vim'

Plug 'mtdl9/vim-log-highlighting'

Plug 'zivyangll/git-blame.vim'

" Plug 'https://github.com/slakkenhuis/vim-margin'
" let g:margin_enabled=0
" let &textwidth=100

" Plug 'junegunn/limelight.vim'

let g:limelight_default_coefficient = 0.3
let g:limelight_paragraph_span = 1

Plug 'rbong/vim-flog'

Plug 'tracyone/fzf-funky', {'on': 'FzfFunky'}

Plug 'junegunn/gv.vim'

Plug 'junegunn/vim-peekaboo'
let g:peekaboo_window = 'vert bo 50new'

Plug 'github/copilot.vim'

Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }

Plug 'gcmt/taboo.vim'

" Plug 'ubaldot/vim-poptools'
" Plug 'ubaldot/vim-open-recent'

Plug 'christoomey/vim-tmux-navigator'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
