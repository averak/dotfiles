#!/bin/bash -e

## ========== Vim =======================
echo "Start Vim..."
deploy_path=`pwd`

remote_path=https://github.com/vim/vim
branch=master

cd ${deploy_path}

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


if [ ! -e vim ]; then
    git clone ${remote_path} vim
    echo 'cloning success!'
fi
cd ${deploy_path}/vim
result=`sudo git pull origin ${branch}`
if [ "`echo $result | grep 'Already'`" ]; then
    echo 'Already up to date'
    echo 'finish'
else
    echo 'git pull is success!'
    # build
    if ask_yes_no "start build Vim OK? "; then
        cd ${deploy_path}/vim
        ./configure \
            --with-features=huge \
            --enable-perlinterp \
            --enable-pythoninterp \
            --enable-python3interp \
            --enable-rubyinterp=yes \
            --enable-fail-if-missing
        sudo make
        sudo make install
        echo 'vim build done!'
    else
        echo 'finish'
    fi
fi


## ========== Neovim ====================
echo ""
echo "Start Neoim..."

remote_path=https://github.com/neovim/neovim
branch=master

cd ${deploy_path}

if [ ! -e neovim ]; then
    git clone ${remote_path} neovim
    echo 'cloning success!'
fi
cd ${deploy_path}/neovim
result=`sudo git pull origin ${branch}`
if [ "`echo $result | grep 'Already'`" ]; then
    echo 'Already up to date'
    echo 'finish'
else
    echo 'git pull is success!'
    # build
    if ask_yes_no "start build Neovim OK? "; then
        cd ${deploy_path}/neovim
        sudo rm -rf build
        sudo make CMAKE_BUILD_TYPE=Release
        sudo make install
        echo 'neovim build done!'
    else
        echo 'finish'
    fi
fi
