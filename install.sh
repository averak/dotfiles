#!/bin/bash -e


# ===== Versions ==========
ZSH_VERSUIONS=5.7.1
PYTHON_VERSION=3.7.5
RUBY_VERSION=2.7.0
PHP_VERSION=7.4.2
PERL_VERSION=5.6.0
NODE_VERSION=13.6.0
# =========================


# Function to input [y/n]
function ask_yes_no {
  while true; do
    echo
    read -t 60 -p "$* [y/n]: " ANS

    case $ANS in
      [Yy]*)
        return 0
        ;;
      [Nn]*)
        return 1
        ;;
      "")
        echo
        return 1
        ;;
      *)
        echo "yまたはnを入力してください"
        ;;
    esac
  done
}


# Function to install packages
function install_packages {
  for package in $2; do
    printf "Installing ${package}..."
    $1 ${package} &> /dev/null && printf "\e[32mdone\e[0m\n" || printf "\e[31merror\e[0m\n"
  done
}


# ========== processing for each OS ====================
# check and install dependencies
# MacOS
if [ "$(uname)" == "Darwin" ]; then
  if [ ! -e /usr/local/bin/brew ]; then
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  required_packages="git wget openssl autoconf automake cmake"
  install_packages=""
  installed_packages=$(brew list)
  for package in ${required_packages}; do
    echo -n "check ${package}..."
    if echo "${installed_packages}" | grep -xq ${package}; then
      printf "\e[32mOK\e[0m\n"
    else
      printf "\e[31mNot installed\e[0m\n"
      install_packages="${install_packages} ${package}"
    fi
  done

  echo ""
  install_packages 'brew install' "${install_packages}"

# Linux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  if [ -e /etc/lsb-release ];then
    required_packages="build-essential libssl-dev zlib1g-dev libbz2-dev
    libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev
    xz-utils tk-dev liblzma-dev python-openssl lua5.2 liblua5.2-dev luajit libevent-dev
    libclang-dev make git wget curl xclip xsel gawk cmake libtool m4 automake"
    install_packages=""
    installed_packages=$(COLUMNS=200 dpkg -l | awk '{print $2}' | sed -e "s/\:.*$//g")
    for package in ${required_packages}; do
      echo -n "check ${package}..."
      if echo "${installed_packages}" | grep -xq ${package}; then
        printf "\e[32mOK\e[0m\n"
      else
        printf "\e[31mNot installed\e[0m\n"
        install_packages="${install_packages} ${package}"
      fi
    done

    sudo apt-get update -y
    echo ""
    install_packages 'sudo apt-get install -y' "${install_packages}"

  elif [ -e /etc/redhat-release ]; then
    required_packages="gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel
    openssl-devel xz xz-devel findutils lua-devel luajit-devel ncurses-devel perl-ExtUtils-Embed
    ncurses-devel libevent-devel make git wget curl xclip xsel cmake"
    install_packages=""
    installed_packages=$(yum list installed | awk '{print $1}' | sed -e "s/\..*$//g")
    for package in ${required_packages}; do
      echo -n "check ${package}..."
      if echo "${installed_packages}" | grep -xq ${package}; then
        printf "\e[32mOK\e[0m\n"
      else
        printf "\e[31mNot installed\e[0m\n"
        install_packages="${install_packages} ${package}"
      fi
    done

    echo ""
    install_packages 'sudo yum install -y' "${install_packages}"
  else
    echo "WARNING: It seems that your environment is not tested."
  fi

# Unknown OS
else
  echo Unknown OS...
  exit
fi

# install zsh
if [ ! -e /usr/local/bin/zsh ]; then
  if ask_yes_no "Start install zsh OK? "; then
    echo "Installing zsh..."
    wget https://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSUIONS}/zsh-${ZSH_VERSUIONS}.tar.xz/download -O zsh-${ZSH_VERSUIONS}.tar.xz
    tar xvf zsh-${ZSH_VERSUIONS}.tar.xz
    cd zsh-${ZSH_VERSUIONS}
    ./configure --enable-multibyte
    sudo make
    sudo make install
    cd -
    rm -rf zsh-${ZSH_VERSUIONS}*
  fi
fi

# install zprezto
if [ ! -e ~/.zprezto ];then
  echo "Installing zprezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# overwrite zsh config files
if ask_yes_no "Overwrite zsh config files OK? "; then
  cp zsh/.z* ~/
fi

# overwrite .gitconfig
if ask_yes_no "Overwrite .gitconfig OK? "; then
  cp .gitconfig ~/
