set tide_left_prompt_items myhost mygit mykubectl mypwd newline character
set tide_right_prompt_items mycontext myduration mybattery mystatus

set tide_prompt_add_newline_before true
set tide_prompt_color_separator_same_color 949494
set tide_prompt_icon_connection ' '
set tide_prompt_min_cols 34
set tide_prompt_pad_items false

set tide_left_prompt_separator_diff_color 
set tide_left_prompt_separator_same_color 
set tide_left_prompt_suffix 

set tide_right_prompt_prefix 
set tide_right_prompt_separator_diff_color 
set tide_right_prompt_separator_same_color 

set tide_character_color FFFFFF
set tide_character_color_failure FFFFFF
set tide_character_icon λ

set tide_myhost_bg_color 470066
set tide_myhost_bg_color_secondary 4D3600
set tide_myhost_bg_color_unknown 4D1200
set tide_myhost_color B300FF
set tide_myhost_color_secondary FFB400
set tide_myhost_color_unknown FF3C00

set tide_pwd_bg_color 000000
set tide_pwd_color_anchors A1C281
set tide_pwd_color_dirs A1C281
set tide_pwd_color_truncated_dirs A1C281
set tide_pwd_markers .git .node-version Cargo.toml go.mod package.json
set tide_pwd_icon_unwritable (set_color A43434)(set_color A1C281)

set tide_mygit_bg_color 3465A4
set tide_mygit_bg_color_unstable 3465A4
set tide_mygit_bg_color_urgent A43434
set tide_mygit_color_branch FFFFFF
set tide_mygit_color_conflicted FFFFFF
set tide_mygit_color_dirty FFFFFF
set tide_mygit_color_operation FFFFFF
set tide_mygit_color_staged FFFFFF
set tide_mygit_color_untracked FFFFFF
set tide_mygit_color_upstream FFFFFF
set_color $tide_mygit_color_branch | read -gx _tide_location_color
set tide_mygit_truncation_length 24

set tide_mykubectl_bg_color 660000
set tide_mykubectl_color FFFFFF

set tide_mycontext_bg_color 222222
set tide_mycontext_color FFFFFF
set tide_mycontext_jobs_icon %
set tide_mycontext_shlvl_threshold 1

set tide_myduration_bg_color 3465A4
set tide_myduration_color FFFFFF
set tide_myduration_decimals 1
set tide_myduration_threshold 1000

set tide_mybattery_bg_color 006605
set tide_mybattery_bg_color_warn C4A000
set tide_mybattery_bg_color_danger 440000
set tide_mybattery_color_warn 000000
set tide_mybattery_color_danger FF0000
set tide_mybattery_threshold 40
set tide_mybattery_threshold_danger 20

set tide_mystatus_bg_color 2E3436
set tide_mystatus_bg_color_failure 440000
set tide_mystatus_color 4E9A06
set tide_mystatus_color_failure FF0000
set tide_mystatus_icon ✔
set tide_mystatus_icon_failure ✘

function _tide_item_myhost
  if [ "$HOST_OVERRIDE" != "" ]
    set host $HOST_OVERRIDE
  else
    set host (hostname | sed 's/\..*//')
    switch $host
      case hydra
        # no effect
      case mana newyork maui waikiki miami meteor lightning
        set -g tide_myhost_bg_color $tide_myhost_bg_color_secondary
        set -g tide_myhost_color $tide_myhost_color_secondary
      case hongkong phuket shiver
        set -g tide_myhost_bg_color $tide_myhost_bg_color_secondary
        set -g tide_myhost_color $tide_myhost_color_secondary
        set host (whoami)'@'$host
      case '*'
        set -g tide_myhost_bg_color $tide_myhost_bg_color_unknown
        set -g tide_myhost_color $tide_myhost_color_unknown
    end
  end

  _tide_print_item myhost " $host "
end

function _tide_item_mygit
    if git branch --show-current 2>/dev/null | string replace -r ".+(.{$tide_mygit_truncation_length})" '…$1' | read -l location
        git rev-parse --git-dir --is-inside-git-dir | read -fL gdir in_gdir
        set location $_tide_location_color$location
    else if test $pipestatus[1] != 0
        _tide_print_item mygit
        return
    else if git tag --points-at HEAD | string replace -r ".+(.{$tide_mygit_truncation_length})" '…$1' | read location
        git rev-parse --git-dir --is-inside-git-dir | read -fL gdir in_gdir
        set location '#'$_tide_location_color$location
    else
        git rev-parse --git-dir --is-inside-git-dir --short HEAD | read -fL gdir in_gdir location
        set location @$_tide_location_color$location
    end

    # Operation
    if test -d $gdir/rebase-merge
        read -f step <$gdir/rebase-merge/msgnum
        read -f total_steps <$gdir/rebase-merge/end
        test -f $gdir/rebase-merge/interactive && set -f operation rebase-i || set -f operation rebase-m
    else if test -d $gdir/rebase-apply
        read -f step <$gdir/rebase-apply/next
        read -f total_steps <$gdir/rebase-apply/last
        if test -f $gdir/rebase-apply/rebasing
            set -f operation rebase
        else if test -f $gdir/rebase-apply/applying
            set -f operation am
        else
            set -f operation am/rebase
        end
    else if test -f $gdir/MERGE_HEAD
        set -f operation merge
    else if test -f $gdir/CHERRY_PICK_HEAD
        set -f operation cherry-pick
    else if test -f $gdir/REVERT_HEAD
        set -f operation revert
    else if test -f $gdir/BISECT_LOG
        set -f operation bisect
    end

    # Git status + Upstream behind/ahead
    test $in_gdir = true && set -l _set_dir_opt -C $gdir/..
    # Suppress errors in case we are in a bare repo or there is no upstream
    stat=(git $_set_dir_opt --no-optional-locks status --porcelain 2>/dev/null) \
        string match -qr '.*\n(0|(?<conflicted>.*))\n(0|(?<staged>.*))
