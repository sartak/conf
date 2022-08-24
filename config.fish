set -x PERLBREW_ROOT ~/.perl
if test -e ~/.perl/etc/perlbrew.fish
    . ~/.perl/etc/perlbrew.fish
end

if test -e ~/.config/fish/local.fish
    . ~/.config/fish/local.fish
end

set fish_greeting ""

set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'

function fish_prompt
    set -l last_status $status

    set -l host (hostname | sed 's/\..*//')
    switch $host
      case giedi-prime mana hydra
        set_color B300FF
      case newyork maui hongkong junction phuket waikiki miami shiver meteor nova
        set_color FFB400
      case vagrant
        set_color 2E00E6
      case '*'
        set_color F6511D
    end

    if [ "$HOST_OVERRIDE" != "" ]
        set host $HOST_OVERRIDE
    end

    echo -n (whoami)'@'$host' '

    set_color $fish_color_cwd
    echo -n (prompt_pwd)

    set_color -o yellow
    echo -n (__fish_git_prompt)

    set_color normal

    if not [ $last_status -eq 0 ]
        set_color $fish_color_error
    end
    echo -n ' $ '
end

function fish_title
    echo -n '　'
end

if not status --is-interactive
  set PATH /usr/local/bin $PATH
end
