function git --wraps=git
  if not status is-interactive
    command git $argv
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

  command git $argv
end

function gs --wraps='git-number --column' --description 'git status'
  command git log -1 --format='format:%C(Yellow)%h%Creset %s'
  git-number -uall $argv
end

function ga --wraps='git-number add' --description 'git add'
  if not set -q argv[1]
    command git add -p
  else
    git-number add $argv
  end
end

function gco --wraps='git checkout' --description 'git checkout'
  if not set -q argv[1]
    command git checkout -p
  else
    git-number checkout $argv
  end
end

function gc --description 'git commit'
  if not set -q argv[1]
    command git commit
  else
    command git commit -m "$argv"
  end
end

function gcp --description 'git commit; git push'
  if not set -q argv[1]
    command git commit
  else
    command git commit -m "$argv"
  end
  command git push
end

function gcs --description 'git commit; git ship'
  if not set -q argv[1]
    command git commit
  else
    command git commit -m "$argv"
  end
  command git ship
end

function gcf --description 'git commit; git push -f'
  if not set -q argv[1]
    command git commit
  else
    command git commit -m "$argv"
  end
  command git push -f
end

function gac --description 'git add; git commit'
  command git add -p
  if not set -q argv[1]
    command git commit
  else
    command git commit -m "$argv"
  end
end

function gacp --description 'git add; git commit; git push'
  command git add -p
  if not set -q argv[1]
    command git commit
  else
    command git commit -m "$argv"
  end
  command git push
end

function gacs --description 'git add; git commit; git ship'
  command git add -p
  if not set -q argv[1]
    command git commit
  else
    command git commit -m "$argv"
  end
  command git ship
end

function gacf --description 'git add; git commit; git push -f'
  command git add -p
  if not set -q argv[1]
    command git commit
  else
    command git commit -m "$argv"
  end
  command git push -f
end

function gep --description 'git commit --amend; git push -f'
  if not set -q argv[1]
    command git commit --amend
  else
    command git commit --amend -m "$argv"
  end
  command git push -f
end

function gef
  gep $argv
end

function ges --description 'git commit --amend; git ship'
  if not set -q argv[1]
    command git commit --amend
  else
    command git commit --amend -m "$argv"
  end
  command git ship
end

function gae --description 'git add; git commit --amend'
  command git add -p
  if not set -q argv[1]
    command git commit --amend
  else
    command git commit --amend -m "$argv"
  end
end

function gaep --description 'git add; git commit --amend; git push -f'
  command git add -p
  if not set -q argv[1]
    command git commit --amend
  else
    command git commit --amend -m "$argv"
  end
  command git push -f
end

function gaes --description 'git add; git commit --amend; git ship'
  command git add -p
  if not set -q argv[1]
    command git commit --amend
  else
    command git commit --amend -m "$argv"
  end
  command git ship
end

function gaef
  gaep $argv
end

function gnp --description 'git commit --amend --no-edit; git push -f'
  if not set -q argv[1]
    command git commit --amend --no-edit
    command git push -f
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gns --description 'git commit --amend --no-edit; git ship'
  if not set -q argv[1]
    command git commit --amend --no-edit
    command git ship
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gnf
  gnp $argv
end

function gxp --description 'git rebase --interactive; git push -f'
  if not set -q argv[1]
    gx
    command git push -f
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gxs --description 'git rebase --interactive; git ship'
  if not set -q argv[1]
    gx
    command git ship
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gxf
  gxp $argv
end

function gan --description 'git add; git commit --amend --no-edit'
  command git add -p
  if not set -q argv[1]
    command git commit --amend --no-edit
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function ganp --description 'git add; git commit --amend --no-edit; git push -f'
  command git add -p
  if not set -q argv[1]
    command git commit --amend --no-edit
    command git push -f
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gans --description 'git add; git commit --amend --no-edit; git ship'
  command git add -p
  if not set -q argv[1]
    command git commit --amend --no-edit
    command git ship
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
  command git add -p
  if not set -q argv[1]
    command git commit --amend --no-edit
  else
    command git commit --amend -m "$argv"
  end
  command git push -f
end

function gr --wraps='git reset' --description 'git reset'
  if not set -q argv[1]
    command git reset
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function grmu --wraps='git reset --mixed @{u}' --description 'git reset --mixed @{u}'
  if not set -q argv[1]
    command git reset --mixed @{u}
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function grm --wraps='git reset --mixed' --description 'git reset --mixed'
  if not set -q argv[1]
    command git reset --mixed
  else if string match -qr '^[0-9]+$' -- "$argv[1]"
    command git reset --mixed HEAD~$argv[1]
  else if test "$argv[1]" = "@{u}"
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "grmu" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  else
    command git reset --mixed $argv
  end