(0|(?<dirty>.*))\n(0|(?<untracked>.*))(\n(0|(?<behind>.*))\t(0|(?<ahead>.*)))?' \
        "$(count
        string match -r ^UU $stat | count
        string match -r ^[ADMR]. $stat | count
        string match -r ^.[ADMR] $stat | count
        string match -r '^\?\?' $stat | count
        git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)"

    if test -n "$operation$conflicted"
        set -g tide_mygit_bg_color $tide_mygit_bg_color_urgent
    else if test -n "$staged$dirty$untracked"
        set -g tide_mygit_bg_color $tide_mygit_bg_color_unstable
    end

    if test -z "$behind"; and test -z "$ahead"
      set upstream ""
    else if test -z "$behind"
      set upstream ' ↑'$ahead
    else if test -z "$ahead"
      set upstream ' ↓'$behind
    else
      set upstream " ↑$ahead↓$behind"
    end

    _tide_print_item mygit (set_color white; echo -ns ' '$location
        set_color $tide_mygit_color_operation; echo -ns ' '$operation ' '$step/$total_steps
        echo -ns \e'[1m'
        set_color $tide_mygit_color_upstream; echo -ns "$upstream"
        set_color $tide_mygit_color_conflicted; echo -ns ' !'$conflicted
        set_color $tide_mygit_color_staged; echo -ns ' →'$staged
        set_color $tide_mygit_color_dirty; echo -ns ' *'$dirty
        set_color $tide_mygit_color_untracked; echo -ns ' …'$untracked;
        echo ' ')
end

function _tide_item_mykubectl
  if type -q kubectl
    kubectl config view --minify --output 'jsonpath={.current-context}/{..namespace}' 2>/dev/null | read -l context
    if test -z "$context"
      _tide_print_item mykubectl
    else
      set context (string replace -r '/(|default)$' '' $context)
      if test -z "$context"; or test "$context" = "$tide_default_kubectl_context"
        _tide_print_item mykubectl
      else
        _tide_print_item mykubectl ' '$context' '
      end
    end
  end
end

function _tide_item_mystatus
  if string match -qv 0 $_tide_pipestatus # If there is a failure anywhere in the pipestatus
    if test "$_tide_pipestatus" = 1 # If simple failure
      tide_mystatus_bg_color=$tide_mystatus_bg_color_failure \
        tide_mystatus_color=$tide_mystatus_color_failure \
        _tide_print_item mystatus ' '$tide_mystatus_icon_failure' ' 1' '
    else
      fish_status_to_signal $_tide_pipestatus | string replace SIG '' | string join '|' | read -l out
      test $_tide_status = 0 && _tide_print_item mystatus $tide_mystatus_icon' ' $out ||
        tide_mystatus_bg_color=$tide_mystatus_bg_color_failure \
        tide_mystatus_color=$tide_mystatus_color_failure \
        _tide_print_item mystatus ' '$tide_mystatus_icon_failure' ' $out' '
    end
  else
    _tide_print_item mystatus " $tide_mystatus_icon "
  end
end

function _tide_item_myduration
  if test $CMD_DURATION -gt $tide_myduration_threshold
    set t (
      math -s0 "$CMD_DURATION/3600000" # Hours
      math -s0 "$CMD_DURATION/60000"%60 # Minutes
      math -s$tide_myduration_decimals "$CMD_DURATION/1000"%60
    )

    if test $t[1] != 0
      _tide_print_item myduration " $t[1]h $t[2]m $t[3]s "
    else if test $t[2] != 0
      _tide_print_item myduration " $t[2]m $t[3]s "
    else
      _tide_print_item myduration " $t[3]s "
    end
  else
    _tide_print_item myduration
  end
end

function _tide_item_mycontext
  set -l items

  if set -q _tide_jobs
    set -a items $tide_mycontext_jobs_icon
  end

  if test $SHLVL -gt $tide_mycontext_shlvl_threshold
    set -a items $SHLVL
  end

  if test (count $items) -gt 0
    _tide_print_item mycontext " $items "
  else
    _tide_print_item mycontext
  end
end

function _tide_item_mybattery
  if type -q pmset; and test -z "$NO_BATTERY"
    pmset -g batt 2>/dev/null | read -zl battery
    if test -z "$battery"; or not string match -q "*discharging*" $battery
      _tide_print_item mybattery
    else
      set percent (string match -r '\d+(?=%)' "$battery")
      if test $percent -lt $tide_mybattery_threshold_danger
        set -g tide_mybattery_bg_color $tide_mybattery_bg_color_danger
        set -g tide_mybattery_color $tide_mybattery_color_danger
        _tide_print_item mybattery " $percent% "
      else if test $percent -lt $tide_mybattery_threshold
        set -g tide_mybattery_bg_color $tide_mybattery_bg_color_warn
        set -g tide_mybattery_color $tide_mybattery_color_warn
        _tide_print_item mybattery " $percent% "
      else
        _tide_print_item mybattery
      end
    end
  end
end

function _tide_item_mypwd
  _tide_print_item pwd " @PWD@ "
end
