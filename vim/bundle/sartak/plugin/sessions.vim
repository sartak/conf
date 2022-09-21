set sessionoptions-=blank sessionoptions-=options sessionoptions+=tabpages
set viewoptions-=options

function FzfSession()
  call fzf#run({
    \ 'source': 'exa -1 --sort accessed --reverse ~/.vim/sessions/',
    \ 'sink': "SessionOpen",
    \ 'options': [
    \   '--prompt', 'vim session > ',
    \   '--exit-0',
    \   '--header', "\e[38;5;240;3mctrl-x to delete, ctrl-c to keep vim empty",
    \   '--preview-window', 'bottom:50%',
    \   '--info', 'hidden',
    \   '--preview', 'z ~/.vim/sessions/; stat -f "Accessed: %Sa%nModified: %Sm%nCreated:  %SB" {}; echo; set_color 23A5FA; g --color=never "^cd (.+)" -r ' . "'\$1'" . ' {}; set_color -o normal; g --color=never "^badd \+\d+ (.+)" -r ' . "'  - \$1'" . ' {}',
    \   '--bind', "ctrl-x:execute-silent(rm ~/.vim/sessions/{})+reload(exa -1 --sort accessed --reverse ~/.vim/sessions/)",
    \ ]
    \ })
endfunc

command! -nargs=0 FzfSession call FzfSession()

nnoremap <leader>so :SessionOpen<CR>
nnoremap <leader>sc :SessionSave<CR>
nnoremap <leader>sx :SessionClose<CR>
nnoremap <leader>ss :FzfSession<CR>

function SessionIfEmpty()
  if v:this_session == '' && argc() is 0
    " defer by a millisecond so that vim doesn't emit unexpected 'I' and 'O'
    " characters into the fzf query when focus is entered and lost,
    " respectively
    call timer_start(1, { tid -> FzfSession()})
  endif
endfunc

let s:transient_session_path = $HOME . '/.vim/.transient.session'
function LoadTransientSession()
  if has('cscope')
    silent! cscope kill -1
  endif
  try
    set eventignore=all
    execute 'silent! %bwipeout!'
    let n = bufnr('%')
    execute 'silent! so ' . s:transient_session_path
    execute 'silent! bwipeout! ' . n
  finally
    set eventignore=
    doautoall BufRead
    doautoall FileType
    doautoall BufEnter
    doautoall BufWinEnter
    doautoall TabEnter
    doautoall SessionLoadPost
	endtry
	if has('cscope')
		silent! cscope add .
	endif

	unlet! g:LAST_SESSION
	let v:this_session = ''
endfunc

function MaybeSaveTransientSession()
  " We already have a session
  if v:this_session != ''
    return
  endif

  " Avoid creating transient session for git commit or git rebase -i
  if $GIT_EXEC_PATH != ''
    return
  endif

  execute 'silent mksession! ' . s:transient_session_path
endfunc

autocmd VimEnter * call SessionIfEmpty()

" If there's no session then save a transient session
autocmd VimLeavePre * call MaybeSaveTransientSession()
