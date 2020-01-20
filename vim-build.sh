## ========== Vim =======================
echo "Start Vim..."
deploy_path=`pwd`

remote_path=https://github.com/vim/vim
branch=master

cd ${deploy_path}

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
    echo 'start build Vim OK? [yes/no]'
    read answer
    if [ "$answer" == "yes" ]; then
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
echo "\n\nStart Neoim..."

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
    echo 'start build Neovim OK? [yes/no]'
    read answer
    if [ "$answer" == "yes" ]; then
        cd ${deploy_path}/neovim
        sudo rm -rf build
        sudo make CMAKE_BUILD_TYPE=Release
        sudo make install
        echo 'neovim build done!'
    else
        echo 'finish'
    fi
fi
