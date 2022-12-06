function git --wraps=hub
  if not status is-interactive
    command hub $argv
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

  command hub $argv
end

function gs --wraps='git-number --column' --description 'git status'
  command git log -1 --format='format:%C(Yellow)%h%Creset %s'
  if test $status -eq 0
    git-number -uall $argv
  end
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

function gc_amend --description 'git commit'
  if not set -q argv[1]
    command git commit --amend
  else
    command git commit --amend -m "$argv"
  end
end

function gc_edit --description 'git commit'
  command git commit --amend --no-edit
end

function gcx --description 'git commit; gx'
  if not set -q argv[1]
    gc "@@@ Temporary commit"
  else
    gc "$argv"
  end
  gx
end

function gcp --description 'git commit; git push'
  if not set -q argv[1]
    gc
  else
    gc "$argv"
  end
  command git push
end

function gcxp --description 'git commit; gx; git push'
  gcxf $argv
end

function gcs --description 'git commit; git ship'
  if not set -q argv[1]
    gc
  else
    gc "$argv"
  end
  command git ship
end

function gcxs --description 'git commit; gx; git ship'
  if not set -q argv[1]
    gc '@@@ Temporary commit'
  else
    gc "$argv"
  end
  gx
  command git ship
end

function gcf --description 'git commit; git push -f'
  if not set -q argv[1]
    gc
  else
    gc "$argv"
  end
  command git push -f
end

function gcxf --description 'git commit; gx; git push -f'
  if not set -q argv[1]
    gc "@@@ Temporary commit"
  else
    gc "$argv"
  end
  gx
  command git push -f
end

function gac --description 'git add; git commit'
  command git add -p
  if not set -q argv[1]
    gc
  else
    gc "$argv"
  end
end

function gacx --description 'git add; git commit; gx'
  command git add -p
  if not set -q argv[1]
    gc "@@@ Temporary commit"
  else
    gc "$argv"
  end
  gx
end

function gax --description 'git add; git commit'
  gacx $argv
end

function gacp --description 'git add; git commit; git push'
  command git add -p
  if not set -q argv[1]
    gc
  else
    gc "$argv"
  end
  command git push
end

function gaxp --description 'git add; git commit; gx; git push'
  gacxf $argv
end

function gacxp --description 'git add; git commit; gx; git push'
  gacxf $argv
end

function gacs --description 'git add; git commit; git ship'
  command git add -p
  if not set -q argv[1]
    gc
  else
    gc "$argv"
  end
  command git ship
end

function gacxs --description 'git add; git commit; gx; git ship'
  command git add -p
  if not set -q argv[1]
    gc "@@@ Temporary commit"
  else
    gc "$argv"
  end
  gx
  command git ship
end

function gaxs --description 'git add; git commit; gx; git ship'
  gacxs $argv
end

function gacf --description 'git add; git commit; git push -f'
  command git add -p
  if not set -q argv[1]
    gc
  else
    gc "$argv"
  end
  command git push -f
end

function gacxf --description 'git add; git commit; gx; git push -f'
  command git add -p
  if not set -q argv[1]
    gc "@@@ Temporary commit"
  else
    gc "$argv"
  end
  gx
  command git push -f
end

function gep --description 'git commit --amend; git push -f'
  if not set -q argv[1]
    gc_amend
  else
    gc_amend "$argv"
  end
  command git push -f
end

function gef
  gep $argv
end

function ges --description 'git commit --amend; git ship'
  if not set -q argv[1]
    gc_amend
  else
    gc_amend "$argv"
  end
  command git ship
end

function gae --description 'git add; git commit --amend'
  command git add -p
  if not set -q argv[1]
    gc_amend
  else
    gc_amend "$argv"
  end
end

function gaex --description 'git add; git commit --amend; gx'
  command git add -p
  if not set -q argv[1]
    gc_amend
  else
    gc_amend "$argv"
  end
  gx
end

function gaep --description 'git add; git commit --amend; git push -f'
  command git add -p
  if not set -q argv[1]
    gc_amend
  else
    gc_amend "$argv"
  end
  command git push -f
end

function gaexp --description 'git add; git commit --amend; gx; git push -f'
  command git add -p
  if not set -q argv[1]
    gc_amend
  else
    gc_amend "$argv"
  end
  gx
  command git push -f
end

function gaes --description 'git add; git commit --amend; git ship'
  command git add -p
  if not set -q argv[1]
    gc_amend
  else
    gc_amend "$argv"
  end
  command git ship
end

function gaexs --description 'git add; git commit --amend; gx; git ship'
  command git add -p
  if not set -q argv[1]
    gc_amend
  else
    gc_amend "$argv"
  end
  gx
  command git ship
end

function gaef
  gaep $argv
end

function gaexf
  gaexp $argv
end

function gnp --description 'git commit --amend --no-edit; git push -f'
  if not set -q argv[1]
    gc_edit
    command git push -f
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gnxp --description 'git commit --amend --no-edit; gx; git push -f'
  if not set -q argv[1]
    gc_edit
    gx
    command git push -f
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gns --description 'git commit --amend --no-edit; git ship'
  if not set -q argv[1]
    gc_edit
    command git ship
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gnxs --description 'git commit --amend --no-edit; gx; git ship'
  if not set -q argv[1]
    gc_edit
    gx
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

