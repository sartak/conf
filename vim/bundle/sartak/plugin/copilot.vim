" Crawl before you run
let g:copilot_filetypes = {
      \ 'rust': v:false,
      \ }

imap <silent><script><expr> <S-Tab> copilot#Accept("")
let g:copilot_no_tab_map = v:true