end

function grhu --wraps='git reset --hard @{u}' --description 'git reset --hard @{u}'
  if not set -q argv[1]
    command git reset --hard @{u}
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function grh --wraps='git reset --hard' --description 'git reset --hard'
  if not set -q argv[1]
    command git reset --hard
  else if string match -qr '^[0-9]+$' -- "$argv[1]"
    command git reset --hard HEAD~$argv[1]
  else if test "$argv[1]" = "@{u}"
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "grhu" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  else
    command git reset --hard $argv
  end
end

function gx --wraps='git rebase -i' --description 'git rebase -i'
  if not set -q argv[1]
    set -l BRANCH (command git branch --show-current)
    if test "$BRANCH" = "master"; or test "$BRANCH" = "main"
      # if we're on master, then let's rebase back 20 commits if possible
      command git rev-parse --verify HEAD~20 >/dev/null 2>&1
      if test $status -eq 0
        set BASE HEAD~20
      else
        set BASE --root
      end
    else
      # if the user gave no input, we'll rebase off whichever of master or main
      # that exists
      command git rev-parse --verify main >/dev/null 2>&1
      if test $status -eq 0
        set BASE main
      else
        set BASE master
      end
    end
  else
    set BASE $argv
  end

  command git rebase -i $BASE
end

function gxa --wraps='git rebase --abort' --description 'git rebase --abort'
  command git rebase --abort $argv
end

function gxc --wraps='git rebase --continue' --description 'git rebase --continue'
  command git rebase --continue $argv
end

function gl --wraps='git log' --description 'git log'
  command git log $argv
end

function glp --wraps='git log -p' --description 'git log -p'
  if not set -q argv[1]
    set -l BRANCH (command git branch --show-current)
    if test "$BRANCH" = "master"; or test "$BRANCH" = "main"
      # if the user gave no input and we're already on master or main, then
      # just git log -p
      command git log -p
    else
      # user gave no input but we're on a branch, so compare to master or main
      command git rev-parse --verify main >/dev/null 2>&1
      if test $status -eq 0
        set BASE main
      else
        set BASE master
      end
      command git log -p --reverse $BASE..HEAD
    end
  else
    command git log -p $argv
  end
end

function gu --wraps 'git pull' --description 'git pull'
  command git pull $argv
end

function gus --wraps 'git pull && git submodule update --init --recursive' --description 'git pull'
  command git pull $argv
  command git submodule update --init --recursive
end

function guh --wraps 'git fetch' --description 'git fetch && git reset --hard'
  command git fetch $argv
  command git reset --hard @{u}
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

function git-choose-branch
  set -l IFS
  set BRANCHES (command git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)')
  if test $status -eq 0
    echo $BRANCHES | fzf --no-sort --preview='git log --color=always {} | delta'
  end
end

function git-choose-branches
  set -l IFS
  set BRANCHES (command git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)')
  if test $status -eq 0
    echo $BRANCHES | fzf --multi --no-sort --preview='git log --color=always {} | delta'
  end
end

function gb --wraps='git switch' --description 'git switch'
  if not set -q argv[1]
    set BRANCH (git-choose-branch)
    if test $status -eq 0; and test "$BRANCH" != ""
      command git switch $BRANCH
    end
  else
    if command git switch $argv 2>/dev/null
      gs
    else
      command git switch -c $argv
    end
  end
end

function gbd --wraps='git branch -D' --description 'git branch -D'
  if not set -q argv[1]
    git-choose-branches | xargs command git branch -D
  else
    command git branch -D $argv
  end
end

function gbda --wraps='git branch -D' --description 'git branch -D'
  if not set -q argv[1]
    command git branch --merged master --format='%(refname:short)' | grep -v '^master$' | xargs command git branch -d
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gua --wraps='git un-amend' --description 'git un-amend'
  if not set -q argv[1]
    command git un-amend
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gvd --description 'edit uncommitted changes'
  set -l FILES (command git diff HEAD --name-only; command git ls-files --others --exclude-standard)
  if [ "$FILES" = "" ]
    set_color -o yellow
    echo "no uncommitted files" 1>&2
    return 1
  end

  command vim $FILES
end

function gvu --description 'edit files changed since upstream'
  set -l FILES (command git diff @{u} --name-only; command git ls-files --others --exclude-standard)
  if [ "$FILES" = "" ]
    set_color -o yellow
    echo "no unchanged files" 1>&2
    return 1
  end

  command vim $FILES
end

function gvm --description 'edit files changed since branch'
  set -l FILES (command git diff master --name-only; command git ls-files --others --exclude-standard)
  if [ "$FILES" = "" ]
    set_color -o yellow
    echo "no unchanged files" 1>&2
    return 1
  end

  command vim $FILES
end
