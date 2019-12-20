#!/bin/bash -e

# Pyenv-pythons, Vim8, Neovim

# install zprezto
if [ ! -e ~/.zprezto ];then
    echo "Installing zprezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    cp zsh/* ~/
fi

# install pyenv
if [ ! -e ~/.pyenv ];then
    echo "Installing pyenv..."
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
fi

# install fzf
if [ ! -e ~/.fzf ];then
    echo "Installing fzf..."
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    workdir=${PWD}
    cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc && cd ${workdir}
fi

# install enable-shared python using pyenv
if [ ! -e "${HOME}"/.pyenv/versions/3.7.4 ];then
    CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.4
else
    echo "Python 3.7.4 is already installed."
fi

# set python
pyenv shell --unset
pyenv global 3.7.4

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

# install my karabiner config
git clone https://github.com/AtLab-jp/Karabiner-settings ~/.config/karabiner

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
