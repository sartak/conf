let g:airline_powerline_fonts = 1
let g:airline_theme='deus'

let g:gitgutter_override_sign_column_highlight = 0
if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" the same as airline
highlight SignColumn ctermbg=234

highlight ALEErrorSign ctermfg=1 ctermbg=234
highlight ALEWarningSign ctermfg=3 ctermbg=234

highlight GitGutterAdd ctermfg=5 ctermbg=234
highlight GitGutterChange ctermfg=5 ctermbg=234
highlight GitGutterChangeDelete ctermfg=5 ctermbg=234
highlight GitGutterDelete ctermfg=5 ctermbg=234

let g:ale_sign_error = '！'
let g:ale_sign_warning = '？'

let g:gitgutter_sign_added = '・'
let g:gitgutter_sign_modified = '・'
let g:gitgutter_sign_removed = '・'
let g:gitgutter_sign_removed_first_line = '・'
let g:gitgutter_sign_modified_removed = '・'
