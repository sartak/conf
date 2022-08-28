function fzf_z
  if not type -q z
    set_color red
      echo "_fzf_jump_directory: z not found." >&2
    set_color normal
    return 1
  end

  set command_z (
    zoxide query -l 2>/dev/null | _fzf_wrapper $fzf_jump_directory_opts
  )

  if test $status -eq 0
    fish_prompt

    set_color 1753CB
    echo -n "z "
    set_color -u 23A5FA
    echo $command_z

    z $command_z
  end

  commandline --function repaint
end
