nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>tt :TestLast<CR>
nmap <silent> <leader>ta :TestSuite<CR>

let test#strategy = {
  \ 'nearest': 'floaterm',
  \ 'file':    'floaterm',
  \ 'suite':   'floaterm',
\}
