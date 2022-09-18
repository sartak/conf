" 10 milliseconds for escape timeout instead of 1000
set ttimeoutlen=10
autocmd InsertEnter * set timeoutlen=0
autocmd InsertLeave * set timeoutlen=10

" don't redraw the screen during macros etc (NetHack's runmode:teleport)
set lazyredraw
