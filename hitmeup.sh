#!/bin/sh

set -e

sudo cp files/locale /etc/default/locale
sudo add-apt-repository ppa:neovim-ppa/unstable

sudo apt-get update
sudo apt-get -y install `cat apt_packages |tr "\n" " "`
sudo pip install -r pip_packages

mkdir -p ~/src
mkdir -p ~/dev
cd ~/src

git clone https://github.com/mwesterhof/dotfiles.git

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
# chsh -s `which zsh`

ln -sf ~/src/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/src/bash_prompt/bash_prompt ~/.bash_prompt

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# plugin-only vimrc
ln -sf ~/src/dotfiles/vim/vimrc_plugins ~/.config/nvim/init.vim
nvim +PlugInstall +qall
rm ~/.config/nvim/init.vim
ln -sf ~/src/dotfiles/vim/vimrc_plugins ~/.vimrc_plugins
ln -sf ~/src/dotfiles/vim/vimrc ~/.config/nvim/init.vim

ln -sf ~/src/dotfiles/ack/ackrc ~/.ackrc
# ls -sf ~/src/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/src/dotfiles/zshell/zshrc ~/.zshrc
ln -sf ~/src/dotfiles/xonsh/xonsh.rc ~/.xonshrc
