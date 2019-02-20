" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

execute pathogen#infect()

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

source ~/dotfiles/vundle.vim
source ~/dotfiles/settings.vim
source ~/dotfiles/mappings.vim
source ~/dotfiles/autocmd.vim
source ~/dotfiles/theme.vim
source ~/dotfiles/plugins.vim

