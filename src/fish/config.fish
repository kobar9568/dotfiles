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
alias gd="git diff"
alias gdv="git difftool"

alias hd="hexyl"
alias tkill="tmux kill-server"

if type "batcat" > /dev/null 2>&1
    alias bat="batcat"
end

# Activate vi mode.
fish_vi_key_bindings

# Remove the greeting.
set fish_greeting

# Activate starship.
starship init fish | source
