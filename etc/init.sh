#!/usr/bin/env bash

DOTFILES_DIR=$HOME/dotfiles
. "$DOTFILES_DIR"/etc/header.sh

### Start install script
DOTFILES_GITHUB="https://github.com/averak/dotfiles"

printf "$BOLD"
echo   "
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

*** WHAT IS INSIDE? ***
1. Download my dotfiles from ${DOTFILES_GITHUB}
2. Symlinking dotfiles to your home directory
3. Install packages

*** HOW TO INSTALL? ***
See the README for documentation.
Licensed under the MIT license.
"
printf "$NORMAL"

log "*** ATTENTION ***"
log "This script can change your entire setup."
log "I recommend to read first. You can even copy commands one by one."
echo ""

if ! yesno "$(warn 'Are you sure you want to install?')"; then
  error 'Installation failed. Nothing changed.'
	exit 1
fi

#--------------------------------------------------------------#
##        packages                                            ##
#--------------------------------------------------------------#
echo ""
info "Start install packages."

OS=$($DOTFILES_DIR/bin/os)

if yesno "$(warn 'Are you sure you want to install packages?')"; then
	if [ "$(echo $OS | grep 'Darwin')" ] ; then
		# info "Start softwareupdate"
		# softwareupdate --install -a

		if ! has brew; then
			info "Homebrew is not installed!!"
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		fi

		info "Start install..."
		brew install git wget curl tmux coreutils autoconf automake cmake ninja libtool pkg-config gettext fontconfig jq lazygit vim neovim
		brew install --cask "google-cloud-sdk"

	elif [ "$(echo $OS | grep 'Ubuntu')" ] ; then
    info "apt update"
		sudo apt update

		info "Start install..."
		PACKAGES="git wget curl tmux coreutils make cmake unzip vim neovim"
		sudo apt install -y $PACKAGES

	elif [ "$(echo $OS | grep 'RedHat')" ] ; then
    info "yum update"
		sudo yum update

		info "Start install..."
		PACKAGES="git wget curl tmux coreutils make cmake unzip ncurses-devel gcc vim neovim"
		sudo yum install -y $PACKAGES

	else
	  error "Your platform ($(uname -a)) is not supported."
	  exit 1
	fi
fi

#--------------------------------------------------------------#
##        zsh                                                 ##
#--------------------------------------------------------------#
echo ""
info "Start install zsh."

if yesno "$(warn 'Are you sure you want to install zsh?')"; then
	ZSH_VERSION=5.8
  wget https://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.xz/download -O zsh-${ZSH_VERSION}.tar.xz
  tar xvf zsh-${ZSH_VERSION}.tar.xz

  cd zsh-${ZSH_VERSION}
  ./configure --enable-multibyte
  sudo make
  sudo make install

	cd $DOTFILES_DIR
  rm -rf zsh-${ZSH_VERSION}*
fi

#--------------------------------------------------------------#
##        fzf                                                 ##
#--------------------------------------------------------------#
echo ""
info "Start install fzf."


if [ ! -e $HOME/.fzf ]; then
  git clone https://github.com/junegunn/fzf $HOME/.fzf
  $HOME/.fzf/install
else
	info "The fzf is already installed!!"
fi

#--------------------------------------------------------------#
##        rust                                                ##
#--------------------------------------------------------------#
echo ""
info "Start install rust."

if [ ! -e $HOME/.cargo ]; then
  curl https://sh.rustup.rs -sSf | sh
else
	info "The rust is already installed!!"
fi

if yesno "$(warn 'Are you sure you want to install rust packages?')"; then
	PACKAGES="exa bat fd-find procs ripgrep starship zellij"
	$HOME/.cargo/bin/cargo install $PACKAGES
fi

#--------------------------------------------------------------#
##        anyenv                                              ##
#--------------------------------------------------------------#
echo ""
info "Start install anyenv."

if [ ! -e $HOME/.anyenv ]; then
  git clone https://github.com/anyenv/anyenv $HOME/.anyenv
  mkdir -p $HOME/.anyenv/plugins
  git clone https://github.com/znz/anyenv-update.git $HOME/.anyenv/plugins/anyenv-update
  $HOME/.anyenv/bin/anyenv install --init

	$HOME/.anyenv/bin/anyenv install jenv
	$HOME/.anyenv/envs/jenv/bin/jenv enable-plugin export
else
	info "The anyenv is already installed!!"
fi

log ""
log "--------------------------------------------------------------------"
info "Installation completed."
info "Please run following command \"exec \$SHELL\" to run zsh."
