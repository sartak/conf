set -x PERLBREW_ROOT ~/.perl
if test -e ~/.perl/etc/perlbrew.fish
    . ~/.perl/etc/perlbrew.fish
end

if test -e ~/.bin
    set -x fish_user_paths ~/.bin $fish_user_paths
end

set fish_greeting ""

function jnethack
    cocot -t UTF-8 -p EUC-JP -- jnethack $argv;
end
