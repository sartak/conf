function git --wraps=git
  if not status is-interactive
    functions -c git git_tmp
    functions -e git
    git $argv
    functions -c git_tmp git
    functions -e git_tmp
    return
  end

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
    echo " (etc) instead" 1>&2
    return 1
  end

  if [ $argv[1] = "reset" ]
    echo -n "use " 1>&2

    set_color -o yellow

    if not set -q argv[2]
      echo -n "gr" 1>&2
    else if [ $argv[2] = "--hard" ]
      echo -n "grh" 1>&2
    else if [ $argv[2] = "--mixed" ]
      echo -n "grm" 1>&2
    else
      echo -n "gr" 1>&2
    end
    set_color -o normal

    echo " instead" 1>&2
    return 1
  end

  if [ $argv[1] = "rebase" ]
    if not set -q argv[2]
    else if [ $argv[2] = "-i" ]
      echo -n "use " 1>&2
      set_color -o yellow
      echo -n "gx" 1>&2
      set_color -o normal
      echo " (etc) instead" 1>&2
      return 1
    else if [ $argv[2] = "--abort" ]
      echo -n "use " 1>&2
      set_color -o yellow
      echo -n "gxa" 1>&2
      set_color -o normal
      echo " (etc) instead" 1>&2
      return 1
    else if [ $argv[2] = "--continue" ]
      echo -n "use " 1>&2
      set_color -o yellow
      echo -n "gxc" 1>&2
      set_color -o normal
      echo " (etc) instead" 1>&2
      return 1
    end
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

  if [ $argv[1] = "push" ]
    if not set -q argv[2]
      echo -n "use " 1>&2
      set_color -o yellow
      echo -n "gcp" 1>&2
      set_color -o normal
      echo " (etc) instead" 1>&2
      return 1
    else if [ $argv[2] = "-f" ]
      echo -n "use " 1>&2
      set_color -o yellow
      echo -n "gcf" 1>&2
      set_color -o normal
      echo " (etc) instead" 1>&2
      return 1
    end
  end

  set -l GIT (which git)
  $GIT $argv
  echo "consider adding a retrain or an alias for this git command"
end

function gs --wraps='git-number --column' --description 'git status'
  set -l GIT (which git)
  $GIT log -1 --format='format:%C(Yellow)%h%Creset %s'
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

function gcs --description 'git commit; git ship'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit
  else
    $GIT commit -m "$argv"
  end
  $GIT ship
end

function gcf --description 'git commit; git push -f'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit
  else
    $GIT commit -m "$argv"
  end
  $GIT push -f
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

function gacs --description 'git add; git commit; git ship'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit
  else
    $GIT commit -m "$argv"
  end
  $GIT ship
end

function gacf --description 'git add; git commit; git push -f'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit
  else
    $GIT commit -m "$argv"
  end
  $GIT push -f
end

function gep --description 'git commit --amend; git push -f'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit --amend
  else
    $GIT commit --amend -m "$argv"
  end
  $GIT push -f
end

function gef
  gep $argv
end

function ges --description 'git commit --amend; git ship'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit --amend
  else
    $GIT commit --amend -m "$argv"
  end
  $GIT ship
end

function gae --description 'git add; git commit --amend'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend
  else
    $GIT commit --amend -m "$argv"
  end
end

function gaep --description 'git add; git commit --amend; git push -f'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend
  else
    $GIT commit --amend -m "$argv"
  end
  $GIT push -f
end

function gaes --description 'git add; git commit --amend; git ship'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend
  else
    $GIT commit --amend -m "$argv"
  end
  $GIT ship
end

function gaef
  gaep $argv
end

function gnp --description 'git commit --amend --no-edit; git push -f'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit --amend --no-edit
    $GIT push -f
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gns --description 'git commit --amend --no-edit; git ship'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT commit --amend --no-edit
    $GIT ship
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gnf
  gnp $argv
end

