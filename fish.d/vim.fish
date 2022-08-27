function vim --wraps=vim
  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "v" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function v --wraps=vim --description 'alias v=vim'
  set -l VIM (which vim)
  $VIM $argv
end

# we need this wrapper to avoid executing our vim retrain
function edit_command
  set -xl VISUAL vi
  edit_command_buffer
end
