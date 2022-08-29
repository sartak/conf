set -x PERLBREW_ROOT ~/.perl
if test -e ~/.perl/etc/perlbrew.fish
    . ~/.perl/etc/perlbrew.fish
end

if test -e ~/.config/fish/local.fish
    . ~/.config/fish/local.fish
end

set fish_greeting ""

set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'

function fish_prompt
    set -l last_status $status

    if test -z "$VIM_TERMINAL"
      set -l host (hostname | sed 's/\..*//')
      switch $host
        case giedi-prime mana hydra
          set_color B300FF
        case newyork maui waikiki miami meteor nova
          set_color FFB400
        case hongkong phuket shiver
          set_color FFB400
          echo -n (whoami)'@'
        case vagrant
          set_color 2E00E6
        case '*'
          set_color F6511D
      end

      if [ "$HOST_OVERRIDE" != "" ]
          set host $HOST_OVERRIDE
      end

      echo -n $host' '

      set_color $fish_color_cwd
      echo -n (prompt_pwd)

      set_color -o yellow
      echo -n (__fish_git_prompt)
      echo -n ' '
    end

    set_color normal

    if not [ $last_status -eq 0 ]
        set_color $fish_color_error
    end
    echo -n '$ '
end

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
    functions -c cd cd_tmp
    functions -e cd
    cd $argv
    functions -c cd_tmp cd
    functions -e cd_tmp
    return
  end

  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "z" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

fzf_configure_bindings --directory=\ct --git_log= --git_status= --history=\cr --variables= --processes=
set -x BAT_STYLE plain
set -x fzf_preview_file_cmd bat --color=always
set -x fzf_preview_dir_cmd exa --git-ignore -l --color=always --no-time --no-user --no-permissions --git

function f --wraps=fzf --description 'fzf'
  fzf $argv
end

set -x FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=down:75%,nowrap,border-top --marker="*" --color=bg+:#000000,border:#222222,fg+:#F8F8F2,preview-bg:#000000,info:italic:#5f5f5f,bg:#000000,spinner:#A6E22E,gutter:#000000,prompt:#A6E22E,preview-fg:#F8F8F2,fg:#F8F8F2,disabled:#5fd7ff,header:#F8F8F2,marker:#F92672,hl+:#ffd700,query:#5fd7ff,hl:#ffd700,pointer:#5fd7ff'

set -x RIPGREP_CONFIG_PATH ~/.config/ripgreprc

bind \cg fzf_grep
bind \cz fzf_z

# this has to go late as well
bind \cv edit_command
