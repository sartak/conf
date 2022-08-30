set sessionoptions-=blank sessionoptions-=options sessionoptions+=tabpages

nnoremap <leader>so :SessionOpen<CR>
nnoremap <leader>sc :SessionSave<CR>
nnoremap <leader>sx :SessionClose<CR>
nnoremap <leader>ss :SessionList<CR>

function SessionIfEmpty()
  if argc() is 0
    SessionList
  endif
endfunc

autocmd VimEnter * call SessionIfEmpty()
