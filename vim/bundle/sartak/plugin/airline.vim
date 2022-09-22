let g:airline_theme = 'deusfork'
let g:airline_powerline_fonts = 1

function SmartLines()
  let currentMode = mode()
  if currentMode == "v" || currentMode == "V" || currentMode == ""
    let sc = charcol(".")
    let ec = charcol("v")
    if sc > ec
      let tc = sc
      let sc = ec
      let ec = tc
    end

    let sl = line(".")
    let el = line("v")
    if sl > el
      let tl = sl
      let sl = el
      let el = tl
    end

    return sc . "-" . ec . "(" . (ec-sc+1) . "):" . sl . "-" . el . "(" . (el-sl+1) . ")"
  else
    return charcol('.') . ":" . line(".") . "/" . line("$")
  end
endfunction

function CurrentSession()
  if v:this_session == ''
    return ''
  endif

  let session = v:this_session
  return substitute(session, ".*/", "", "")
endfunction

" https://github.com/vim-airline/vim-airline/issues/2574
let g:airline#extensions#default#section_truncate_width = {
  \ 'b': 79,
  \ 'x': 60,
  \ 'y': 80,
  \ 'z': 45,
  \ 'warning': 80,
  \ 'error': 80,
  \ }

function! AirlineInit()
  let g:airline_section_a = airline#section#create_left(['mode', 'paste', 'spell'])
  let g:airline_section_b = airline#section#create([])
  let g:airline_section_c = airline#section#create(["%{expand('%:p:~:h:h:t')}/%{expand('%:p:h:t')}/%{expand('%:t')}", "readonly"])
  let g:airline_section_gutter = airline#section#create(['%='])

  let g:airline_section_x = airline#section#create([])
  let g:airline_section_y = airline#section#create(['%{CurrentSession()}'])

  let g:airline_section_z = airline#section#create(['%{SmartLines()}'])
  let g:airline_section_error = airline#section#create(['coc_error_count'])
  let g:airline_section_warning = airline#section#create(['coc_warning_count'])

  let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'v',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
endfunction

autocmd User AirlineAfterInit call AirlineInit()
