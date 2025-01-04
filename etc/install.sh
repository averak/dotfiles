#!/usr/bin/env bash

#--------------------------------------------------------------#
##        utils                                               ##
#--------------------------------------------------------------#

_DOTFILES_DIR=$(pwd)
. "$_DOTFILES_DIR"/etc/_utils.sh

# os detection
_is_darwin() {
  [ "$(uname -s)" == "Darwin" ]
}
_is_debian() {
  [ -f /etc/debian_version ]
}
_is_redhat() {
  [ -f /etc/redhat-release ]
}

#--------------------------------------------------------------#
##        entrypoint                                          ##
#--------------------------------------------------------------#

echo "
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

*** WHAT IS INSIDE? ***
1. Download my dotfiles from https://github.com/averak/dotfiles.
2. Symlinking dotfiles to your home directory.
3. Install packages.

*** HOW TO INSTALL? ***
See the README for documentation.
Licensed under the MIT license.

*** ATTENTION ***
This script can change your entire setup.
I recommend to read first. You can even copy commands one by one.
"

if ! _confirm "[Q] Are you sure you want to run installation?"; then
  _log_warn "Installation canceled, nothing to do."
  exit 0
fi

#--------------------------------------------------------------#
##       essential packages                                   ##
#--------------------------------------------------------------#

if _confirm "[Q] Are you sure you want to install essential packages?"; then
  if _is_darwin; then
    if ! command -v brew &>/dev/null; then
      _log_info "Homebrew is not installed!!"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    _log_info "brew update"
    brew update

    _log_info "Start install..."
    brew install git wget curl tmux gcc coreutils autoconf automake cmake ninja libtool pkg-config gettext fontconfig usage jq luarocks lazygit vim neovim
    brew install --cask google-cloud-sdk ghostty font-jetbrains-mono karabiner-elements

  elif _is_debian; then
    _log_info "apt update"
    sudo apt update

    _log_info "Start install..."
    PACKAGES="git wget curl tmux coreutils libssl-dev pkg-config make cmake unzip vim neovim"
    sudo apt install -y "$PACKAGES"

  elif _is_redhat; then
    _log_info "yum update"
    sudo yum update

    _log_info "Start install..."
    PACKAGES="git wget curl tmux coreutils make cmake unzip ncurses-devel gcc vim neovim"
    sudo yum install -y "$PACKAGES"

  else
    _log_error "Your platform ($(uname -a)) is not supported."
    exit 1
  fi
fi

#--------------------------------------------------------------#
##        mise                                                ##
#--------------------------------------------------------------#

if _confirm "[Q] Are you sure you want to install mise?"; then
  _log_info "Install mise..."
  curl https://mise.run | sh

  _log_info "install tools with mise..."
  mise use -g rust@latest
  mise use -g starship@latest
  mise use -g zellij@latest
  mise use -g gitui@latest
fi

#--------------------------------------------------------------#
##        rust                                                ##
#--------------------------------------------------------------#

if _confirm "[Q] Are you sure you want to install rust packages?"; then
  "$HOME"/.cargo/bin/cargo install exa bat ripgrep sheldon
fi

#--------------------------------------------------------------#
##        footer                                              ##
#--------------------------------------------------------------#

_log_info "Installation completed."
_log_info "Please run following command \"exec \$SHELL\" to run shell."
