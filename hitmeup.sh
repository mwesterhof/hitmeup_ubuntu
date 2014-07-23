#!/bin/sh

set -e

sudo cp files/locale /etc/default/locale

sudo apt-get update
sudo apt-get -y install `cat apt_packages |tr "\n" " "`
sudo pip install -r pip_packages

mkdir ~/src
cd ~/src

git clone https://github.com/mephizzle/dotfiles.git
git clone https://github.com/mephizzle/bash_prompt.git

ln -s ~/src/dotfiles/gitconfig ~/.gitconfig
ln -s ~/src/bash_prompt/bash_prompt ~/.bash_prompt

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# plugin-only vimrc
ln -s ~/src/dotfiles/vim/vimrc_plugins ~/.vimrc

vim +PluginInstall +qall

rm ~/.vimrc
ln -s ~/src/dotfiles/vim/vimrc_plugins ~/.vimrc_plugins
ln -s ~/src/dotfiles/vim/vimrc ~/.vimrc

echo ". ~/.bash_prompt" >> ~/.bashrc
echo "set -o vi" >> ~/.bashrc

echo | byobu-enable
