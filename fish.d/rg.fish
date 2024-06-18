function grep --wraps=grep
  if not status is-interactive
    command grep $argv
    return
  end

  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "g" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function rg --wraps=rg
  if not status is-interactive
    command rg $argv
    return
  end

  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "g" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function g --wraps='rg' --description 'alias g=rg'
  if not set -q argv[1]
    _gs
  else
    command rg $argv
  end
end
