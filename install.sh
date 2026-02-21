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

# fisher config (https://github.com/jorgebucaran/fisher?tab=readme-ov-file#installation)
# TODO: Not tested.
if ! type "fish" > /dev/null 2>&1; then
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fi

# nvm config
# For bash
# TODO
# For fish (https://github.com/jorgebucaran/nvm.fish?tab=readme-ov-file#installation)
if ! type "fish" > /dev/null 2>&1; then
  if [ -f "$HOME/.config/fish/functions/fisher.fish" ]; then
    fish -c "fisher install jorgebucaran/nvm.fish"
  fi
fi
# Install Node.js for bash
# TODO
# Install Node.js for fish
if ! type "fish" > /dev/null 2>&1; then
  if [ -f "$HOME/.config/fish/functions/nvm.fish" ]; then
    fish -c "nvm install lts"
    fish -c "nvm install latest"
    fish -c "nvm use lts"
  fi
fi

# Node.js config
# For bash
# TODO
# For fish
if ! type "fish" > /dev/null 2>&1; then
  if [ -f "$HOME/.config/fish/functions/nvm.fish" ]; then
    fish -c "nvm use lts"
    fish -c "npm install -g npm corepack"
    fish -c "nvm use latest"
    fish -c "npm install -g npm corepack"
    fish -c "nvm use lts"
  fi
fi

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
# TODO: Install coc plugins from shell.
# vim -c \
#   'CocInstall coc-sh' -c \
#   'CocInstall coc-fish' -c \
#   'CocInstall coc-powershell' -c \
#   'CocInstall coc-xml' -c \
#   'CocInstall coc-json' -c \
#   'CocInstall coc-yaml' -c \
#   'CocInstall coc-markdownlint' -c \
#   'CocInstall coc-pyright' -c \
#   'CocInstall coc-lua' -c \
#   'CocInstall coc-rust-analyzer' -c \
#   'CocInstall coc-eslint' -c \
#   'CocInstall coc-prettier' -c \
#   'CocInstall coc-tsserver' -c \
#   'CocInstall coc-ccls' -c \
#   'CocInstall coc-omnisharp' -c \
#   'CocInstall coc-java' -c \
#   'CocInstall coc-go' -c \
#   'CocInstall coc-html' -c \
#   'CocInstall coc-css' -c \
#   'CocInstall coc-sql' -c \

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

# Firefox config
mkdir -p $HOME/.mozilla/firefox/fts9ckj3.default-release/chrome/
ln -s $HOME/dotfiles/src/firefox/userChrome.css $HOME/.mozilla/firefox/fts9ckj3.default-release/chrome/userChrome.css
ln -s $HOME/dotfiles/src/firefox/user.js $HOME/.mozilla/firefox/fts9ckj3.default-release/user.js
