#!/usr/bin/env bash

DOTFILES_DIR=$(pwd)
. $DOTFILES_DIR/etc/header.sh

echo ""
info "Creating symbolic link..."

if [ ! -e "$HOME/.local/bin" ]; then
  mkdir -p $HOME/.local/bin
fi

#--------------------------------------------------------------#
##        bash                                                ##
#--------------------------------------------------------------#
echo ""
info "bash"

symlink $DOTFILES_DIR/config/bash/.bashrc $HOME/.bashrc
symlink $DOTFILES_DIR/config/bash/.bash_profile $HOME/.bash_profile

#--------------------------------------------------------------#
##        zsh                                                 ##
#--------------------------------------------------------------#
echo ""
info "zsh"

symlink $DOTFILES_DIR/config/zsh/.zshrc $HOME/.zshrc
symlink $DOTFILES_DIR/config/zsh/.zshenv $HOME/.zshenv
symlink $DOTFILES_DIR/config/zsh/.zprofile $HOME/.zprofile

#--------------------------------------------------------------#
##        sheldon                                             ##
#--------------------------------------------------------------#
echo ""
info "sheldon"

symlink $DOTFILES_DIR/config/sheldon $HOME/.config/sheldon

#--------------------------------------------------------------#
##        prompt                                              ##
#--------------------------------------------------------------#
echo ""
info "prompt"

symlink $DOTFILES_DIR/config/prompt/starship.toml $HOME/.config/starship.toml

#--------------------------------------------------------------#
##        git                                                 ##
#--------------------------------------------------------------#
echo ""
info "git"

mkdir -p $HOME/.config/git
mkdir -p ~/.config/jesseduffield
symlink $DOTFILES_DIR/config/git/.gitconfig $HOME/.gitconfig
symlink $DOTFILES_DIR/config/git/ignore $HOME/.config/git/ignore
symlink $DOTFILES_DIR/config/lazygit $HOME/.config/jesseduffield/lazygit

#--------------------------------------------------------------#
##        python                                              ##
#--------------------------------------------------------------#
echo ""
info "python"

symlink $DOTFILES_DIR/config/python/flake8 $HOME/.config/flake8
symlink $DOTFILES_DIR/config/python/pep8 $HOME/.config/pep8
symlink $DOTFILES_DIR/config/python/mypy $HOME/.config/mypy

#--------------------------------------------------------------#
##        vim/neovim                                          ##
#--------------------------------------------------------------#
echo ""
info "vim/neovim"

symlink $DOTFILES_DIR/config/vim $HOME/.vim
symlink $DOTFILES_DIR/config/nvim $HOME/.config/nvim

#--------------------------------------------------------------#
##        JetBrains                                           ##
#--------------------------------------------------------------#
echo ""
info "jetbrains"

symlink $DOTFILES_DIR/config/idea/.ideavimrc $HOME/.ideavimrc

#--------------------------------------------------------------#
##        karabiner                                           ##
#--------------------------------------------------------------#
echo ""
info "karabiner"

symlink $DOTFILES_DIR/config/karabiner $HOME/.config/karabiner

#--------------------------------------------------------------#
##        Zellij                                              ##
#--------------------------------------------------------------#
echo ""
info "zellij"

symlink $DOTFILES_DIR/config/zellij $HOME/.config/zellij

#--------------------------------------------------------------#
##        Xmodmap                                          ##
#--------------------------------------------------------------#
echo ""
info "Xmodmap"

symlink $DOTFILES_DIR/config/Xmodmap/.Xmodmap $HOME/.Xmodmap

#--------------------------------------------------------------#
##        tmux                                                ##
#--------------------------------------------------------------#
echo ""
info "tmux"

symlink $DOTFILES_DIR/config/tmux/.tmux.conf $HOME/.tmux.conf
symlink $DOTFILES_DIR/config/tmux/.tmux.conf.local $HOME/.tmux.conf.local
symlink $DOTFILES_DIR/config/tmux/.tmux $HOME/.tmux

if [ ! -e $HOME/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  if [ -e $HOME/.tmux/plugins/tpm/bin/install_plugins ]; then
    $HOME/.tmux/plugins/tpm/bin/install_plugins
  fi
fi
