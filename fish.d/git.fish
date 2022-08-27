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

  if [ $argv[1] = "checkout" ]
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gco" 1>&2
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
    set_color -o yellow
    echo -n "gca" 1>&2
    set_color -o normal
    echo -n " or " 1>&2
    set_color -o yellow
    echo -n "gcan" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end

  if [ $argv[1] = "reset" ]
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gr" 1>&2
    set_color -o normal
    echo -n " or " 1>&2
    set_color -o yellow
    echo -n "grm" 1>&2
    set_color -o normal
    echo -n " or " 1>&2
    set_color -o yellow
    echo -n "grh" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end

  if [ $argv[1] = "rebase" ]
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gx" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end

  if [ $argv[1] = "log" ]
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gl" 1>&2
    set_color -o normal
    echo -n " or " 1>&2
    set_color -o yellow
    echo -n "glp" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end

  set -l GIT (which git)
  $GIT $argv
  echo "consider adding a retrain or an alias for this git command"
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

function gco --wraps='git checkout' --description 'alias gco=git-checkout'
  if not set -q argv[1]
    set -l GIT (which git)
    $GIT checkout -p
  else
    git-number checkout $argv
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

function gcan --wraps='git commit --amend --no-edit' --description 'alias gcan=git commit --amend --no-edit'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit --amend --no-edit
  else
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gc" 1>&2
    set_color -o normal
    echo -n " or " 1>&2
    set_color -o yellow
    echo -n "gca" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end
end

function gr --wraps='git reset' --description 'alias gr=git reset'
  if not set -q argv[1]
    set -l GIT (which git)
    $GIT reset
  else
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "grm" 1>&2
    set_color -o normal
    echo -n " or " 1>&2
    set_color -o yellow
    echo -n "grh" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end
end

function grm --wraps='git reset --mixed' --description 'alias grm=git reset --mixed'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT reset --mixed @{u}
  else
    $GIT reset --mixed $argv
  end
end

function grh --wraps='git reset --hard' --description 'alias grh=git reset --hard'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT reset --hard @{u}
  else
    $GIT reset --hard $argv
  end
end

function gx --wraps='git rebase -i' --description 'alias gx=git rebase -i'
  set -l GIT (which git)

  if not set -q argv[1]
    set -l BRANCH ($GIT branch --show-current)
    if test "$BRANCH" = "master"; or test "$BRANCH" = "main"
      # if we're on master, then let's rebase back 20 commits if possible
      $GIT rev-parse --verify HEAD~20 >/dev/null 2>&1
      if test $status -eq 0
        set BASE HEAD~20
      else
        set BASE --root
      end
    else
      # if the user gave no input, we'll rebase off whichever of master or main
      # that exists
      $GIT rev-parse --verify main >/dev/null 2>&1
      if test $status -eq 0
        set BASE main
      else
        set BASE master
      end
    end
  else
    set BASE $argv
  end

  $GIT rebase -i $BASE
end

function gl --wraps='git log' --description 'alias gl=git log'
  set -l GIT (which git)
  $GIT log $argv
end

function glp --wraps='git log -p' --description 'alias glp=git log -p'
  set -l GIT (which git)
  if not set -q argv[1]
    set -l BRANCH ($GIT branch --show-current)
    if test "$BRANCH" = "master"; or test "$BRANCH" = "main"
      # if the user gave no input and we're already on master or main, then
      # just git log -p
      $GIT log -p
    else
      # user gave no input but we're on a branch, so compare to master or main
      $GIT rev-parse --verify main >/dev/null 2>&1
      if test $status -eq 0
        set BASE main
      else
        set BASE master
      end
      $GIT log -p --reverse $BASE..HEAD
    end
  else
    $GIT log -p $argv
  end
end

function gn --wraps='git-number -c' --description 'alias gn=git-number -c'
  git-number -c $argv
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
