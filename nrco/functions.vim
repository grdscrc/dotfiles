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

" https://vim.fandom.com/wiki/Comfortable_handling_of_registers : cycle first 3 registers

" Set reg f to current filename

" Yank to system pbcopy, paste with system pbpaste

" Format whole doc


" :redir @" | silent map | redir END | new | put!
function! s:ExecuteAndPaste(command)
  redir @R
  silent execute a:command
  redir END
  new
  put! R
endfunction
