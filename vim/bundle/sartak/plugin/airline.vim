let g:airline_theme='deusfork'
let g:airline#extensions#whitespace#enabled = 0

function! AirlineInit()
      " let g:airline_skip_empty_sections = 1
 
      " keep a
      "     let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'keymap', 'spell', 'capslock', 'xkblayout', 'iminsert'])
      " keep b
      "     let g:airline_section_b = airline#section#create(['hunks', 'branch'])
 
      " truncate c, add read-only flag
      "     let g:airline_section_c = airline#section#create(['%<', 'file', spc, 'readonly'])
      let g:airline_section_c = airline#section#create(['%t',' ','readonly'])

      " leave gutter
      "     let g:airline_section_gutter = airline#section#create(['%='])

      " remove x
      "     let g:airline_section_x = airline#section#create_right(['tagbar', 'filetype'])
      let g:airline_section_x = ''

      " remove y
      "     let g:airline_section_y = airline#section#create_right(['ffenc'])
      let g:airline_section_y = ''

      " keep z
      "     if winwidth(0) > 80
      "       let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%'.spc, 'linenr', 'maxlinenr', spc.':%3v'])
      "     else
      "       let g:airline_section_z = airline#section#create(['%3p%%'.spc, 'linenr',  ':%3v'])
      "     endif

      " keep error
      "     let g:airline_section_error = airline#section#create(['ycm_error_count', 'syntastic-err', 'eclim', 'neomake_error_count', 'ale_error_count'])

      " keep warning
        "     let g:airline_section_warning = airline#section#create(['ycm_warning_count',  'syntastic-warn', 'neomake_warning_count', 'ale_warning_count', 'whitespace'])

      " use single-letter mode descriptions
      let g:airline_mode_map = {
          \ '__' : '-',
          \ 'n'  : 'N',
          \ 'i'  : 'I',
          \ 'R'  : 'R',
          \ 'c'  : 'C',
          \ 'v'  : 'V',
          \ 'V'  : 'V',
          \ '' : 'V',
          \ 's'  : 'S',
          \ 'S'  : 'S',
          \ '' : 'S',
          \ }

  endfunction

  autocmd User AirlineAfterInit call AirlineInit()
