#!/usr/bin/env sh

cd ~

#--------------------------------------------------------------#
##        clone dotfiles                                      ##
#--------------------------------------------------------------#
echo "START: git clone dotfiles"

if [ ! -e ~/dotfiles ]; then
  git clone https://github.com/averak/dotfiles ~/dotfiles
fi
cd ~/dotfiles

ask_exec=~/dotfiles/scripts/ask_exec.sh
installer=~/dotfiles/scripts/installer.sh
vim_build=~/dotfiles/scripts/vim_build.sh
font_install=~/dotfiles/scripts/font_install.sh

echo "COMPLETE: git clone dotfiles"
echo ""

#--------------------------------------------------------------#
##        install packages                                    ##
#--------------------------------------------------------------#
echo "START: install packages"

if [ "$(uname)" == "Darwin" ]; then
  # macos
  if [ ! -e /usr/local/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
  cmd="brew install"
  packages="git wget openssl autoconf automake cmake ninja libtool pkg-config gettext fontconfig"
  installed_packages=$(brew list --formula)

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  if [ -e /etc/lsb-release ];then
    # Ubuntu
    cmd="sudo apt-get install -y"
    packages="build-essential gettext libssl-dev zlib1g-dev libbz2-dev
    libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev libffi-dev
    xz-utils tk-dev liblzma-dev python-openssl lua5.2 liblua5.2-dev luajit libevent-dev
    libclang-dev make git wget curl xclip xsel gawk cmake libtool m4 automake unzip "
    installed_packages=$(COLUMNS=200 dpkg -l | awk '{print $2}' | sed -e "s/\:.*$//g")

  elif [ -e /etc/redhat-release ]; then
    # Cent7
    cmd="sudo yum install -y"
    packages="gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel
    openssl-devel xz xz-devel findutils lua-devel luajit-devel ncurses-devel perl-ExtUtils-Embed
    ncurses-devel libevent-devel make git wget curl xclip xsel cmake libffi-devel libtoo gcc-c++"
    installed_packages=$(yum list installed | awk '{print $1}' | sed -e "s/\..*$//g")

  else
    echo "WARNING: It seems that your environment is not tested."
  fi

else
  echo Unknown OS...
  exit 1
fi

${installer} "${cmd}" "${packages}" "${installed_packages}"

echo "COMPLETE: install packages"
echo ""

#--------------------------------------------------------------#
##        install zsh                                         ##
#--------------------------------------------------------------#
echo "START: install zsh"

if ${ask_exec} "install zsh OK?"; then
  ZSH_VERSION=5.8
  wget https://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.xz/download -O zsh-${ZSH_VERSION}.tar.xz
  tar xvf zsh-${ZSH_VERSION}.tar.xz
  cd zsh-${ZSH_VERSION}
  ./configure --enable-multibyte
  sudo make
  sudo make install
  cd ~/dotfiles
  rm -rf zsh-${ZSH_VERSION}*

  # install zprezto
  if [ ! -e ~/.zprezto ];then
    git clone https://github.com/sorin-ionescu/prezto ~/.zprezto
  fi
fi

echo "COMPLETE: install zsh"
echo ""

#--------------------------------------------------------------#
##        install fzf                                         ##
#--------------------------------------------------------------#
echo "START: install fzf"

if [ ! -e ~/.fzf ];then
  git clone https://github.com/junegunn/fzf ~/.fzf
  cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc
  cd ~/dotfiles
fi

echo "COMPLETE: install fzf"
echo ""

#--------------------------------------------------------------#
##        install rust packages                               ##
#--------------------------------------------------------------#
echo "START: install rust packages"

if ${ask_exec} "install rust packages OK?"; then
  # rust
  if [ ! -e ~/.cargo ];then
    curl https://sh.rustup.rs -sSf | sh
  fi

  # rust packages
  if [ -e ~/.cargo/bin/cargo ];then
    packages="exa bat hexyl fd-find procs ripgrep"
    for pkg in ${packages}; do
      if [ ! -e ~/.cargo/bin/${pkg} ];then
        ~/.cargo/bin/cargo install ${pkg}
      fi
    done
  fi
fi

echo "COMPLETE: install rust packages"
echo ""

#--------------------------------------------------------------#
##        install anyenv                                      ##
#--------------------------------------------------------------#
echo "START: install anyenv"

git clone https://github.com/anyenv/anyenv ~/.anyenv
mkdir -p ~/.anyenv/plugins
git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update

echo "COMPLETE: install anyenv"
echo ""

#--------------------------------------------------------------#
##        install vim & neovim                                ##
#--------------------------------------------------------------#
echo "START: install vim & neovim"

# build vim & neovim
if ${ask_exec} "install vim & neovim?"; then
  ${vim_build}
fi

# set conf
if [ ! -e ~/.vim ];then
  git clone https://github.com/averak/vim ~/.vim
fi
if [ ! -e ~/.config/nvim ];then
  git clone https://github.com/averak/neovim ~/.config/nvim
fi

echo "COMPLETE: install vim & neovim"
echo ""

#--------------------------------------------------------------#
##        install nerd font                                   ##
#--------------------------------------------------------------#
echo "START: install nerd font"

if ${ask_exec} "install nerd font?"; then
  ${font_install}
fi

echo "COMPLETE: install nerd font"
echo ""


#--------------------------------------------------------------#
##        clean setting files                                 ##
#--------------------------------------------------------------#
echo "START: clean setting files"

if ${ask_exec} "clean setting files OK?"; then
  [ -e ~/.zshrc ] && rm ~/.zshrc
  [ -e ~/.zprofile ] && rm ~/.zprofile
  [ -e ~/.bashrc ] && rm ~/.bashrc
  [ -e ~/.bash_profile ] && rm ~/.bash_profile
  [ -e ~/.config/starship.toml ] && rm ~/.config/starship.toml
  [ -e ~/.zpreztorc ] && rm ~/.zpreztorc
  [ -e ~/.gitconfig ] && rm ~/.gitconfig
  [ -e ~/.config/git/ignore ] && rm ~/.config/git/ignore
fi

echo "COMPLETE: clean setting files"
echo ""

#--------------------------------------------------------------#
##        set symbolic links                                  ##
#--------------------------------------------------------------#
echo "START: setup symbolic links"

if ${ask_exec} "setup symbolic links OK?"; then
  ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
  ln -s ~/dotfiles/zsh/.zprofile ~/.zprofile

  ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
  ln -s ~/dotfiles/bash/.bash_profile ~/.bash_profile

  mkdir -p ~/.config
  ln -s ~/dotfiles/prompt/.zpreztorc ~/.zpreztorc
  ln -s ~/dotfiles/prompt/starship.toml ~/.config/starship.toml

  mkdir -p ~/.config/git
  ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
  ln -s ~/dotfiles/git/ignore ~/.config/git/ignore
fi

echo "COMPLETE: setup symbolic links"
echo ""


echo "----------------------------------------------------------------------"
echo "Successfully installed essential tools."
echo "Please run following command \"exec $SHELL -l\" to run zsh."

printf "\nOK\n"
