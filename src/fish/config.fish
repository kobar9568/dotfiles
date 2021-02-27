alias ls="ls --color=auto"

# Alias
alias ls="exa"
alias ll="exa -laaghHm --git --time-style long-iso"
alias la="exa -aa"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ..="cd .."
alias date="date --iso-8601=seconds"
alias less="less -MR"
alias stu="git status"
alias hd="hexyl"

if type "batcat" > /dev/null 2>&1
    alias bat="batcat"
end

# Key bindings
fish_vi_key_bindings

# グリーティングを非表示
set fish_greeting

# Starshipを有効化
starship init fish | source
