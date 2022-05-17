nnoremap _html :-1read $HOME/.vim/snippets/html.html<CR>5j2f<i

autocmd FileType javascript,typescript,javascriptreact,typescriptreact nnoremap <buffer> _fn :-1read $HOME/.vim/snippets/fn.js<CR>wcw
autocmd FileType javascriptreact nnoremap <buffer> _comp :-1read $HOME/.vim/snippets/comp.jsx<CR>2j2wcw
autocmd FileType typescriptreact nnoremap <buffer> _comp :-1read $HOME/.vim/snippets/comp.tsx<CR>4j2wcw
autocmd FileType javascriptreact,typescriptreact nnoremap <buffer> _nextdoc :-1read $HOME/.vim/snippets/nextdoc.jsx<CR>
autocmd FileType javascript nnoremap <buffer> _api :-1read $HOME/.vim/snippets/api.js<CR>j
autocmd FileType typescript nnoremap <buffer> _api :-1read $HOME/.vim/snippets/api.ts<CR>3j
