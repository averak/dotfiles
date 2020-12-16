#!/usr/bin/env sh

cd ~

#--------------------------------------------------------------#
##        clone dotfiles                                      ##
#--------------------------------------------------------------#
echo 'start: git clone dotfiles'

if [ ! -e ~/dotfiles ]; then
  git clone https://github.com/averak/dotfiles ~/dotfiles
  cd ~/dotfiles
fi

echo 'complete: git clone dotfiles'
echo ''

#--------------------------------------------------------------#
##        clean setting files                                 ##
#--------------------------------------------------------------#
echo 'start: clean setting files'

[ -e ~/.zshrc ] && rm ~/.zshrc
[ -e ~/.zprofile ] && rm ~/.zprofile
[ -e ~/.bashrc ] && rm ~/.bashrc
[ -e ~/.bash_profile ] && rm ~/.bash_profile
[ -e ~/.config/starship.toml ] && rm ~/.config/starship.toml
[ -e ~/.zpreztorc ] && rm ~/.zpreztorc
[ -e ~/.gitconfig ] && rm ~/.gitconfig
[ -e ~/.config/git/ignore ] && rm ~/.config/git/ignore

echo 'complete: clean setting files'
echo ''

#--------------------------------------------------------------#
##        install packages                                    ##
#--------------------------------------------------------------#
echo 'start: install packages'

packages="git wget openssl autoconf automake cmake ninja libtool pkg-config gettext fontconfig"
installed_packages=$(brew list --formula)
install_packages=""

for pkg in ${packages}; do
  printf "check ${pkg}..."
  if echo "${installed_packages}" | grep -xq ${pkg}; then
    printf "\e[32mOK\e[0m\n"
  else
    printf "\e[31mNot installed\e[0m\n"
    install_packages="${install_packages} ${pkg}"
  fi
done

echo ""
brew install ${install_packages}

echo 'complete: install packages'

#--------------------------------------------------------------#
##        install zsh                                         ##
#--------------------------------------------------------------#
echo 'start: install zsh'

ZSH_VERSION=5.8
if [ ! -e /usr/local/bin/zsh ]; then
  wget https://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSUIONS}/zsh-${ZSH_VERSUIONS}.tar.xz/download -O zsh-${ZSH_VERSUIONS}.tar.xz
  tar xvf zsh-${ZSH_VERSUIONS}.tar.xz
  ./configure --enable-multibyte
  sudo make
  sudo make install
  cd ~/dotfiles
  rm -rf zsh-${ZSH_VERSUIONS}*
fi

# install zprezto
if [ ! -e ~/.zprezto ];then
  git clone https://github.com/sorin-ionescu/prezto ~/.zprezto
fi

echo 'complete: install zsh'

#--------------------------------------------------------------#
##        install fzf                                         ##
#--------------------------------------------------------------#
echo 'start: install fzf'

if [ ! -e ~/.fzf ];then
  git clone https://github.com/junegunn/fzf ~/.fzf
  cd ~/.fzf && ./install --key-bindings --no-completion --no-update-rc
  cd ~/dotfiles
fi

echo 'complete: install fzf'

#--------------------------------------------------------------#
##        install rust                                        ##
#--------------------------------------------------------------#
# install rust
if [ ! -e ~/.cargo ];then
  curl https://sh.rustup.rs -sSf | sh
fi

# install rust packages
if [ -e ~/.cargo/bin/cargo ];then
  packages="exa bat hexyl fd-find procs ripgrep"
  for pkg in ${packages}; do
    if [ ! -e ~/.cargo/bin/${pkg} ];then
      ~/.cargo/bin/cargo install ${pkg}
    fi
  done
fi

#--------------------------------------------------------------#
##        set symbolic links                                  ##
#--------------------------------------------------------------#
echo 'start: setup symbolic links'

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

echo 'complete: setup symbolic links'
