function jqrepl --wraps='fzrepl "jq --color-output"'
  FZREPL_FILE=jqhistory fzrepl "jq --color-output" $argv
end
