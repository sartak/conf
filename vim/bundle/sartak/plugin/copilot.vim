" Crawl before you run
let g:copilot_filetypes = {
      \ 'rust': v:false,
      \ }

imap <silent><script><expr> <Right> copilot#Accept("\<Right>")
let g:copilot_no_tab_map = v:true
