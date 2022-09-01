set sessionoptions-=blank sessionoptions-=options sessionoptions+=tabpages

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
    \   '--preview', 'cd ~/.vim/sessions/; stat -f "Accessed: %Sa%nModified: %Sm%nCreated:  %SB" {}; echo; set_color 23A5FA; g --color=never "^cd (.+)" -r ' . "'\$1'" . ' {}; set_color -o normal; g --color=never "^badd \+\d+ (.+)" -r ' . "'  - \$1'" . ' {}',
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

autocmd VimEnter * call SessionIfEmpty()

