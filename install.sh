#!/bin/bash -e

# Pyenv-pythons, Vim8, Neovim

# check and install dependencies
if [ -e /etc/lsb-release ];then
    required_packages="build-essential libssl-dev zlib1g-dev libbz2-dev
        libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev
        xz-utils tk-dev liblzma-dev python-openssl lua5.2 liblua5.2-dev luajit libevent-dev
        make git zsh wget curl xclip xsel gawk"
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
    cp zsh/* ~/
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
if [ ! -e "${HOME}"/.pyenv/versions/3.7.4 ];then
    ~/.pyenv/bin/pyenv install 3.7.4
else
    echo "Python 3.7.4 is already installed."
fi

# set python
~/.pyenv/bin/pyenv shell --unset
~/.pyenv/bin/pyenv global 3.7.4

# check python version
python_version=$(python --version 2>&1)
if [ "${python_version}" = "Python 3.7.4" ];then
    echo Python 3 version check is OK.
else
    echo Python 3 version check is failed.
    exit 1
fi

# install vim
ROOTDIR=$PWD
TMPDIR=$(mktemp -d /tmp/XXXXX)
if [ ! -e ${HOME}/local/bin/vim ]; then
    echo "installing vim 8..."
    cd "$TMPDIR"
    git clone https://github.com/vim/vim.git
    cd vim
    LDFLAGS="-Wl,-rpath=${HOME}/.pyenv/versions/3.7.4/lib" \
        ./configure \
        --enable-fail-if-missing \
        --enable-pythoninterp=dynamic \
        --enable-python3interp=dynamic \
        --with-features=huge \
        --enable-luainterp \
        --enable-cscope \
        --enable-fontset \
        --enable-multibyte \
        --prefix="${HOME}"/local
    make -j && make install
fi

# install nvim
if [ ! -e ${HOME}/local/bin/nvim ]; then
    echo "installing neovim..."
    cd ${HOME}/local/bin
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x nvim.appimage
    if ./nvim.appimage --version >& /dev/null; then
        ln -s ./nvim.appimage nvim
    else
        ./nvim.appimage --appimage-extract
        mv -v squashfs-root ../nvim
        ln -s ../nvim/AppRun nvim
        rm nvim.appimage
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

# clean up
cd "$ROOTDIR"
[ -e "$TMPDIR" ] && rm -fr "$TMPDIR"

# install vim plugins
echo "installing vim plugins..."
export PATH=${HOME}/local/bin:$PATH
[ ! -e ~/.vim/dein/repos/github.com/Shougo/dein.vim ] && \
    git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim
[ ! -e ~/.config/nvim/dein/repos/github.com/Shougo/dein.vim ] && \
    git clone https://github.com/Shougo/dein.vim ~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
vim -c "try | call dein#install() | finally | qall! | endtry" -N -u ${HOME}/.vimrc -V1 -es
vim -c "try | call dein#update() | finally | qall! | endtry" -N -u ${HOME}/.vimrc -V1 -es
nvim -c "try | call dein#install() | finally | qall! | endtry" -N -u ${HOME}/.vim/init.vim -V1 -es
nvim -c "try | call dein#update() | finally | qall! | endtry" -N -u ${HOME}/.vim/init.vim -V1 -es

echo ""
echo "Sucessfully installed essential tools."
echo "Please run following command \"exec zsh -l\" to run zsh."
