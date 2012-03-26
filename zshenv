export PERLBREW_ROOT=~/.perl

export NOPASTE_SSH_SERVER=sartak.org
export NOPASTE_SSH_DOCROOT=www/tmp/paste
export NOPASTE_SSH_WEBPATH=http://sartak.org/tmp/paste
export NOPASTE_SSH_MODE=0644
export NOPASTE_SERVICES=ssh
export NOPASTE_SSH_USE_DESCRIPTION=0

export NYTPROF=addpid=1

export PERL_PREFER_CPAN_CLIENT=cpanm
export PERL_CPANM_OPT='--prompt'

export ANKI_DECK=~/Documents/Anki/Japanese.anki
export ANKI_CORPUS=~/.ankicorpus.sqlite
export MECAB_USERDIC=~/.mecab-user.dict

# site-specific environment variables
. ~/.zshenv.local
source $PERLBREW_ROOT/etc/bashrc
