# my silly prompt {{{
function shell_prompt_precmd() {
    PROMPT=`shell-prompt`
}
precmd_functions+=(shell_prompt_precmd)

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
bindkey -M viins '' backward-delete-char
bindkey -M viins '' backward-delete-char

# }}}
# replace default utilities {{{
alias top="htop"
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
alias booth="ssh shell.bestpractical.com"
alias rax="ssh sartak.org"
alias home='ssh $HOMEIP'
alias alt='ssh alt.org'
alias hm='ssh hiveminder.com'
alias irc='autossh -M20000 sartak.org -t "screen -dr irssi"'
# }}}
# shortcuts {{{
alias i='sudo port install'
alias ci='cpanm'
alias c.='cpanm -v .'
alias less='less -R'
alias p='prove -lr'
alias pp='prove -lr --state=hot,new,save -j10'
alias mmi='cpan .'
alias pmmi='cpan .'
alias ptmmi='cpan .'
alias ghc='ghc-6.10.1'
alias ghci='ghci-6.10.1'
alias linein='nohup /Applications/LineIn.app/Contents/MacOS/LineIn &'
alias moose="perl -Moose -e"
alias vi="vim"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Edits the files whose contents match the regular expression
vack() {
    vim `ack -la -- "$@"`
}
# }}}
# git shortcuts {{{
alias gr="git record"
alias gc="git commit"
alias gca="git add -p && git commit --amend"
alias gcall="git commit --all"
alias gbg="git bisect good"
alias gbb="git bisect bad"
alias good="git bisect good"
alias bad="git bisect bad"
alias gbs="git bisect skip"
alias gbr="git bisect reset"
# }}}
# work shortcuts {{{
alias rt='PERL5LIB=/opt/rt3/lib:/opt/rt3/lib:$PERL5LIB RT_DBA_USER=postgres RT_DBA_PASSWORD='' '
alias rtp='rt prove -rl -I/opt/rt3/lib'
alias rtversion="rt perl -MRT -le 'print \$RT::VERSION'"
alias unrt="ps aux -ww | egrep 'standalone|rt-server' | grep -v grep | perl -lane 'print \$_; system(qq{sudo kill \$F[1]})'"
alias rert="unrt && (cd ~; /opt/rt3/bin/standalone_httpd 8888)"
alias mmirt="mmi; sudo chown -R sartak:sartak /opt/rt3*"
alias ec2="prove -lr -j4 --harness TAP::Harness::Remote::EC2 --state=save,slow"
alias rtxi="perl Makefile.PL && make install && rert"
# }}}
# global shortcuts (don't need to be in the command position) {{{
alias -g L='|& less'
alias -g G='|& ack'
alias -g H='|& head'
alias -g T='|& tail'
alias -g H1='|& head -n 1'
alias -g T1='|& tail -n 1'
alias -g W='|& wc'
alias -g P='|& nopaste -x'
alias -g ackla='ack -la --'
# }}}
# zen {{{
fpath=(
        $fpath
        /Users/sartak/.zen/zsh/scripts
        /Users/sartak/.zen/zsh/zle )
autoload -U zen
# }}}
