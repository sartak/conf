function z- --wraps='z -' --description 'z -'
  if not set -q argv[1]
    z -
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end
