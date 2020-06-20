#!/bin/sh

# dotfiles
DOTFILES=`find src/home/ -type f | sed 's/^.*home\///'`

# link
for file in $DOTFILES
do
  ln -s $HOME/dotfiles/src/home/$file $HOME/$file
done

# SSH config
mkdir $HOME/.ssh/
ln -s $HOME/dotfiles/src/.ssh/config $HOME/.ssh/config

# VSCode config
ln -s $HOME/dotfiles/src/vscode/settings.json $HOME/.config/Code/User/settings.json
ln -s $HOME/dotfiles/src/vscode/keybindings.json $HOME/.config/Code/User/keybindings

# Termux config
mkdir $HOME/.termux/
ln -s $HOME/dotfiles/src/.termux/termux.properties $HOME/.termux/termux.properties
