function grep --wraps=grep
  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "g" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function rg --wraps=rg
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

