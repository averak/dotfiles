#!/bin/bash -e


# Versions
PYTHON_VERRSION=3.7.4
RUBY_VERSION=2.7.0
NODE_VERSION=13.6.0

# Input [y/n]
function ask_yes_no {
    while true; do
    echo "$* [y/n]: "
    read ANS
    case $ANS in
      [Yy]*)
        return 0
        ;;
      [Nn]*)
        return 1
        ;;
    *)
        echo "please press [y/n]"
        ;;
      esac
    done
}

# check and install dependencies
if [ -e /etc/lsb-release ];then
    required_packages="build-essential libssl-dev zlib1g-dev libbz2-dev
        libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev
        xz-utils tk-dev liblzma-dev python-openssl lua5.2 liblua5.2-dev luajit libevent-dev
        make git zsh wget curl xclip xsel gawk cmake libtool m4 automake"
    install_packages=""
    installed_packages=$(COLUMNS=200 dpkg -l | awk '{print $2}' | sed -e "s/\:.*$//g")
    for package in ${required_packages}; do
        echo -n "check ${package}..."
        if echo "${installed_packages}" | grep -xq ${package}; then
            echo "OK."
        else
           echo "Not installed."
            install_packages="${install_packages} ${package}"
        fi
    done

    if [ ! -z "${install_packages}" ]; then
        echo "following packages will be installed: ${install_packages}"
        sudo apt install -y ${install_packages}
    fi
elif [ -e /etc/redhat-release ]; then
    required_packages="gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel
        openssl-devel xz xz-devel findutils lua-devel luajit-devel ncurses-devel perl-ExtUtils-Embed
        ncurses-devel libevent-devel make git zsh wget curl xclip xsel"
    install_packages=""
    installed_packages=$(yum list installed | awk '{print $1}' | sed -e "s/\..*$//g")
    for package in ${required_packages}; do
        echo -n "check ${package}..."
        if echo "${installed_packages}" | grep -xq ${package}; then
            echo "OK."
        else
            echo "Not installed."
            install_packages="${install_packages} ${package}"
        fi
    done
    if [ ! -z "${install_packages}" ]; then
        echo "following packages will be installed: ${install_packages}"
        sudo yum install -y ${install_packages}
    fi
else
    echo "WARNING: It seems that your environment is not tested."
fi

# install zprezto
if [ ! -e ~/.zprezto ];then
    echo "Installing zprezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    cp zsh/.* ~/
fi

# install fzf
if [ ! -e ~/.fzf ];then
    echo "Installing fzf..."
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    workdir=${PWD}
    cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc && cd ${workdir}
fi

# install pyenv
if [ ! -e ~/.pyenv ];then
    echo "Installing pyenv..."
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
fi

# install enable-shared python using pyenv
if [ ! -e "${HOME}"/.pyenv/versions/${PYTHON_VERSION} ];then
    if ask_yes_no "start install python OK? "; then
        ~/.pyenv/bin/pyenv install ${PYTHON_VERSION}
        ~/.pyenv/bin/pyenv global ${PYTHON_VERSION}
    fi
else
    echo "Python ${PYTHON_VERSION} is already installed."
fi

# install rbenv
if [ ! -e ~/.rbenv ];then
    echo "Installing rbenv..."
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    echo "Installing ruby-build..."
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# install enable-shared ruby using rbenv
if [ ! -e "${HOME}"/.rbenv/versions/${RUBY_VERSION} ];then
    if ask_yes_no "start install python OK? "; then
        ~/.rbenv/bin/rbenv install ${RUBY_VERSION}
        ~/.rbenv/bin/rbenv global ${RUBY_VERSION}
    fi
else
    echo "Ruby ${RUBY_VERSION} is already installed."
fi

# install nodenv
if [ ! -e ~/.nodenv ];then
    echo "Installing nodenv..."
    git clone git://github.com/nodenv/nodenv.git ~/.nodenv
    echo "Installing node-build..."
    git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
fi

# install nodejs
if [ ! -e "${HOME}"/.nodenv/versions/${NODE_VERSION} ];then
    if ask_yes_no "start install python OK? "; then
        ~/.nodenv/bin/nodenv install ${NODE_VERSION}
        ~/.nodenv/bin/nodenv global ${NODE_VERSION}
    fi
else
    echo "Nodejs ${NODE_VERSION} is already installed."
fi

# .gitconfig
cp .gitconfig ~/

# install vim
ROOTDIR=$PWD
if [ ! -e /usr/local/bin/vim ]; then
    if ask_yes_no "start install vim OK? "; then
        echo "installing vim..."
        cd ${ROOTDIR}
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
fi

# install nvim
if [ ! -e /usr/local/bin/nvim ]; then
    if ask_yes_no "start install neovim OK? "; then
        echo "installing neovim..."
        cd ${ROOTDIR}
        git clone https://github.com/neovim/neovim.git
        cd neovim
        sudo make CMAKE_BUILD_TYPE=Release
        sudo make install
    fi
fi

# install my vim config
if [ ! -e ~/.vim ];then
    echo "Installing my vim config..."
    git clone https://github.com/AtLab-jp/vim ~/.vim
fi
if [ ! -e ~/.config/nvim ];then
    echo "Installing my nvim config..."
    git clone https://github.com/AtLab-jp/neovim ~/.config/nvim
fi

cd $ROOTDIR


echo ""
echo "Sucessfully installed essential tools."
echo "Please run following command \"exec zsh -l\" to run zsh."
