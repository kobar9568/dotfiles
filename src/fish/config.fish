alias ls="ls --color=auto"

# Alias
alias ll="ls -alhF"
alias la="ls -A"
alias l="ls -CF"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ..="cd .."
alias date="date --iso-8601=seconds"
alias less="less -MR"

# グリーティングを非表示
set fish_greeting

# Starshipを有効化
starship init fish | source
