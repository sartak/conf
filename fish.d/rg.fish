function grep --wraps=grep
  if not status is-interactive
    functions -c grep grep_tmp
    functions -e grep
    grep $argv
    functions -c grep_tmp grep
    functions -e grep_tmp
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
    functions -c rg rg_tmp
    functions -e rg
    rg $argv
    functions -c rg_tmp rg
    functions -e rg_tmp
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
  set -l RG (which rg)
  $RG $argv
end

