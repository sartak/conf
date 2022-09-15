function sudo --wraps=sudo -d "sudo wrapper that handles aliases"
    if functions -q -- "$argv[1]"
        set cmdline (
            for arg in $argv
                printf "\"%s\" " $arg
            end
        )
        set -x function_src (string join "\n" (string escape --style=var (functions "$argv[1]")))
        set argv fish -c 'string unescape --style=var (string split "\n" $function_src) | source; '$cmdline
        command sudo -E $argv
    else
        command sudo $argv
    end
end
