inoremap <C-T> <Esc>:Files<CR>
nnoremap <C-T> :Files<CR>
vnoremap <C-T> :<C-U>Files<CR>

" todo: pass the content of the buffer into fzf
cnoremap <silent> <C-R> <C-E><C-U>History:<CR>

cnoreabbrev <expr> e getcmdtype() == ":" && getcmdline() == 'e' ? 'USE CTRL-T!' : 'e'
cnoreabbrev <expr> ed getcmdtype() == ":" && getcmdline() == 'ed' ? 'USE CTRL-T!' : 'ed'
cnoreabbrev <expr> edi getcmdtype() == ":" && getcmdline() == 'edi' ? 'USE CTRL-T!' : 'edi'
cnoreabbrev <expr> edit getcmdtype() == ":" && getcmdline() == 'edit' ? 'USE CTRL-T!' : 'edit'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

let g:fzf_preview_window = ['down:75%,wrap,border-horizontal', 'ctrl-/']
let g:coc_fzf_preview = 'down:75%,wrap,border-horizontal'
let g:coc_fzf_opts = []
