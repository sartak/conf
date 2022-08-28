function PrepareCommitBuffer()
  setlocal tw=72

  let isamend = getline(1) != ""

  " Insert or update parent commit message
  silent keeppatterns g/^# Parent:    /d
  silent execute "keeppatterns normal! gg/^# Please enter the commit message for your changes\<CR>j"
  if search("^# Initial commit$") == 0
    if isamend
      silent read !git log HEAD~2..HEAD~1 --format='format:\%h \%s'
    else
      silent read !git log -1 --format='format:\%h \%s'
    end

    silent execute "normal! I#\<CR># Parent:    "

    " Coalesce with other headers, if present
    if search("\\%#.*\\n#\\n# [a-zA-Z]\\+:")
      silent execute "normal! jdd"
    endif
  endif

  " Go back to the top line
  silent execute "normal! gg0"

  " If the summary is empty (ie not an amend) then enter insert mode
  if !isamend
    startinsert
  endif

  syn match gitcommitParentHeader "\%(^. \)\@<=Parent:" contained containedin=gitcommitComment nextgroup=gitcommitParentHash skipwhite
  syn match gitcommitParentHash "\<\x\{7,}\>" contains=@NoSpell display nextgroup=gitcommitParentSummary skipwhite
  syn match gitcommitParentSummary "[^ ].*" contains=@NoSpell contained skipwhite

  hi def link gitcommitParentHeader  gitcommitHeader
  hi def link gitcommitParentHash    gitcommitHash
  hi def link gitcommitParentSummary gitcommitSummary
endfunc

autocmd FileType gitcommit call PrepareCommitBuffer()
" see also navigation.vim
