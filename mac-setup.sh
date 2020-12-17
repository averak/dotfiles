#!/usr/bin/env sh

cd ~

#--------------------------------------------------------------#
##        clone dotfiles                                      ##
#--------------------------------------------------------------#
echo "start: git clone dotfiles"

if [ ! -e ~/dotfiles ]; then
  git clone https://github.com/averak/dotfiles ~/dotfiles
fi
cd ~/dotfiles

ask_exec=~/dotfiles/scripts/ask_exec.sh
installer=~/dotfiles/scripts/installer.sh

echo "complete: git clone dotfiles"
echo ""

#--------------------------------------------------------------#
##        install packages                                    ##
#--------------------------------------------------------------#
echo "start: install packages"

packages="git wget openssl autoconf automake cmake ninja libtool pkg-config gettext fontconfig"
installed_packages=$(brew list --formula)
${installer} "brew install" "${packages}" "${installed_packages}"

echo "complete: install packages"
echo ""

#--------------------------------------------------------------#
##        install zsh                                         ##
#--------------------------------------------------------------#
echo "start: install zsh"

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

echo "complete: install zsh"
echo ""

#--------------------------------------------------------------#
##        install fzf                                         ##
#--------------------------------------------------------------#
echo "start: install fzf"

if [ ! -e ~/.fzf ];then
  git clone https://github.com/junegunn/fzf ~/.fzf
  cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc
  cd ~/dotfiles
fi

echo "complete: install fzf"
echo ""

#--------------------------------------------------------------#
##        install rust packages                               ##
#--------------------------------------------------------------#
echo "start: install rust packages"

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

echo "complete: install rust packages"
echo ""

#--------------------------------------------------------------#
##        install anyenv                                      ##
#--------------------------------------------------------------#
echo "start: install anyenv"

git clone https://github.com/anyenv/anyenv ~/.anyenv
mkdir -p ~/.anyenv/plugins
git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update

echo "complete: install anyenv"
echo ""

#--------------------------------------------------------------#
##        clean setting files                                 ##
#--------------------------------------------------------------#
echo "start: clean setting files"

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

echo "complete: clean setting files"
echo ""

#--------------------------------------------------------------#
##        set symbolic links                                  ##
#--------------------------------------------------------------#
echo "start: setup symbolic links"

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

echo "complete: setup symbolic links"
echo ""


echo "----------------------------------------------------------------------"
echo "Successfully installed essential tools."
echo "Please run following command \"exec $SHELL -l\" to run zsh."

printf "\nOK\n"
