function ls --wraps=exa
  if not set -q argv[1]
    exa
  else if test "$argv[1]" = "-l"; or test "$argv[1]" = "-la"
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "ll" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  else
    exa $argv
  end
end

function ll --wraps='exa' --description 'alias ll=exa -l --git'
  exa -l --git $argv
end
