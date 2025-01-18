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

alias :q="exit"
alias :q!="exit"

alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcl="docker compose logs -f"

# Activate vi mode.
fish_vi_key_bindings

# Remove the greeting.
set fish_greeting

# Allow nested tmux sessions.
set --erase TMUX

# Cursor configs.
set fish_cursor_default underscore blink
set fish_cursor_insert underscore blink
set fish_cursor_default underscore blink

# Default node version by nvm.
set --universal nvm_default_version lts

# Activate starship.
starship init fish | source
