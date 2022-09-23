" retrain my fingers for buffer jump commands
nmap <Right> :<C-U>echoerr "use buffer jumps instead"<CR>
nmap <Left>  :<C-U>echoerr "use buffer jumps instead"<CR>
cnoreabbrev <expr> bn getcmdtype() == ":" && getcmdline() == 'bn' ? 'USE BUFFER JUMPS' : 'bn'
cnoreabbrev <expr> bne getcmdtype() == ":" && getcmdline() == 'bne' ? 'USE BUFFER JUMPS' : 'bne'
cnoreabbrev <expr> bnex getcmdtype() == ":" && getcmdline() == 'bnex' ? 'USE BUFFER JUMPS' : 'bnex'
cnoreabbrev <expr> bnext getcmdtype() == ":" && getcmdline() == 'bnext' ? 'USE BUFFER JUMPS' : 'bnext'
cnoreabbrev <expr> bp getcmdtype() == ":" && getcmdline() == 'bp' ? 'USE BUFFER JUMPS' : 'bp'
cnoreabbrev <expr> bpr getcmdtype() == ":" && getcmdline() == 'bpr' ? 'USE BUFFER JUMPS' : 'bpr'
cnoreabbrev <expr> bpre getcmdtype() == ":" && getcmdline() == 'bpre' ? 'USE BUFFER JUMPS' : 'bpre'
cnoreabbrev <expr> bprev getcmdtype() == ":" && getcmdline() == 'bprev' ? 'USE BUFFER JUMPS' : 'bprev'

" save and load buffer map in session
set sessionoptions+=globals

if exists('g:Sartak_SessionFiles')
  let l:json = json_decode(g:Sartak_SessionFiles)
  let g:sartak_filetoindex = l:json[0]
  let g:sartak_indextofile = l:json[1]
else
  let g:sartak_filetoindex = {}
  let g:sartak_indextofile = {}
end

for s:i in range(1, 9)
  exe 'nmap <silent> <leader>'  . s:i . ' :<C-U>call GoToBufferIndex(' . s:i . ')<CR>'
  exe 'nmap <silent> <leader>b' . s:i . ' :<C-U>call SetBufferIndex(' . s:i . ')<CR>'
endfor

nmap <leader>0  :<C-U>echoerr "not implemented yet"<CR>
nmap <leader>b0 :<C-U>echoerr "not implemented yet"<CR>

func GoToBufferIndex(number)
  let l:file = get(g:sartak_indextofile, a:number, "")
  if l:file == ""
    execute 'normal! \<Esc>'
    echohl ErrorMsg
    echomsg "no buffer at index " . a:number
    echohl None
    return
  end
  exe "buffer " . l:file
endfunc

func SetBufferIndex(desired_idx)
  let l:current_file = expand("%:p")
  let l:current_idx = get(g:sartak_filetoindex, l:current_file, "missing")
  let l:desired_file = get(g:sartak_indextofile, a:desired_idx, "")

  if l:current_idx == "missing" && l:desired_file != ""
    execute 'normal! \<Esc>'
    echohl ErrorMsg
    echomsg "warning: displacing " . a:desired_idx
    echohl None
  endif

  if l:current_idx == a:desired_idx
    return
  endif

  let g:sartak_filetoindex[l:current_file] = a:desired_idx
  let g:sartak_indextofile[a:desired_idx] = l:current_file

  if l:current_idx != "missing" && l:desired_file != ""
    let g:sartak_filetoindex[l:desired_file] = l:current_idx
    let g:sartak_indextofile[l:current_idx] = l:desired_file
  endif

  call SerializeMaps()
endfunc

function SerializeMaps()
  let g:Sartak_SessionFiles = json_encode([g:sartak_filetoindex, g:sartak_indextofile])
endfunc

function SyncBuffers(event)
  let l:missing = []
  let l:clean_files = copy(g:sartak_filetoindex)
  let l:changes = 0

  for b in getbufinfo({'buflisted': 1})
    if has_key(g:sartak_filetoindex, b.name)
      unlet l:clean_files[b.name]
    else
      call add(l:missing, b.name)
      let l:changes = l:changes + 1
    end
  endfor

  for f in keys(l:clean_files)
    " echoerr "removing " . f . " during " . a:event
    unlet g:sartak_indextofile[g:sartak_filetoindex[f]]
    unlet g:sartak_filetoindex[f]
    let l:changes = l:changes + 1
  endfor

  if l:changes == 0
    return
  end

  let l:idx = 1
  for f in l:missing
    while has_key(g:sartak_indextofile, l:idx)
      let l:idx = l:idx + 1
    endwhile
    let g:sartak_filetoindex[f] = l:idx
    let g:sartak_indextofile[l:idx] = f
    " echoerr "adding " . f . " as " . l:idx . " during " . a:event
    let l:idx = l:idx + 1
  endfor

  call SerializeMaps()
endfunction

" https://groups.google.com/g/vim_dev/c/azjxSX4Z5Io
autocmd BufWinEnter * call SyncBuffers("BufWinEnter")
