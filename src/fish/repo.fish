function repo
  if type "ghq"
    set ghq "$HOME/.ghq"
    set src ( \
      ghq list | \
      fzf --preview "bat --color=always --style=header,grid --line-range :80 (ghq root)/{}/README.*" \
    )
    echo $src

    if [ -n "$src" ]; cd $ghq/$src; end
  end
end
