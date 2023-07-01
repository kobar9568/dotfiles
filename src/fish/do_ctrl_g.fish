function do_ctrl_g
  echo "^G"

  set before_dir (pwd)

  if type "batcat" > /dev/null 2>&1
    cd (ghq root)"/"(ghq list | fzf --preview "batcat --color=always --style=header,grid --line-range :80 \$(ghq root)/{}/README.*")
  else if type "bat" > /dev/null 2>&1
    cd (ghq root)"/"(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 \$(ghq root)/{}/README.*")
  end

  if not test $before_dir = (pwd)
    ll
  end

end
