function ls --wraps=ls
  if not status is-interactive
    functions -c ls ls_tmp
    functions -e ls
    ls $argv
    functions -c ls_tmp ls
    functions -e ls_tmp
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
  echo " instead" 1>&2
  return 1
end

function l --wraps='exa' --description 'exa'
  exa $argv
end

function ll --wraps='exa' --description 'exa -l'
  exa -l --git $argv
end
