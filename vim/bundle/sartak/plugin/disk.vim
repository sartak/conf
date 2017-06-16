" :bn with a change in the current buffer? no prob!
set hidden

" automatically read in external changes if we haven't yet modified the buffer
set autoread

" just write for me, I use git
set autowriteall

" when I wander away, write to disk
autocmd FocusLost * :wa

" swapfiles have been nothing but a nuisance to me
set noswapfile

