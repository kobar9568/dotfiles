function ghq
  set ghq (which ghq)
  if test "$argv[1]" = "create"
    set ghq_username "kobar9568"
    set os_username $USER
    set -x USER $ghq_username
    $ghq create $argv[2]
    set -x USER $os_username
  else
    $ghq $argv
  end
end
