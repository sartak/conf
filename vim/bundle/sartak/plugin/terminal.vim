inoremap <silent> <C-F> <Esc>:FloatermNew<CR>
nnoremap <silent> <C-F> :FloatermNew<CR>
vnoremap <silent> <C-F> :<C-U>FloatermNew<CR>

" Floaterm seems to ignore termwinkey override
tnoremap <C-w> <C-w>.

let g:floaterm_height = 0.9
let g:floaterm_width  = 0.9
let g:floaterm_title = ""
let g:floaterm_borderchars = "─│─│╭╮╯╰"

