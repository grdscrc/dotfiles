" Start NERDTree on vim open
autocmd vimenter * NERDTree
" ...then go to previous (last accessed) window.
autocmd VimEnter * wincmd p

" Close when only NT tab is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Show dot files
let NERDTreeShowHidden=1
