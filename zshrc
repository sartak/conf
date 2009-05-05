# my silly prompt {{{
precmd () {
    PROMPT=`shell-prompt`
}

RPS1='[%*]'
# }}}
# completion {{{
. ~/.zshcomplete
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
autoload copy-earlier-word
zle -N copy-earlier-word

autoload edit-command-line
zle -N edit-command-line
# }}}
# miscellaneous options {{{
setopt nobeep # I hates the beeps
setopt auto_cd # typing just a directory name cds into it
setopt multios # built-in tee
setopt extended_glob
setopt nullglob # it's not an error for a glob to expand to nothing
setopt list_ambiguous
setopt no_nomatch
setopt interactivecomments # Allow comments even in the interactive shell
setopt listpacked # column width doesn't have to be constant
setopt complete_in_word # hitting tab on the f in Mafile does the right thing
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
# }}}
# replace default utilities {{{
alias man="man -P vimmanpager"
#alias top="htop"
# }}}
# add color to some things {{{
alias ls='ls -G'
alias grep='grep --color=auto'
alias ack='ack --color'
export ACK_COLOR_FILENAME=clear
export ACK_COLOR_MATCH=red
# }}}
# telnet services (nao, termcast, etc) {{{
alias nao="(TERM='rxvt'; telnet nethack.alt.org)"
alias cao="telnet crawl.akrasiac.org"
alias termcast="telnet termcast.org"
alias sporkhack='telnet nethack.nineball.org'
# }}}
# shell accounts {{{
alias katron="ssh katron.org"
alias arcane="ssh 66.41.105.165"
alias jsn="ssh noway.ratry.ru"
alias akrasiac="ssh henzell@crawl.akrasiac.org"
alias diesel="ssh diesel.bestpractical.com"
alias rax="ssh sartak.org"
alias home='ssh $HOMEIP'
alias alt='ssh alt.org'
alias hm='ssh hiveminder.com'
# }}}
# shortcuts {{{
alias i='sudo port install'
alias ci='sudo cpan -i'
alias less='less -R'
alias p='prove -lr'
alias pp='prove -lr --state=hot,new,save -j10'
alias mmi='make && sudo make install'
alias ghc='ghc-6.10.1'
alias ghci='ghci-6.10.1'
alias linein='nohup /Applications/LineIn.app/Contents/MacOS/LineIn &'
alias moose="perl -Moose -e"
alias s='screen'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# }}}
# darcs shortcuts {{{
alias dwn="darcs whatsnew"
alias darcsify="darcs init && darcs add \$(darcs whatsnew -ls | awk '/^a\ / {print \$2}') && darcs record -a -m'Initial import'"
alias dpl="darcs pull"
alias dps="darcs push"
alias dpa="darcs push --all"
alias dp="darcs pull && darcs push"
alias dr="rlwrap --no-warnings darcs record"
alias dar="rlwrap --no-warnings darcs amend-record"
alias db="darcs revert"
alias dqm="darcs query manifest"
alias dun="darcs unpull"
alias dur="darcs unrecord"
alias dB="darcs unrecord"
alias drb="darcs rollback"
# }}}
# git shortcuts {{{
alias gr="git record"
# }}}
# work shortcuts {{{
alias rt='PERL5LIB=/opt/rt3/lib:/opt/rt3/lib:$PERL5LIB RT_DBA_USER=postgres RT_DBA_PASSWORD='' '
alias rtp='rt prove -rl -I/opt/rt3/lib'
alias rtversion="rt perl -MRT -le 'print \$RT::VERSION'"
alias unrt="ps aux -ww | egrep 'standalone|rt-server' | grep -v grep | perl -lane 'print \$_; system(qq{sudo kill \$F[1]})'"
alias rert="unrt && (cd ~; sudo /opt/rt3/bin/standalone_httpd)"
# }}}
# global shortcuts (don't need to be in the command position) {{{
alias -g L='|& vimpager'
alias -g G='|& ack'
alias -g H='|& head'
alias -g T='|& tail'
alias -g W='|& wc'
alias -g P='|& nopaste -x'
# }}}
# zen {{{
fpath=(
        $fpath
        /Users/sartak/.zen/zsh/scripts
        /Users/sartak/.zen/zsh/zle )
autoload -U zen
# }}}
# fortune {{{
if which fortune.pl >/dev/null; then
    fortune.pl
elif which fortune >/dev/null; then
    fortune
fi
# }}}

