" persistent undo
if exists("+undofile")
    set undofile
    set undodir=/tmp
endif

" gundo
nmap <silent> <leader>u :GundoToggle<CR>

