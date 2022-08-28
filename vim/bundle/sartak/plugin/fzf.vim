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

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --no-heading --color=always -- %s'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
