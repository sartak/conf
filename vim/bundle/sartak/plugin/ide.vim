let g:airline_theme='deus'

let g:gitgutter_override_sign_column_highlight = 0
if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" the same as airline
highlight SignColumn ctermbg=234

