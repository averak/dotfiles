#!/usr/bin/env bash

_DOTFILES_DIR=$(pwd)
. "$_DOTFILES_DIR"/etc/_utils.sh

if ! _confirm "[Q] Are you sure you want to overwrite your dotfiles?"; then
  _log_warn "Symlinking canceled, nothing to do."
  exit 0
fi

_BACKUP_DIR=$_DOTFILES_DIR/tmp/backup/$(date "+%Y%m%d%H%M%S")
if [ -e "$_BACKUP_DIR" ]; then
  rm -rf "$_BACKUP_DIR"
else
  mkdir -p "$_BACKUP_DIR"
fi

_symlink() {
  _source=$1
  _target=$2

  if [ -e "$_target" ]; then
    _log_info "backup \"$_target\" to \"$_BACKUP_DIR/$(basename "$_target")\""
    mv -f "$_target" "$_BACKUP_DIR/$(basename "$_target")"
  fi

  _dir=$(dirname "$_target")
  if [ ! -e "$_dir" ]; then
    mkdir -p "$_dir"
  fi

  _log_info "ln -sf \"$_source\" \"$_target\""
  ln -sf "$_source" "$_target"
}

# bash
_symlink "$_DOTFILES_DIR"/config/bash/.bashrc "$HOME"/.bashrc
_symlink "$_DOTFILES_DIR"/config/bash/.bash_profile "$HOME"/.bash_profile

# zsh
_symlink "$_DOTFILES_DIR"/config/zsh/.zshrc "$HOME"/.zshrc
_symlink "$_DOTFILES_DIR"/config/zsh/.zshenv "$HOME"/.zshenv
_symlink "$_DOTFILES_DIR"/config/zsh/.zprofile "$HOME"/.zprofile

# sheldon
_symlink "$_DOTFILES_DIR"/config/sheldon "$HOME"/.config/sheldon

# prompt
_symlink "$_DOTFILES_DIR"/config/prompt/starship.toml "$HOME"/.config/starship.toml

# git
_symlink "$_DOTFILES_DIR"/config/git/.gitconfig "$HOME"/.gitconfig
_symlink "$_DOTFILES_DIR"/config/git/ignore "$HOME"/.config/git/ignore
_symlink "$_DOTFILES_DIR"/config/lazygit "$HOME"/.config/lazygit

# vim / neovim
_symlink "$_DOTFILES_DIR"/config/vim "$HOME"/.vim
_symlink "$_DOTFILES_DIR"/config/nvim "$HOME"/.config/nvim

# python
_symlink "$_DOTFILES_DIR"/config/python/flake8 "$HOME"/.config/flake8
_symlink "$_DOTFILES_DIR"/config/python/pep8 "$HOME"/.config/pep8
_symlink "$_DOTFILES_DIR"/config/python/mypy "$HOME"/.config/mypy

# jetbrains
_symlink "$_DOTFILES_DIR"/config/jetbrains/ideavimrc "$HOME"/.ideavimrc

# karabiner
_symlink "$_DOTFILES_DIR"/config/karabiner "$HOME"/.config/karabiner

# zellij
_symlink "$_DOTFILES_DIR"/config/zellij "$HOME"/.config/zellij

# xmodmap
_symlink "$_DOTFILES_DIR"/config/xmodmap "$HOME"/.Xmodmap

# tmux
_symlink "$_DOTFILES_DIR"/config/tmux/.tmux.conf "$HOME"/.tmux.conf
_symlink "$_DOTFILES_DIR"/config/tmux/.tmux.conf.local "$HOME"/.tmux.conf.local
_symlink "$_DOTFILES_DIR"/config/tmux/.tmux "$HOME"/.tmux
