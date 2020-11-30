alias ls="ls --color=auto"

# Alias
alias ls="exa"
alias ll="exa -laghHm --git --time-style long-iso"
alias la="exa -a"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ..="cd .."
alias date="date --iso-8601=seconds"
alias less="less -MR"
alias stu="git status"

# Key bindings
fish_vi_key_bindings

# グリーティングを非表示
set fish_greeting

# Starshipを有効化
starship init fish | source