fi

# install fzf
if [ ! -e ~/.fzf ];then
  echo "Installing fzf..."
  git clone https://github.com/junegunn/fzf.git ~/.fzf
  cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc && cd -
fi

# install rust
if [ ! -e ~/.cargo ];then
  if ask_yes_no "Start install Rust OK? "; then
    echo "Installing Rust..."
    curl https://sh.rustup.rs -sSf | sh
  fi
fi

# install rust packages
if [ -e ~/.cargo/bin/cargo ];then
  required_packages="exa bat hexyl fd-find procs ripgrep"
  for package in ${required_packages}; do
    if [ ! -e ~/.cargo/bin/${package} ];then
      echo "Installing ${package}..."
      ~/.cargo/bin/cargo install ${package}
    fi
  done
fi

# install pyenv
if [ ! -e ~/.pyenv ];then
  echo "Installing pyenv..."
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

# install python
if [ ! -e "${HOME}"/.pyenv/versions/${PYTHON_VERSION} ];then
  if ask_yes_no "Start install Python ${PYTHON_VERSION} OK? "; then
    ~/.pyenv/bin/pyenv install ${PYTHON_VERSION}
    ~/.pyenv/bin/pyenv global ${PYTHON_VERSION}
    ~/.pyenv/shims/pip install -U pip
    ~/.pyenv/shims/pip install -r lib/requirements.txt
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

# install ruby
if [ ! -e "${HOME}"/.rbenv/versions/${RUBY_VERSION} ];then
  if ask_yes_no "Start install Ruby ${RUBY_VERSION} OK? "; then
    ~/.rbenv/bin/rbenv install ${RUBY_VERSION}
    ~/.rbenv/bin/rbenv global ${RUBY_VERSION}
  fi
else
  echo "Ruby ${RUBY_VERSION} is already installed."
fi

# install phpenv
if [ ! -e ~/.phpenv ];then
  echo "Installing phpenv..."
  git clone https://github.com/phpenv/phpenv ~/.phpenv
  echo "Installing php-build..."
  git clone https://github.com/php-build/php-build ~/.phpenv//plugins/php-build
fi

# install php
if [ ! -e "${HOME}"/.phpenv/versions/${PHP_VERSION} ];then
  if ask_yes_no "Start install PHP ${PHP_VERSION} OK? "; then
    ~/.phpenv/bin/phpenv install ${PHP_VERSION}
    ~/.phpenv/bin/phpenv global ${PHP_VERSION}
  fi
else
  echo "PHP ${PHP_VERSION} is already installed."
fi

# install plenv
if [ ! -e ~/.plenv ];then
  echo "Installing plenv..."
  git clone https://github.com/tokuhirom/plenv ~/.plenv
  echo "Installing perl-build..."
  git clone https://github.com/tokuhirom/Perl-Build ~/.plenv/plugins/perl-build
fi

# install perl
if [ ! -e "${HOME}"/.plenv/versions/${PERL_VERSION} ];then
  if ask_yes_no "Start install Perl ${PERL_VERSION} OK? "; then
    ~/.plenv/bin/plenv install ${PERL_VERSION}
    ~/.plenv/bin/plenv global ${PERL_VERSION}
  fi
else
  echo "Perl ${PERL_VERSION} is already installed."
fi

# install nodenv
if [ ! -e ~/.nodenv ];then
  echo "Installing nodenv..."
  git clone https://github.com/nodenv/nodenv ~/.nodenv
  echo "Installing node-build..."
  git clone https://github.com/nodenv/node-build ~/.nodenv/plugins/node-build
fi

# install nodejs
if [ ! -e "${HOME}"/.nodenv/versions/${NODE_VERSION} ];then
  if ask_yes_no "Start install Nodejs ${NODE_VERSION}  OK? "; then
    ~/.nodenv/bin/nodenv install ${NODE_VERSION}
    ~/.nodenv/bin/nodenv global ${NODE_VERSION}
  fi
else
  echo "Nodejs ${NODE_VERSION} is already installed."
fi

# install vim
ROOTDIR=$PWD
if [ ! -e /usr/local/bin/vim ]; then
  if ask_yes_no "Start install vim OK? "; then
    echo "Installing vim..."
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
  if ask_yes_no "Start install neovim OK? "; then
    echo "Installing neovim..."
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
echo "----------------------------------------------------------------------"
echo "Sucessfully installed essential tools."
#echo "Please run following command \"exec zsh -l\" to run zsh."

printf "\nOK\n"
