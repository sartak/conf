" don't move the cursor to the start of the line when changing buffers
set nostartofline

" give three lines of context when moving the cursor around
set scrolloff=3

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\  if line("'\"") > 0 && line("'\"") <= line("$") |
\    exe "normal! g`\"" |
\  endif

" Stay at top of the file for git commit
autocmd BufReadPost */.git/COMMIT_EDITMSG exe "normal! gg0"
autocmd BufReadPost */.git/rebase-merge/git-rebase-todo exe "normal! gg0}k"
