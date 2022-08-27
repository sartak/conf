function gs --wraps='git-number --column' --description 'alias gs=git-number --column'
  git-number --column -uall $argv
end

function ga --wraps='git-number add' --description 'alias ga=git-number add'
  if not set -q argv[1]
    git add -p
  else
    git-number add $argv
  end
end
