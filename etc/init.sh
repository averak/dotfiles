#!/usr/bin/env bash

DOTFILES_DIR=$(pwd)
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
		brew install git wget curl tmux coreutils autoconf automake cmake ninja libtool pkg-config gettext fontconfig usage jq lazygit vim neovim
		brew install --cask google-cloud-sdk

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
##        mise                                                ##
#--------------------------------------------------------------#
echo ""
info "Start install mise."

# if mise command not found
if ! has mise; then
  curl https://mise.run | sh
  mise use -g fzf@latest
  mise use -g rust@latest
  mise use -g sheldon@latest
  mise use -g starship@latest
  mise use -g zellij@latest
else
  info "The mise is already installed!!"
fi

#--------------------------------------------------------------#
##        rust                                                ##
#--------------------------------------------------------------#
echo ""
info "Start install rust packages."

if yesno "$(warn 'Are you sure you want to install rust packages?')"; then
	$HOME/.cargo/bin/cargo install exa
fi

log ""
log "--------------------------------------------------------------------"
info "Installation completed."
info "Please run following command \"exec \$SHELL\" to run zsh."
