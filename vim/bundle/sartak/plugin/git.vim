autocmd FileType gitcommit setlocal tw=72
autocmd FileType gitcommit if getline(1) == "" | startinsert
" see also navigation.vim
