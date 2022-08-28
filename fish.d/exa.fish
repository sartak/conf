function ls --wraps=exa
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