function gnxf
  gnxp $argv
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
    gc_edit
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function ganx --description 'git add; git commit --amend --no-edit; gx'
  command git add -p
  if not set -q argv[1]
    gc_edit
    gx
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function ganp --description 'git add; git commit --amend --no-edit; git push -f'
  command git add -p
  if not set -q argv[1]
    gc_edit
    command git push -f
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function ganxp --description 'git add; git commit --amend --no-edit; gx; git push -f'
  command git add -p
  if not set -q argv[1]
    gc_edit
    gx
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
    gc_edit
    command git ship
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function ganxs --description 'git add; git commit --amend --no-edit; gx; git ship'
  command git add -p
  if not set -q argv[1]
    gc_edit
    gx
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

function ganxf --description 'git add; git commit --amend --no-edit; gx; git push -f'
  ganxp $argv
end

function gq --description 'git add; git commit --amend [--no-edit]; git push -f'
  command git add -p
  if not set -q argv[1]
    gc_edit
  else
    gc_amend "$argv"
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

function grm1 --wraps='git reset --mixed HEAD~1' --description 'git reset --mixed HEAD~1'
  if not set -q argv[1]
    grm 1
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

function grh1 --wraps='git reset --hard HEAD~1' --description 'git reset --hard HEAD~1'
  if not set -q argv[1]
    grh 1
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

function guhs --wraps 'git pull && git submodule update --init --recursive' --description 'git pull'
  command git pull $argv
  command git submodule update --init --recursive
  command git reset --hard @{u}
end

function gn --wraps='git-number -c' --description 'git-number -c'
  if set -q argv[1]
    git-number -c $argv
  else
    echo "usage: gn …" 1>&2
    return 1
  end
end

function gv --wraps='git-number -c vim' --description 'git-number -c vim'
  if set -q argv[1]
    git-number -c vim $argv
  else
    echo "usage: gv …" 1>&2
    return 1
  end
end

function gnr --wraps='git-number -c rm -r' --description 'git-number -c rm -r'
  if set -q argv[1]
    git-number -c rm -r $argv
  else
    echo "usage: gnr …" 1>&2
    return 1
  end
end

function git-choose-branch
  set -l IFS
  set -l header \e'[38;5;240;3mctrl-x to delete'
  if set -q argv[1]
    set CURRENT (command git branch --show-current)
    set header $header\n\e'[0;3mcurrent: '$CURRENT
    set BRANCHES (command git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | command grep -vxF $CURRENT)
    set RELOAD_TAIL "| command grep -vxF $CURRENT"
  else
    set BRANCHES (command git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)')
  end

  if test (count $BRANCHES) -eq 0
    echo "no branches to choose from" 1>&2
    return 1
  end

  if test $status -eq 0
    echo $BRANCHES | fzf --no-sort --preview='git log --color=always {} -- | delta' --info=hidden --bind "ctrl-x:execute-silent(git branch -D {})+reload:command git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' $RELOAD_TAIL" --header $header
  end
end

function git-choose-branches
  set -l IFS
  set -l header \e'[38;5;240;3mctrl-x to delete'
  if set -q argv[1]
    set CURRENT (command git branch --show-current)
    set header $header\n\e'[0;3mcurrent: '$CURRENT
    set BRANCHES (command git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | command grep -vxF $CURRENT)
    set RELOAD_TAIL "| command grep -vxF $CURRENT"
  else
    set BRANCHES (command git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)')
  end

  if test (count $BRANCHES) -eq 0
    echo "no branches to choose from" 1>&2
    return 1
  end

  if test $status -eq 0
    echo $BRANCHES | fzf --multi --no-sort --preview='git log --color=always {} -- | delta' --info=hidden --bind "ctrl-x:execute-silent(git branch -D {})+reload:command git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' $RELOAD_TAIL" --header $header
  end
end

function gb --wraps='git switch' --description 'git switch'
  if not set -q argv[1]
    set BRANCH (git-choose-branch 1)
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

function gb- --wraps='git switch -' --description 'git switch -'
  if not set -q argv[1]
    command git switch -
  else
    set_color -o yellow
    echo "this command takes no args" 1>&2
    return 1
  end
end

function gbd --wraps='git branch -D' --description 'git branch -D'
  if not set -q argv[1]
    git-choose-branches 1 | xargs command git branch -D
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

function gvc --description 'edit files changed in last commit'
  set -l FILES (command git diff HEAD~1..HEAD --name-only; command git ls-files --others --exclude-standard)
  if [ "$FILES" = "" ]
    set_color -o yellow
    echo "no unchanged files" 1>&2
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

function gz --description 'jump to the top of the git repo'
  set top (git rev-parse --show-toplevel)
  if test $status -eq 0; and test "$top" != ""
    z $top $argv
  end
end

function gd --wraps 'git diff' --description 'git diff'
  if not set -q argv[1]
    command git diff
  else if test "$argv[1]" = "--cached"
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gdc" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  else if test "$argv[1]" = "@{u}"; or test "$argv[1]" = "@{u}..HEAD"
    echo -n "use " 1>&2
    set_color -o yellow
    echo -n "gdu" 1>&2
    set_color -o normal
    echo " instead" 1>&2
    return 1
  else
    command git diff $argv
  end
end

function gdc --wraps 'git diff --cached' --description 'git diff --cached'
  command git diff --cached $argv
end

function gdu --wraps 'git diff @{u}' --description 'git diff @{u}'
  command git diff @{u} $argv
end
