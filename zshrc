# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

COMPLETION_WAITING_DOTS="true"
ZSH_THEME=sartak

source $ZSH/oh-my-zsh.sh
source ~/.zshenv

# my silly prompt {{{
#function shell_prompt_precmd() {
#    PROMPT=`shell-prompt`
#}
#precmd_functions+=(shell_prompt_precmd)
#
#RPS1='[%*]'
# }}}
# history {{{
HISTFILE=$HOME/.history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt share_history
setopt hist_ignore_space
# }}}
# plugins {{{
plugins=(git vi-mode cpanm)

autoload copy-earlier-word
zle -N copy-earlier-word

autoload edit-command-line
zle -N edit-command-line
# }}}
# key bindings {{{
bindkey -v                           # Use vim bindings
bindkey "^A" beginning-of-line       # Easier than ^[I
bindkey "^E" end-of-line             # Easier than ^[A
bindkey "^N" accept-and-infer-next-history # Enter; pop next history event
bindkey "^P" push-line               # Pushes line to buffer stack
bindkey "^R" history-incremental-search-backward # Like in bash, but should !
bindkey "^Y" copy-earlier-word       # Pretty self-explanatory name!
bindkey "^T" transpose-chars         # Transposes adjacent chars (xp in vim)
bindkey " " magic-space              # Expands from hist (!vim )
bindkey "\e[3~" delete-char          # Enable delete

bindkey -M vicmd v edit-command-line # v in vi mode opens line in $EDITOR
bindkey -M viins '' backward-delete-char
bindkey -M viins '' backward-delete-char

# }}}
# aliases {{{
alias rax="ssh sartak.org"
alias irc='flushdns; ssh -qt sartak.org "screen -dr irssi"'

alias ci='cpanm'
alias less='less -R'
alias p='prove -wlr --timer'
alias moose="perl -Moose -E"
alias dzilinstall='dzil install --install-command="cpanm --verbose ."'
function perldoc(){cpandoc "$@"}
alias vi="vim"
alias flushdns="dscacheutil -flushcache"

function git(){hub "$@"}
alias gr="git record"
alias gs="git awesome-status"
alias gca="git add -p && git commit --amend --verbose"

alias cs="perl script/*_server.pl -d -r"
# }}}


unsetopt correct_all

