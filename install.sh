#!/bin/bash

readonly DOTFILES=(.vimrc .gitconfig)

for file in ${DOTFILES[@]}
do
  ln -s $HOME/dotfiles/src/$file $HOME/$file
done

