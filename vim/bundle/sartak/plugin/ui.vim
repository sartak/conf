" no bells whatsoever
set vb t_vb=

set wildoptions=pum

set ttyfast

set display+=lastline

" Change shape of cursor based on mode
let &t_SI = "\<Esc>[5 q" " insert mode, vertical bar
let &t_SR = "\<Esc>[3 q" " replace mode, underscore
let &t_EI = "\<Esc>[2 q" " normal mode, block
