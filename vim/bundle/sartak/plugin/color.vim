set termguicolors

colorscheme molokai

hi Normal ctermbg=none guibg=#000000

" macOS isn't telling latest vim about italics correctly
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
hi Comment term=bold cterm=italic ctermfg=59 gui=italic guifg=#5f5f5f

hi Pmenu ctermfg=8 guifg=#555555 ctermbg=0 guibg=#000000
hi CocMenuSel ctermfg=white guifg=#FFFFFF ctermbg=17 guibg=#00005f
hi PmenuSel ctermfg=white guifg=#FFFFFF ctermbg=17 guibg=#00005f
hi CocFloating ctermfg=8 guifg=#555555 ctermbg=0 guibg=#000000
hi CocSearch ctermfg=8 guifg=#555555

hi Search ctermfg=0 guifg=#000000 ctermbg=220 guibg=#ffd700
hi IncSearch ctermfg=0 guifg=#000000 ctermbg=220 guibg=#ffd700

hi String cterm=none ctermfg=215 guifg=#ffaf5f ctermbg=234 guibg=#1c1c1c

hi CocSnippetVisual ctermfg=206 guifg=#ff5fd7

hi SneakLabel ctermfg=15 guifg=#161616 ctermbg=161 guibg=#d7005f

hi FloatermBorder guibg=#000000 guifg=#222222
let g:fzf_colors =
\ { 'fg':         ['fg', 'Normal'],
  \ 'fg+':        ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'bg+':        ['bg', 'Normal'],
  \ 'hl':         ['bg', 'IncSearch'],
  \ 'hl+':        ['bg', 'IncSearch'],
  \ 'preview-fg': ['fg', 'Normal'],
  \ 'preview-bg': ['bg', 'Normal'],
  \ 'gutter':     ['bg', 'Normal'],
  \ 'pointer':    ['fg', 'Structure'],
  \ 'marker':     ['fg', 'Conditional'],
  \ 'query':      ['fg', 'Type'],
  \ 'disabled':   ['bg', 'Normal'],
  \ 'border':     ['fg', 'FloatermBorder'],
  \ 'info':       ['fg', 'Comment'],
  \ 'prompt':     ['fg', 'Exception'],
  \ 'spinner':    ['fg', 'Exception'],
  \ 'header':     ['fg', 'Normal'] }

" fix gui blue for ctermfg=81 in molokai
hi Define          guifg=#5fd7ff
hi SpecialKey      guifg=#5fd7ff
hi PmenuThumb      guifg=#5fd7ff
hi Question        guifg=#5fd7ff
hi Special         guifg=#5fd7ff
hi Structure       guifg=#5fd7ff
hi Typedef         guifg=#5fd7ff
hi Type            guifg=#5fd7ff
hi WildMenu        guifg=#5fd7ff
