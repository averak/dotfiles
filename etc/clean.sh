#!/usr/bin/env bash

dotfiles=$(pwd)
. $dotfiles/etc/header.sh

echo ""
info "Clean config files..."

if ! yesno "$(warn 'Are you sure you want to cleanup?')"; then
  info "Skip cleanup"
  exit 0
fi

tmp=$dotfiles/tmp
if [ -e $tmp ]; then
  rm -rf $tmp
fi
mkdir -p $tmp

clean() {
  if [ -e $1 ]; then
    log "mv $1 $tmp"
    mv -f $1 $tmp
  fi
}

#--------------------------------------------------------------#
##        bash                                                ##
#--------------------------------------------------------------#
echo ""
info "bash"

clean $HOME/.bashrc
clean $HOME/.bash_profile

#--------------------------------------------------------------#
##        zsh                                                 ##
#--------------------------------------------------------------#
echo ""
info "zsh"

clean $HOME/.zshrc
clean $HOME/.zshenv
clean $HOME/.zprofile

#--------------------------------------------------------------#
##        sheldon                                             ##
#--------------------------------------------------------------#
echo ""
info "sheldon"

clean $HOME/.config/sheldon

#--------------------------------------------------------------#
##        prompt                                              ##
#--------------------------------------------------------------#
echo ""
info "prompt"

clean $HOME/.config/starship.toml

#--------------------------------------------------------------#
##        git                                                 ##
#--------------------------------------------------------------#
echo ""
info "git"

clean $HOME/.gitconfig
clean $HOME/.config/git
clean $HOME/.config/lazygit

#--------------------------------------------------------------#
##        python                                              ##
#--------------------------------------------------------------#
echo ""
info "python"

clean $HOME/.config/flake8
clean $HOME/.config/pep8
clean $HOME/.config/mypy

#--------------------------------------------------------------#
##        vim/neovim                                          ##
#--------------------------------------------------------------#
echo ""
info "vim/neovim"

clean $HOME/.vim
clean $HOME/.config/nvim

#--------------------------------------------------------------#
##        JetBrains                                           ##
#--------------------------------------------------------------#
echo ""
info "jetbrains"

clean $HOME/.ideavimrc

#--------------------------------------------------------------#
##        Karabiner                                           ##
#--------------------------------------------------------------#
echo ""
info "karabiner"

clean $HOME/.config/karabiner

#--------------------------------------------------------------#
##        Zellij                                              ##
#--------------------------------------------------------------#
echo ""
info "zellij"

clean $HOME/.config/zellij

#--------------------------------------------------------------#
##        Xmodmap                                          ##
#--------------------------------------------------------------#
echo ""
info "Xmodmap"

clean $HOME/.Xmodmap

#--------------------------------------------------------------#
##        tmux                                                ##
#--------------------------------------------------------------#
echo ""
info "tmux"

clean $HOME/.tmux.conf
clean $HOME/.tmux.conf.local
clean $HOME/.tmux
