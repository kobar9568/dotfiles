function do_ctrl_g
  echo "^G"

  set before_dir (pwd)

  cd (ghq root)"/"(ghq list | fzf --preview "batcat --color=always --style=header,grid --line-range :80 \$(ghq root)/{}/README.*")

  if not test $before_dir = (pwd)
    ll
  end

end
