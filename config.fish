set -x PERLBREW_ROOT ~/.perl
if test -e ~/.perl/etc/perlbrew.fish
    . ~/.perl/etc/perlbrew.fish
end

if test -e ~/.config/fish/local.fish
    . ~/.config/fish/local.fish
end

set fish_greeting ""

function fish_title
    echo -n '　'
end

if not status --is-interactive
  set PATH /usr/local/bin $PATH
end

zoxide init fish | source

# this retrain has to go here, after loading zoxide
function cd --wraps cd
  if not status is-interactive
    command cd $argv
    return
  end

  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "z" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

# fzf_configure_bindings --directory=\ct --git_log= --git_status= --history=\cr --variables= --processes=
set -x BAT_STYLE plain
set -x fzf_preview_file_cmd bat --color=always
set -x fzf_preview_dir_cmd eza --git-ignore -l --color=always --no-time --no-user --no-permissions --git

function f --wraps=fzf --description 'fzf'
  fzf $argv
end

set -x FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --ellipsis=… --tabstop=2 --bind backward-eof:abort --preview-window=down:75%,nowrap,border-top --marker="*" --color=bg+:#000000,border:#222222,fg+:#F8F8F2,preview-bg:#000000,info:italic:#5f5f5f,bg:#000000,spinner:#A6E22E,gutter:#000000,prompt:#A6E22E,preview-fg:#F8F8F2,fg:#F8F8F2,disabled:#5fd7ff,header:#F8F8F2,marker:#F92672,hl+:#ffd700,query:#5fd7ff,hl:#ffd700,pointer:#5fd7ff'

set -x RIPGREP_CONFIG_PATH ~/.config/ripgreprc

# bind \cg fzf_grep
# bind \cz fzf_z

set -g man_blink red
set -g man_bold green
set -g man_standout -o yellow
set -g man_underline -u blue

# this has to go late as well
bind \cv edit_command
