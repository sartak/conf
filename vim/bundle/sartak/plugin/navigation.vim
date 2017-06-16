" in normal mode, right and left arrow keys switch buffers
nmap <Right> :bn<CR>
nmap <Left>  :bp<CR>

" don't move the cursor to the start of the line when changing buffers
set nostartofline

" give three lines of context when moving the cursor around
set scrolloff=3

" When editing a file, always jump to the last cursor position {{{
autocmd BufReadPost *
\  if line("'\"") > 0 && line("'\"") <= line("$") |
\    exe "normal g`\"" |
\  endif

autocmd BufReadPost */.git/COMMIT_EDITMSG execute "normal gg" | startinsert
