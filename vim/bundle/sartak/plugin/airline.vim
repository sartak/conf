let g:airline_theme='deusfork'

function SmartLines()
  let currentMode = mode()
  if currentMode == "v" || currentMode == "V" || currentMode == ""
    let s = line(".")
    let e = line("v")
    if s > e
      let t = s
      let s = e
      let e = t
    end
    return s . ":" . e . "(" . (e-s+1) . ")"
  else
    return line(".") . "/" . line("$")
  end
endfunction

function CurrentSession()
  if v:this_session == ''
    return ''
  endif

  let session = v:this_session
  return substitute(session, ".*/", "", "")
endfunction

function! AirlineInit()
  let g:airline_section_a = airline#section#create_left(['mode', 'paste', 'spell'])
  let g:airline_section_b = airline#section#create([])
  let g:airline_section_c = airline#section#create(["%{expand('%:p:~:h:h:t')}/%{expand('%:p:h:t')}/%{expand('%:t')}", "readonly"])
  let g:airline_section_gutter = airline#section#create(['%='])

  " section y never seems to get rendered, which is where I'd prefer
  " CurrentSession to go
  let g:airline_section_x = airline#section#create_right(['%{CurrentSession()}'])
  let g:airline_section_y = airline#section#create([])

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
