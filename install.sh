#!/bin/bash

# dotfiles
readonly DOTFILES=(.bashrc .vimrc .gitconfig)

# link
for file in ${DOTFILES[@]}
do
  ln -s $HOME/dotfiles/src/$file $HOME/$file
done

# SSH config
mkdir $HOME/.ssh/
ln -s $HOME/dotfiles/src/.ssh/config $HOME/.ssh/config
