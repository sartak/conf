" backspace
set backspace=2

" always join with just one space, even between sentences
set nojoinspaces

" make tilde (flip case) an operator instead of always operating on the next char
set tildeop

" Y behaves like C and D
let g:yankring_n_keys = 'D x X'
nnoremap Y y$

" Delete comment character when joining commented lines
set formatoptions+=j

nnoremap ZZ :wqa<CR>
