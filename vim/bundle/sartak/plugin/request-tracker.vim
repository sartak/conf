autocmd BufRead,BufNewFile share/html/* setlocal filetype=mason

" fold away license tag
autocmd BufRead,BufNewFile */rt/*,*/rt-*/* set foldmethod=marker
