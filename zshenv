export PERLBREW_ROOT=~/.perl

export RT_DBA_USER=sartak
export RT_DBA_PASSWORD=''
export RT_TEST_PARALLEL=1

export NOPASTE_SSH_SERVER=sartak.org
export NOPASTE_SSH_DOCROOT=www/tmp/paste
export NOPASTE_SSH_WEBPATH=http://sartak.org/tmp/paste
export NOPASTE_SSH_MODE=0644
export NOPASTE_SERVICES=ssh
export NOPASTE_SSH_USE_DESCRIPTION=0

export NYTPROF=addpid=1

export LC_ALL=en_US.UTF-8

export PERL_PREFER_CPAN_CLIENT=cpanm
export PERL_CPANM_OPT='--prompt'

export HEISIG_LEARNED=2042

export ANKI_DECK=~/Documents/Anki/Japanese.anki
export ANKI_CORPUS=~/.ankicorpus.sqlite

export NODE_PATH=~/.brew/lib/node_modules

# site-specific environment variables
. ~/.zshenv.local

. ~/.perl/etc/bashrc
