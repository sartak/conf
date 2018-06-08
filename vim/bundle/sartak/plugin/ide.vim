let g:airline_powerline_fonts = 1
let g:airline_theme='deus'

let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0
let g:gitgutter_enabled = 0
let g:gitgutter_override_sign_column_highlight = 0
if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" the same as airline
highlight SignColumn ctermbg=234

highlight ALEErrorSign ctermfg=1 ctermbg=234
highlight ALEWarningSign ctermfg=3 ctermbg=234

highlight GitGutterAdd ctermfg=5 ctermbg=234
highlight GitGutterChange ctermfg=5 ctermbg=234
highlight GitGutterChangeDelete ctermfg=5 ctermbg=234
highlight GitGutterDelete ctermfg=5 ctermbg=234

let g:ale_sign_error = '！'
let g:ale_sign_warning = '？'

let g:gitgutter_sign_added = '・'
let g:gitgutter_sign_modified = '・'
let g:gitgutter_sign_removed = '・'
let g:gitgutter_sign_removed_first_line = '・'
let g:gitgutter_sign_modified_removed = '・'

" let g:ale_fixers = {'javascript': ['prettier'], 'scss': ['prettier'], 'css': ['prettier']}
" let g:ale_fix_on_save = 1

let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

let g:closetag_filenames = "*.html,*.xhtml,*.js,*.jsx"
let g:closetag_xhtml_filenames = '*.xhtml,*.js,*.jsx,*.erb'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'

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
