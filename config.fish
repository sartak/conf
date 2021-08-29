set -x PERLBREW_ROOT ~/.perl
if test -e ~/.perl/etc/perlbrew.fish
    . ~/.perl/etc/perlbrew.fish
end

if test -e ~/.bin
    set -x fish_user_paths ~/.bin
end

if test -e ~/.config/fish/local.fish
    . ~/.config/fish/local.fish
end

set fish_greeting ""

function jnethack
    cocot -t UTF-8 -p EUC-JP -- jnethack $argv;
end

set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'

function fish_prompt
    set -l last_status $status

    set -l host (hostname | sed 's/\.local//' | sed 's/^\(vagrant\).\+/\1/')
    switch $host
      case giedi-prime
        set_color B300FF
      case gammu buzzell junction tleilax newyork paris
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

