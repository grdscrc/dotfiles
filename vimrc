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
" # pathogen
" mkdir -p ~/.vim/autoload ~/.vim/bundle && \
" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

execute pathogen#infect()

" # Vundle
" Ensure that :
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

source ~/dotfiles/settings.vim
source ~/dotfiles/theme.vim
source ~/dotfiles/vundle.vim
source ~/dotfiles/autocmd.vim
source ~/dotfiles/plugins.vim
source ~/dotfiles/mappings.vim
source ~/dotfiles/plug.vim

source ~/dotfiles/surround.vim
source ~/dotfiles/visual-at.vim
source ~/dotfiles/nerdtree.vim
