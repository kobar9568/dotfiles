#!/bin/sh

# dotfiles
DOTFILES=`find src/home/ -type f | sed 's/^.*home\///'`

# link
for file in $DOTFILES
do
  ln -s $HOME/dotfiles/src/home/$file $HOME/$file
done

# SSH config
mkdir -p $HOME/.ssh/
chmod 700 $HOME/.ssh/
ln -s $HOME/dotfiles/src/.ssh/config $HOME/.ssh/config
chmod 600 $HOME/.ssh/config

# VSCode config
ln -s $HOME/dotfiles/src/vscode/settings.json $HOME/.config/Code/User/settings.json
ln -s $HOME/dotfiles/src/vscode/keybindings.json $HOME/.config/Code/User/keybindings

# Termux config
if [ `uname -o` = "Android" ]; then
  mkdir -p $HOME/.termux/
  ln -s $HOME/dotfiles/src/.termux/termux.properties $HOME/.termux/termux.properties
fi

# bat config
mkdir -p $HOME/.config/bat/
ln -s $HOME/dotfiles/src/bat/config $HOME/.config/bat/config

# fish config
mkdir -p $HOME/.config/fish/
ln -s $HOME/dotfiles/src/fish/config.fish $HOME/.config/fish/config.fish
mkdir -p $HOME/.config/fish/functions/
ln -s $HOME/dotfiles/src/fish/fish_title.fish $HOME/.config/fish/functions/fish_title.fish
ln -s $HOME/dotfiles/src/fish/fish_user_key_bindings.fish $HOME/.config/fish/functions/fish_user_key_bindings.fish

# tmux config
ln -s $HOME/dotfiles/src/tmux/.tmux.conf $HOME/.tmux.conf

# htop config
mkdir -p $HOME/.config/htop/
ln -s $HOME/dotfiles/src/htop/htoprc $HOME/.config/htop/htoprc

# starship config
mkdir -p $HOME/.config/
ln -s $HOME/dotfiles/src/starship/starship.toml $HOME/.config/starship.toml

# vim config
mkdir -p $HOME/.vim/
ln -s $HOME/dotfiles/src/vim/coc-settings.json $HOME/.vim/coc-settings.json

# Golang config
mkdir -p $HOME/go/bin/
mkdir -p $HOME/go/src/github.com/kobar9568/
