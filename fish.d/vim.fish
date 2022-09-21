function vim --wraps=vim
  if not status is-interactive
    command vim $argv
    return
  end

  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "v" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function v --wraps=vim --description 'alias v=vim'
  command vim $argv
end

# shout out to https://github.com/tsibley/g
function vg --wraps=rg --description 'vim ripgrep'
  if set -q argv[1]
    set REGEX $argv[1]
    set FILES (command rg -l $argv)
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

  command vim +1 "+/\v$REGEX" $FILES
end

function vf --wraps=vim --description 'vim fzf'
  set -l FILES (fzf --query "$argv" --multi --preview='if test {} = ""; echo; else if test -f {}; bat --color=always {}; else; echo "File does not exist"; end')
  set -l st $status
  if test $st -ne 0; or test "$FILES" = ""
    return $st
  end
  command vim $FILES
end

function edit_command
  set -xl VISUAL /usr/local/bin/vim
  edit_command_buffer
end

function vs- --description 'launch most recent vim session'
  if set -q argv[1]
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  else
    set session (
      exa -1 --sort modified --reverse ~/.vim/sessions/ | head -n1
    )
    if test "$session" = ""
      echo "no sessions exist; run `vs <session>` or `\\sc` in vim to create" 1>&2
      return
    end

    command vim -c ":silent SessionOpen $session"
  end
end

function v- --description 'launch transient vim session'
  if set -q argv[1]
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  else
    command vim -c ":silent call LoadTransientSession()"
  end
end

function vs --description 'launch vim session'
  set newsession 0

  if not set -q argv[1]
    set exa_opts -1 --sort accessed --reverse ~/.vim/sessions/
    set sessions (
      echo "(transient)"
      exa $exa_opts
    )
    set session (
      printf "%s\n" $sessions | \
        fzf \
          --prompt="vim session > " \
          --exit-0 \
          --header \e"[38;5;240;3mctrl-x to delete, ctrl-c to quit" \
          --preview-window='bottom:50%' \
          --info=hidden \
          --preview='set file {}; if test {} = "(transient)"; z $HOME/.vim; set file .transient.session; else; z $HOME/.vim/sessions/; end; stat -f "Accessed: %Sa%nModified: %Sm%nCreated:  %SB" $file; echo; set_color 23A5FA; g --color=never "^cd (.+)" -r \'$1\' $file; set_color -o normal; g --color=never "^badd \+\d+ (.+)" -r \'  - $1\' $file' \
          --bind "ctrl-x:execute-silent(rm ~/.vim/sessions/{})+reload(exa $exa_opts)"
    )
    if test $status -ne 0
        set session (
          exa ~/.vim/sessions/ | head -n1
        )
        if test "$session" = ""
          echo "no sessions exist; run `vs <session>` or `\\sc` in vim to create" 1>&2
        end
      return
    end
  else if test "$argv[1]" = "-"
    vs-
    return
  else
    set session $argv[1]
    if not test -e "$HOME/.vim/sessions/$argv[1]"
      set newsession 1
    end
  end

  if test "$session" = "(transient)"
    command vim -c ":silent call LoadTransientSession()"
  else if test $newsession -eq 1
    command vim -c ":silent SessionSaveAs $session"
  else
    command vim -c ":silent SessionOpen $session"
  end
end
