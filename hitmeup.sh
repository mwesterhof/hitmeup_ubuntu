#!/bin/sh

set -e

sudo cp files/locale /etc/default/locale
sudo add-apt-repository ppa:neovim-ppa/unstable

sudo apt-get update
sudo apt-get -y install `cat apt_packages |tr "\n" " "`
sudo pip install -r pip_packages

mkdir ~/src
cd ~/src

git clone https://github.com/mephizzle/dotfiles.git

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

ln -s ~/src/dotfiles/gitconfig ~/.gitconfig
ln -s ~/src/bash_prompt/bash_prompt ~/.bash_prompt

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# plugin-only vimrc
ln -s ~/src/dotfiles/vim/vimrc_plugins ~/.vimrc

vim +PlugInstall +qall

rm ~/.vimrc
ln -s ~/src/dotfiles/vim/vimrc_plugins ~/.vimrc_plugins
ln -s ~/src/dotfiles/vim/vimrc ~/.vimrc

ln -s  ~/src/dotfiles/ack/ackrc ~/.ackrc
ln -s  ~/src/dotfiles/gitconfig ~/.gitconfig
ls -s  ~/src/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s  ~/src/dotfiles/zshell/zshrc ~/.zshrc
