" Theme
set background=dark

" Configure airline
set t_Co=256
set laststatus=2
let g:airline_theme='simple'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
