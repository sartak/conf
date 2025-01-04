function vim --wraps=nvim
  if not status is-interactive
    command nvim $argv
    return
  end

  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "v" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function v --wraps=nvim --description 'alias v=nvim'
  if set -q argv[1]
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "ctrl-t" 1>&2
    set_color -o normal
    echo " inside vim instead" 1>&2
    return 1
  end

  command nvim $argv
end

# shout out to https://github.com/tsibley/g
function vg --wraps=rg --description 'nvim ripgrep'
  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "ctrl-g" 1>&2
  set_color -o normal
  echo " inside vim instead" 1>&2
  return 1

  set -l args $argv
  argparse 'w/word-regexp' -- $argv

  if set -q argv[1]
    set REGEX $argv[1]
    set FILES (command rg -l $args)
    set -l st $status
    if test $st -ne 0; or test "$FILES" = ""
        return $st
    end
  else
    set -l RESULT (echo | fzf --print-query --ansi --phony --prompt="rg > " --delimiter=':' --preview-window='+{2}-/2' --bind="change:reload:if test {q} = \"\"; echo; else; rg --no-heading --line-number --color=always 2>/dev/null {q}; end" --preview='if test {1} = ""; echo; else if test -f {1}; bat --color=always --highlight-line={2} {1}; else; echo "File does not exist"; end')
    set -l st $status
    if test $st -ne 0; or test "$RESULT" = ""; or test "$RESULT[1]" = ""
        return $st
    end
    set REGEX $RESULT[1]

    set FILES (command rg -l "$REGEX")
    set -l st $status
    if test $st -ne 0; or test "$FILES" = ""
        return $st
    end
  end

  # TODO https://github.com/tsibley/g/blob/master/g#L184

  if set --query _flag_word_regexp
    set REGEX "<$REGEX>"
  end

  command nvim +1 "+/\v$REGEX" $FILES
end

function vf --wraps=nvim --description 'nvim fzf'
  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "ctrl-g" 1>&2
  set_color -o normal
  echo " inside vim instead" 1>&2
  return 1

  set -l FILES (fzf --query "$argv" --multi --preview='if test {} = ""; echo; else if test -f {}; bat --color=always {}; else; echo "File does not exist"; end')
  set -l st $status
  if test $st -ne 0; or test "$FILES" = ""
    return $st
  end
  command nvim $FILES
end

function edit_command
  set -xl VISUAL /usr/local/bin/nvim
  edit_command_buffer
end
