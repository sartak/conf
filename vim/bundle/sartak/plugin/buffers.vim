" in normal mode, right and left arrow keys switch buffers
nmap <Right> :bn<CR>
nmap <Left>  :bp<CR>

for s:i in range(1, 9)
  exe 'nmap <leader>'  . s:i . ' :<C-U>echoerr "not implemented yet"<CR>'
  exe 'nmap <leader>b' . s:i . ' :<C-U>echoerr "not implemented yet"<CR>'
endfor

nmap <leader>0  :<C-U>echoerr "not implemented yet"<CR>
nmap <leader>b0 :<C-U>echoerr "not implemented yet"<CR>
