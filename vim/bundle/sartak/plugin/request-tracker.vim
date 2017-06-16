autocmd BufRead,BufNewFile */rt/share/html/*,*/rt-*/html/* setlocal filetype=mason

" fold away license tag
autocmd BufRead,BufNewFile */rt/*,*/rt-*/* call FoldLicenseTag()

function FoldLicenseTag()
    set foldmethod=marker

    " open all folds
    normal zR

    " close the license tag fold
    if (search('BEGIN BPS TAGGED BLOCK {{{', 's'))
        normal zc
        normal ``
    endif
endfunction
