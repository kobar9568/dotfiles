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
if [ -n "$DISPLAY" ]; then
  mkdir -p $HOME/.config/Code/User/
  ln -s $HOME/dotfiles/src/vscode/settings.json $HOME/.config/Code/User/settings.json
  ln -s $HOME/dotfiles/src/vscode/keybindings.json $HOME/.config/Code/User/keybindings
fi

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
ln -s $HOME/dotfiles/src/fish/fuck.fish $HOME/.config/fish/functions/fuck.fish
ln -s $HOME/dotfiles/src/fish/repo.fish $HOME/.config/fish/functions/repo.fish
ln -s $HOME/dotfiles/src/fish/ghq.fish $HOME/.config/fish/functions/ghq.fish
ln -s $HOME/dotfiles/src/fish/do_ctrl_g.fish $HOME/.config/fish/functions/do_ctrl_g.fish

# tmux config
ln -s $HOME/dotfiles/src/tmux/.tmux.conf $HOME/.tmux.conf
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# htop config
mkdir -p $HOME/.config/htop/
ln -s $HOME/dotfiles/src/htop/htoprc $HOME/.config/htop/htoprc

# starship config
mkdir -p $HOME/.config/starship/
ln -s $HOME/dotfiles/src/starship/starship.toml $HOME/.config/starship/starship.toml

# Powerline config
mkdir -p $HOME/.config/powerline/
ln -s $HOME/dotfiles/src/powerline/colors.json $HOME/.config/powerline/colors.json
ln -s $HOME/dotfiles/src/powerline/config.json $HOME/.config/powerline/config.json
mkdir -p $HOME/.config/powerline/colorschemes/
mkdir -p $HOME/.config/powerline/themes/
mkdir -p $HOME/.config/powerline/themes/tmux/
ln -s $HOME/dotfiles/src/powerline/themes/tmux/tmux_config.json $HOME/.config/powerline/themes/tmux/tmux_config.json

ln -s $HOME/dotfiles/src/powerline/colorschemes/deus.json $HOME/.config/powerline/colorschemes/deus.json
mkdir -p $HOME/.config/powerline/colorschemes/tmux/
ln -s $HOME/dotfiles/src/powerline/colorschemes/tmux/deus.json $HOME/.config/powerline/colorschemes/tmux/deus.json

# vim config
mkdir -p $HOME/.vim/
ln -s $HOME/dotfiles/src/vim/coc-settings.json $HOME/.vim/coc-settings.json

# Golang config
mkdir -p $HOME/go/bin/
mkdir -p $HOME/go/src/github.com/kobar9568/

# Golang installation
GO_VERSION=1.16.3

if ! type "go" > /dev/null 2>&1; then
  mkdir $HOME/go_install/
  if [ `uname -m` = "x86_64" ]; then
    wget https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz -O $HOME/go_install/go$GO_VERSION.linux-amd64.tar.gz
    tar xf $HOME/go_install/go$GO_VERSION.linux-amd64.tar.gz -C ~/go_install/
  elif [ `uname -m` = "aarch64" ]; then
    # Not tested
    wget https://golang.org/dl/go$GO_VERSION.linux-arm64.tar.gz -O $HOME/go_install/go$GO_VERSION.linux-arm64.tar.gz
    tar xf $HOME/go_install/go$GO_VERSION.linux-arm64.tar.gz -C ~/go_install/
  fi
  $HOME/go_install/go/bin/go get golang.org/dl/go$GO_VERSION
  go$GO_VERSION download
  ln -s go$GO_VERSION $GOBIN/go
  rm -rf $HOME/go_install/
  go install github.com/pilu/fresh@latest
fi
