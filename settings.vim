" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
 
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

set hidden          " Allow hidden buffers, don't limit to 1 file per window/split

set tabstop=2 shiftwidth=2

set clipboard=unnamed

" Store tilde backups in ~/tmp and /tmp
set backupdir-=.
set backupdir^=~/tmp,/tmp

set list
set listchars=tab:»·,space:·,trail:·

set expandtab " indent with spaces

set nofoldenable " disable folding

" Remember opened buffers
set viminfo^=%

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

set cursorline

set iskeyword+=@
