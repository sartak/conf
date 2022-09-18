function ssh --wraps='ssh'
  if not status is-interactive
    command ssh $argv
    return
  end

  echo -n "use " 1>&2
  set_color -o yellow
  echo -n $argv[1] 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function mana-tailscale --wraps='ssh mana-tailscale' --description='ssh mana-tailscale'
  command ssh mana-tailscale $argv
end

function mana-local --wraps='ssh mana-local' --description='ssh mana-local'
  command ssh mana-local $argv
end

function mana --wraps='ssh mana' --description='ssh mana'
  command ssh mana-tailscale $argv
end

function hongkong-tailscale --wraps='ssh hongkong-tailscale' --description='ssh hongkong-tailscale'
  command ssh hongkong-tailscale $argv
end

function hongkong-local --wraps='ssh hongkong-local' --description='ssh hongkong-local'
  command ssh hongkong-local $argv
end

function hongkong --wraps='ssh hongkong' --description='ssh hongkong'
  command ssh hongkong-tailscale $argv
end

function miami-tailscale --wraps='ssh miami-tailscale' --description='ssh miami-tailscale'
  command ssh miami-tailscale $argv
end

function miami-local --wraps='ssh miami-local' --description='ssh miami-local'
  command ssh miami-local $argv
end

function miami --wraps='ssh miami' --description='ssh miami'
  command ssh miami-tailscale $argv
end

function phuket-tailscale --wraps='ssh phuket-tailscale' --description='ssh phuket-tailscale'
  command ssh phuket-tailscale $argv
end

function phuket-local --wraps='ssh phuket-local' --description='ssh phuket-local'
  command ssh phuket-local $argv
end

function phuket --wraps='ssh phuket' --description='ssh phuket'
  command ssh phuket-tailscale $argv
end

function shiver-tailscale --wraps='ssh shiver-tailscale' --description='ssh shiver-tailscale'
  command ssh shiver-tailscale $argv
end

function shiver-local --wraps='ssh shiver-local' --description='ssh shiver-local'
  command ssh shiver-local $argv
end

function shiver --wraps='ssh shiver' --description='ssh shiver'
  command ssh shiver-tailscale $argv
end

function maui-tailscale --wraps='ssh maui-tailscale' --description='ssh maui-tailscale'
  command ssh maui-tailscale $argv
end

function maui-local --wraps='ssh maui-local' --description='ssh maui-local'
  command ssh maui-local $argv
end

function maui --wraps='ssh maui' --description='ssh maui'
  command ssh maui-tailscale $argv
end

function hydra-tailscale --wraps='ssh hydra-tailscale' --description='ssh hydra-tailscale'
  command ssh hydra-tailscale $argv
end

function hydra-local --wraps='ssh hydra-local' --description='ssh hydra-local'
  command ssh hydra-local $argv
end

function hydra --wraps='ssh hydra' --description='ssh hydra'
  command ssh hydra-tailscale $argv
end

function newyork --wraps='ssh newyork' --description='ssh newyork'
  command ssh newyork $argv
end

function waikiki-tailscale --wraps='ssh waikiki-tailscale' --description='ssh waikiki-tailscale'
  command ssh waikiki-tailscale $argv
end

function waikiki-local --wraps='ssh waikiki-local' --description='ssh waikiki-local'
  command ssh waikiki-local $argv
end

function waikiki --wraps='ssh waikiki' --description='ssh waikiki'
  command ssh waikiki-tailscale $argv
end

function meteor --wraps='ssh meteor' --description='ssh meteor'
  command ssh meteor $argv
end

function nova --wraps='ssh nova' --description='ssh nova'
  command ssh nova $argv
end
