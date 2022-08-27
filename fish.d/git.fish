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
    echo -n "gcn" 1>&2
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

function gs --wraps='git-number --column' --description 'git status'
  git-number -uall $argv
end

function ga --wraps='git-number add' --description 'git add'
  if not set -q argv[1]
    set -l GIT (which git)
    $GIT add -p
  else
    git-number add $argv
  end
end

function gco --wraps='git checkout' --description 'git checkout'
  if not set -q argv[1]
    set -l GIT (which git)
    $GIT checkout -p
  else
    git-number checkout $argv
  end
end

function gc --description 'git commit'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit
  else
    $GIT commit -m "$argv"
  end
end

function gcp --description 'git commit; git push'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit
  else
    $GIT commit -m "$argv"
  end
  $GIT push
end

function gac --description 'git add; git commit'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit
  else
    $GIT commit -m "$argv"
  end
end

function gacp --description 'git add; git commit; git push'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit
  else
    $GIT commit -m "$argv"
  end
  $GIT push
end

function gca --description 'git commit --amend'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit --amend
  else
    $GIT commit --amend -m "$argv"
  end
end

function gcap --description 'git commit --amend; git push -f'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit --amend
  else
    $GIT commit --amend -m "$argv"
  end
  $GIT push -f
end

function gaca --description 'git add; git commit --amend'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend
  else
    $GIT commit --amend -m "$argv"
  end
end

function gacap --description 'git add; git commit --amend; git push -f'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend
  else
    $GIT commit --amend -m "$argv"
  end
  $GIT push -f
end

function gcn --description 'git commit --amend --no-edit'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit --amend --no-edit
  else
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gca" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end
end

function gcnp --description 'git commit --amend --no-edit; git push -f'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit --amend --no-edit
    $GIT push -f
  else
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gcap" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end
end

function gacn --description 'git add; git commit --amend --no-edit'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend --no-edit
  else
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gaca" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end
end

function gacnp --description 'git add; git commit --amend --no-edit; git push -f'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend --no-edit
    $GIT push -f
  else
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gacap" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  end
end

function gq --description 'git add; git commit --amend [--no-edit]; git push -f'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend --no-edit
  else
    $GIT commit --amend -m "$argv"
  end
  $GIT push -f
end

function gr --wraps='git reset' --description 'git reset'
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

function grm --wraps='git reset --mixed' --description 'git reset --mixed'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT reset --mixed @{u}
  else
    $GIT reset --mixed $argv
  end
end

function grh --wraps='git reset --hard' --description 'git reset --hard'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT reset --hard @{u}
  else
    $GIT reset --hard $argv
  end
end

function gx --wraps='git rebase -i' --description 'git rebase -i'
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

function gl --wraps='git log' --description 'git log'
  set -l GIT (which git)
  $GIT log $argv
end

function glp --wraps='git log -p' --description 'git log -p'
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

function gn --wraps='git-number -c' --description 'git-number -c'
  git-number -c $argv
end

function gv --wraps='git-number -c vim' --description 'git-number -c vim'
  git-number -c vim $argv
end

function grm --wraps='git-number -c rm' --description 'git-number -c rm'
  git-number -c rm $argv
end

