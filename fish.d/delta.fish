function diff --wraps=diff
  if not status is-interactive
    command diff $argv
    return
  end

  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "dt" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function delta --wraps=delta
  if not status is-interactive
    command delta $argv
    return
  end

  echo -n "use " 1>&2
  set_color -o yellow
  echo -n "dt" 1>&2
  set_color -o normal
  echo " instead" 1>&2
  return 1
end

function dt --wraps=delta
  command delta $argv
end
