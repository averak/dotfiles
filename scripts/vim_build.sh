#!/usr/bin/env bash

#--------------------------------------------------------------#
##        install vim                                         ##
#--------------------------------------------------------------#
echo "START: install vim"

if [ ! -e vim ]; then
    git clone https://github.com/vim/vim vim
fi

cd vim
git pull origin master

./configure \
    --with-features=huge \
    --enable-fail-if-missing
sudo make
sudo make install

cd -

echo "COMPLETE: install vim"

#--------------------------------------------------------------#
##        install neovim                                      ##
#--------------------------------------------------------------#
echo "START: install neovim"

if [ ! -e neovim ]; then
    git clone https://github.com/neovim/neovim neovim
fi

cd neovim
git pull origin master

sudo rm -rf build
sudo make CMAKE_BUILD_TYPE=Release
sudo make install

cd -

echo "COMPLETE: install neovim"
