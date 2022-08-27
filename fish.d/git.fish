function git --wraps=git
  if [ $argv[1] = "status" ]
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gs" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end

  if [ $argv[1] = "add" ]
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "ga" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end

  if [ $argv[1] = "commit" ]
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gc" 1>&2
    set_color -o normal
    echo -n " or " 1>&2
    echo -n "gca" 1>&2
    set_color -o normal
    echo " instead" 1>&2
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

function gc --wraps='git commit' --description 'alias gc=git commit'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit
  else
    $GIT commit -m "$argv"
  end
end

function gca --wraps='git commit --amend' --description 'alias gca=git commit --amend'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit --amend
  else
    $GIT commit --amend -m "$argv"
  end
end

function gv --wraps='git-number -c vim' --description 'alias gv=git-number -c vim'
  git-number -c vim $argv
end

function gg
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend --no-edit
  else
    $GIT commit --amend -m "$argv"
  end
  $GIT push -f
end