function gan --description 'git add; git commit --amend --no-edit'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend --no-edit
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function ganp --description 'git add; git commit --amend --no-edit; git push -f'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend --no-edit
    $GIT push -f
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gans --description 'git add; git commit --amend --no-edit; git ship'
  set -l GIT (which git)
  $GIT add -p
  if not set -q argv[1]
    $GIT commit --amend --no-edit
    $GIT ship
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function ganf --description 'git add; git commit --amend --no-edit; git push -f'
  ganp $argv
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
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function grmu --wraps='git reset --mixed @{u}' --description 'git reset --mixed @{u}'
  if not set -q argv[1]
    set -l GIT (which git)
    $GIT reset --mixed @{u}
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function grm --wraps='git reset --mixed' --description 'git reset --mixed'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT reset --mixed
  else if string match -qr '^[0-9]+$' -- "$argv[1]"
    $GIT reset --mixed HEAD~$argv[1]
  else if test "$argv[1]" = "@{u}"
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "grmu" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  else
    $GIT reset --mixed $argv
  end
end

function grhu --wraps='git reset --hard @{u}' --description 'git reset --hard @{u}'
  if not set -q argv[1]
    set -l GIT (which git)
    $GIT reset --hard @{u}
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function grh --wraps='git reset --hard' --description 'git reset --hard'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT reset --hard
  else if string match -qr '^[0-9]+$' -- "$argv[1]"
    $GIT reset --hard HEAD~$argv[1]
  else if test "$argv[1]" = "@{u}"
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "grhu" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
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

function gxa --wraps='git rebase --abort' --description 'git rebase --abort'
  set -l GIT (which git)
  $GIT rebase --abort $argv
end

function gxc --wraps='git rebase --continue' --description 'git rebase --continue'
  set -l GIT (which git)
  $GIT rebase --continue $argv
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

function gu --wraps 'git pull' --description 'git pull'
  set -l GIT (which git)
  $GIT pull $argv
end

function gus --wraps 'git pull && git submodule update --init --recursive' --description 'git pull'
  set -l GIT (which git)
  $GIT pull $argv
  $GIT submodule update --init --recursive
end

function guh --wraps 'git fetch' --description 'git fetch && git reset --hard'
  set -l GIT (which git)
  $GIT fetch $argv
  $GIT reset --hard @{u}
end

function gn --wraps='git-number -c' --description 'git-number -c'
  git-number -c $argv
end

function gv --wraps='git-number -c vim' --description 'git-number -c vim'
  git-number -c vim $argv
end

function gnr --wraps='git-number -c rm -r' --description 'git-number -c rm -r'
  git-number -c rm -r $argv
end

function gb --wraps='git checkout -b' --description 'git checkout -b'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT choose-branch | xargs --no-run-if-empty $GIT checkout
  else
    $GIT checkout -b $argv
  end
end

function gbd --wraps='git branch -D' --description 'git branch -D'
  set -l GIT (which git)
  if not set -q argv[1]
    $GIT choose-branches | xargs --no-run-if-empty $GIT branch -D
  else
    $GIT branch -D $argv
  end
end

function gbda --wraps='git branch -D' --description 'git branch -D'
  if not set -q argv[1]
    set -l GIT (which git)
    $GIT branch --merged master --format='%(refname:short)' | grep -v '^master$' | xargs $GIT branch -d
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gua --wraps='git un-amend' --description 'git un-amend'
  if not set -q argv[1]
    set -l GIT (which git)
    $GIT un-amend
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gvd --description 'edit uncommitted changes'
  set -l GIT (which git)
  set -l VIM (which vim)

  set -l FILES ($GIT diff HEAD --name-only; $GIT ls-files --others --exclude-standard)
  if [ "$FILES" = "" ]
    set_color -o yellow
    echo "no uncommitted files" 1>&2
    return 1
  end

  $VIM $FILES
end

function gvu --description 'edit files changed since upstream'
  set -l GIT (which git)
  set -l VIM (which vim)

  set -l FILES ($GIT diff @{u} --name-only; $GIT ls-files --others --exclude-standard)
  if [ "$FILES" = "" ]
    set_color -o yellow
    echo "no unchanged files" 1>&2
    return 1
  end

  $VIM $FILES
end

function gvm --description 'edit files changed since branch'
  set -l GIT (which git)
  set -l VIM (which vim)

  set -l FILES ($GIT diff master --name-only; $GIT ls-files --others --exclude-standard)
  if [ "$FILES" = "" ]
    set_color -o yellow
    echo "no unchanged files" 1>&2
    return 1
  end

  $VIM $FILES
end
