function git --wraps=git
  if [ $argv[1] = "status" ]
    echo "use gs instead" 1>&2
    return 1
  end

  if [ $argv[1] = "add" ]
    echo "use ga instead" 1>&2
    return 1
  end

  set -l GIT (which git)
  $GIT $argv
end

function gs --wraps='git-number --column' --description 'alias gs=git-number --column'
  git-number --column -uall $argv
end

function ga --wraps='git-number add' --description 'alias ga=git-number add'
  if not set -q argv[1]
    set -l GIT (which git)
    $GIT add -p
  else
    git-number add $argv
  end
end

function gv --wraps='git-number -c vim' --description 'alias gv=git-number -c vim'
  git-number -c vim $argv
end
