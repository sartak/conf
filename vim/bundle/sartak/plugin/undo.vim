" persistent undo
if exists("+undofile")
    set undofile
    set undodir=/tmp
endif

let g:mundo_width=10
let g:mundo_preview_height=8
let g:mundo_preview_bottom=1
let g:mundo_verbose_graph=0
let g:mundo_header=0
nnoremap U :MundoToggle<CR>
