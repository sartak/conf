inoremap <C-T> <Esc>:Files<CR>
nnoremap <C-T> :Files<CR>
vnoremap <C-T> :<C-U>Files<CR>

cnoreabbrev <expr> e getcmdtype() == ":" && getcmdline() == 'e' ? 'USE CTRL-T!' : 'e'
cnoreabbrev <expr> ed getcmdtype() == ":" && getcmdline() == 'ed' ? 'USE CTRL-T!' : 'ed'
cnoreabbrev <expr> edi getcmdtype() == ":" && getcmdline() == 'edi' ? 'USE CTRL-T!' : 'edi'
cnoreabbrev <expr> edit getcmdtype() == ":" && getcmdline() == 'edit' ? 'USE CTRL-T!' : 'edit'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
