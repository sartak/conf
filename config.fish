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
  fish_add_path --path /usr/local/bin
end

fish_add_path --path /opt/homebrew/bin
fish_add_path --path ~/.cargo/bin
fish_add_path --path ~/.local/bin
fish_add_path --path ~/.bun/bin

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

set -x EDITOR /usr/local/bin/nvim
set -x VISUAL /usr/local/bin/nvim

set -x CARGO_NET_GIT_FETCH_WITH_CLI true
set -x RUSTFLAGS '-C target-cpu=native'

set -x BUN_INSTALL ~/.bun
set -x nvm_default_version lts

set -x HOMEBREW_NO_ENV_HINTS 1

set -x LS_COLORS 'no=00;38;5;250:rs=0:di=01;38;5;39:ln=01;38;5;37:mh=00:pi=48;5;230;38;5;136;01:so=48;5;230;38;5;136;01:do=48;5;230;38;5;136;01:bd=48;5;230;38;5;244;01:cd=48;5;230;38;5;244;01:or=48;5;235;38;5;160:su=48;5;160;38;5;230:sg=48;5;136;38;5;230:ca=30;41:tw=48;5;64;38;5;230:ow=48;5;235;38;5;33:st=48;5;33;38;5;230:ex=01;38;5;82:'

# this has to go late as well
bind \cv edit_command
