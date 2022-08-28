inoremap <silent> <C-F> <Esc>:FloatermToggle<CR>
nnoremap <silent> <C-F> :FloatermToggle<CR>
vnoremap <silent> <C-F> :<C-U>FloatermToggle<CR>

" Floaterm seems to ignore termwinkey override
tnoremap <C-w> <C-w>.

let g:floaterm_height = 0.9
let g:floaterm_width  = 0.9
let g:floaterm_title = ""
let g:floaterm_borderchars = "─│─│╭╮╯╰"

