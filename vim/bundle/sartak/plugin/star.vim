nmap <silent> * <Plug>(star-*)
vmap <silent> * <Plug>(star-*)
nmap <silent> # <Plug>(star-#)
vmap <silent> # <Plug>(star-#)
nmap <silent> g* <Plug>(star-g*)
nmap <silent> g# <Plug>(star-g#)

let g:star_start_next_match = 1

" <leader>* starts a fzf search
nnoremap <silent> <leader>*  :<C-U>call FzfStar(1, 0)<CR>
nnoremap <silent> <leader>#  :<C-U>call FzfStar(0, 0)<CR>
nnoremap <silent> <leader>g* :<C-U>call FzfStar(1, 1)<CR>
nnoremap <silent> <leader>g# :<C-U>call FzfStar(0, 1)<CR>
nnoremap <silent> g<leader>* :<C-U>call FzfStar(1, 1)<CR>
nnoremap <silent> g<leader># :<C-U>call FzfStar(0, 1)<CR>

function FzfStar(is_forward, is_g) abort
  let l:vimpat = star#GetPattern(0, 1)
  if a:is_g
    let @/ = l:vimpat
    let l:rgpat = l:vimpat
  else
    let @/ = star#EscapedCword()
    let l:rgpat = '\b' . l:vimpat . '\b'
  end

  " move to next match and more importantly, set highlight
  if a:is_forward
    call feedkeys("/\<CR>")
  else
    call feedkeys("?\<CR>")
  end

  call timer_start(1, { tid -> execute("Rg " . l:rgpat) })
endfunc
