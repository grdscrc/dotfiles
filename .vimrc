" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" set nocp
" if exists('$DOTFILES') 
"   source $DOTFILES/vim/autoload/pathogen.vim
"   source $DOTFILES/vim/vimrc
" endif
" 

execute pathogen#infect()

source ~/dotfiles/settings.vim
source ~/dotfiles/theme.vim
source ~/dotfiles/vundle.vim
source ~/dotfiles/autocmd.vim
source ~/dotfiles/plugins.vim
source ~/dotfiles/mappings.vim
source ~/dotfiles/plug.vim
source ~/dotfiles/surround.vim
source ~/dotfiles/visual-at.vim
