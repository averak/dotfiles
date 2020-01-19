#!/bin/bash -e

# install zprezto
if [ ! -e ~/.zprezto ];then
    echo "Installing zprezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    cp zsh/.* ~/
fi

# install pyenv
if [ ! -e ~/.pyenv ];then
    echo "Installing pyenv..."
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
fi

# install enable-shared python using pyenv
if [ ! -e "${HOME}"/.pyenv/versions/3.7.4 ];then
    ~/.pyenv/bin/pyenv install 3.7.4
    ~/.pyenv/bin/pyenv global 3.7.4
else
    echo "Python 3.7.4 is already installed."
fi

# install rbenv
if [ ! -e ~/.rbenv ];then
    echo "Installing rbenv..."
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    echo "Installing ruby-build..."
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# install enable-shared ruby using rbenv
if [ ! -e "${HOME}"/.rbyenv/versions/2.7.0 ];then
    ~/.rbenv/bin/rbenv install 2.7.0
    ~/.rbenv/bin/rbenv global 2.7.0
else
    echo "Ruby 2.7.0 is already installed."
fi

# install nodenv
if [ ! -e ~/.nodenv ];then
    echo "Installing nodenv..."
    git clone git://github.com/nodenv/nodenv.git ~/.nodenv
fi

# install nodejs
if [ ! -e "${HOME}"/.nodenv/versions/13.6.0 ];then
    ~/.nodenv/bin/nodenv install 13.6.0
    ~/.nodenv/bin/nodenv global 13.6.0
else
    echo "Nodejs 13.6.0 is already installed."
fi

# .gitconfig
cp .gitconfig ~/

# install fzf
if [ ! -e ~/.fzf ];then
    echo "Installing fzf..."
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    workdir=${PWD}
    cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc && cd ${workdir}
fi

# install vim
ROOTDIR=$PWD
TMPDIR=$(mktemp -d /tmp/XXXXX)
if [ ! -e ${HOME}/usr/local/bin/vim ]; then
    echo "installing vim 8..."
    cd "$TMPDIR"
    git clone https://github.com/vim/vim.git
    cd vim
    ./configure \
        --with-features=huge \
        --enable-perlinterp \
        --enable-pythoninterp \
        --enable-python3interp \
        --enable-rubyinterp=yes \
        --enable-fail-if-missing
    sudo make
    sudo make install
fi

# install nvim
if [ ! -e ${HOME}/usr/local/bin/nvim ]; then
    echo "installing neovim..."
    cd "$TMPDIR"
    git clone https://github.com/neovim/neovim.git
    cd neovim
    sudo make CMAKE_BUILD_TYPE=Release
    sudo make install
fi

# install my vim config
if [ ! -e ~/.vim ];then
    echo "Installing my vim config..."
    git clone https://github.com/AjxLab/vim ~/.vim
fi
if [ ! -e ~/.config/nvim ];then
    echo "Installing my nvim config..."
    git clone https://github.com/AjxLab/neovim ~/.config/nvim
fi

# install my karabiner config
git clone https://github.com/AjxLab/Karabiner-settings ~/.config/karabiner

# clean up
cd "$ROOTDIR"
[ -e "$TMPDIR" ] && rm -fr "$TMPDIR"


echo ""
echo "Sucessfully installed essential tools."
echo "Please run following command \"exec zsh -l\" to run zsh."
