function ls --wraps=ls
  if not status is-interactive
    command ls $argv
    return
  end

  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "l" 1>&2
  set_color -o normal
  echo -n " or " 1>&2
  set_color -o yellow
  echo -n "ll" 1>&2
  set_color -o normal
  echo -n " or " 1>&2
  set_color -o yellow
  echo -n "la" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function l --wraps='exa' --description 'exa'
  if test "$argv[1]" = "-l"
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "ll" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  else if test "$argv[1]" = "-a"; or test "$argv[1]" = "-la"; or test "$argv[1]" = "-al"
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "la" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  else
    exa $argv
  end
end

function ll --wraps='exa' --description 'exa -l'
  if test "$argv[1]" = "-a"
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "la" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  else
    exa -l --git $argv
  end
end

function la --wraps='exa' --description 'exa -la'
  exa -la --git $argv
end
