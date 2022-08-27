function ssh --wraps='ssh'
  echo -n "use " 1>&2
  set_color -o yellow
  echo -n $argv[1] 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function mana-tailscale --wraps='ssh mana-tailscale' --description='ssh mana-tailscale'
  set -l SSH (which ssh)
  $SSH mana-tailscale
end

function mana-local --wraps='ssh mana-local' --description='ssh mana-local'
  set -l SSH (which ssh)
  $SSH mana-local
end

function mana --wraps='ssh mana' --description='ssh mana'
  set -l SSH (which ssh)
  $SSH mana
end

function hongkong-tailscale --wraps='ssh hongkong-tailscale' --description='ssh hongkong-tailscale'
  set -l SSH (which ssh)
  $SSH hongkong-tailscale
end

function hongkong-local --wraps='ssh hongkong-local' --description='ssh hongkong-local'
  set -l SSH (which ssh)
  $SSH hongkong-local
end

function hongkong --wraps='ssh hongkong' --description='ssh hongkong'
  set -l SSH (which ssh)
  $SSH hongkong
end

function miami-tailscale --wraps='ssh miami-tailscale' --description='ssh miami-tailscale'
  set -l SSH (which ssh)
  $SSH miami-tailscale
end

function miami-local --wraps='ssh miami-local' --description='ssh miami-local'
  set -l SSH (which ssh)
  $SSH miami-local
end

function miami --wraps='ssh miami' --description='ssh miami'
  set -l SSH (which ssh)
  $SSH miami
end

function phuket-tailscale --wraps='ssh phuket-tailscale' --description='ssh phuket-tailscale'
  set -l SSH (which ssh)
  $SSH phuket-tailscale
end

function phuket-local --wraps='ssh phuket-local' --description='ssh phuket-local'
  set -l SSH (which ssh)
  $SSH phuket-local
end

function phuket --wraps='ssh phuket' --description='ssh phuket'
  set -l SSH (which ssh)
  $SSH phuket
end

function shiver-tailscale --wraps='ssh shiver-tailscale' --description='ssh shiver-tailscale'
  set -l SSH (which ssh)
  $SSH shiver-tailscale
end

function shiver-local --wraps='ssh shiver-local' --description='ssh shiver-local'
  set -l SSH (which ssh)
  $SSH shiver-local
end

function shiver --wraps='ssh shiver' --description='ssh shiver'
  set -l SSH (which ssh)
  $SSH shiver
end

function maui-tailscale --wraps='ssh maui-tailscale' --description='ssh maui-tailscale'
  set -l SSH (which ssh)
  $SSH maui-tailscale
end

function maui-local --wraps='ssh maui-local' --description='ssh maui-local'
  set -l SSH (which ssh)
  $SSH maui-local
end

function maui --wraps='ssh maui' --description='ssh maui'
  set -l SSH (which ssh)
  $SSH maui
end

function hydra-tailscale --wraps='ssh hydra-tailscale' --description='ssh hydra-tailscale'
  set -l SSH (which ssh)
  $SSH hydra-tailscale
end

function hydra-local --wraps='ssh hydra-local' --description='ssh hydra-local'
  set -l SSH (which ssh)
  $SSH hydra-local
end

function hydra --wraps='ssh hydra' --description='ssh hydra'
  set -l SSH (which ssh)
  $SSH hydra
end

function newyork --wraps='ssh newyork' --description='ssh newyork'
  set -l SSH (which ssh)
  $SSH newyork
end

function waikiki-tailscale --wraps='ssh waikiki-tailscale' --description='ssh waikiki-tailscale'
  set -l SSH (which ssh)
  $SSH waikiki-tailscale
end

function waikiki-local --wraps='ssh waikiki-local' --description='ssh waikiki-local'
  set -l SSH (which ssh)
  $SSH waikiki-local
end

function waikiki --wraps='ssh waikiki' --description='ssh waikiki'
  set -l SSH (which ssh)
  $SSH waikiki
end

function meteor --wraps='ssh meteor' --description='ssh meteor'
  set -l SSH (which ssh)
  $SSH meteor
end

function nova --wraps='ssh nova' --description='ssh nova'
  set -l SSH (which ssh)
  $SSH nova
end

