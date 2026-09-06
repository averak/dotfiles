#!/usr/bin/env bash

_DOTFILES_DIR=$(pwd)
. "$_DOTFILES_DIR"/etc/_utils.sh
. "$_DOTFILES_DIR"/etc/_symlink.sh

if ! _confirm "[Q] Are you sure you want to overwrite your dotfiles?"; then
	_log_warn "Symlinking canceled, nothing to do."
	exit 0
fi

mkdir -p "$_DOTFILES_DIR/tmp/backup" || exit 1
_BACKUP_DIR=$(mktemp -d "$_DOTFILES_DIR/tmp/backup/$(date "+%Y%m%d%H%M%S").XXXXXX") || exit 1

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
_symlink "$_DOTFILES_DIR"/config/starship/starship.toml "$HOME"/.config/starship.toml

# ghostty
_symlink "$_DOTFILES_DIR"/config/ghostty "$HOME"/.config/ghostty

# git
_symlink "$_DOTFILES_DIR"/config/git/.gitconfig "$HOME"/.gitconfig
_symlink "$_DOTFILES_DIR"/config/git/ignore "$HOME"/.config/git/ignore
_symlink "$_DOTFILES_DIR"/config/gitui "$HOME"/.config/gitui
_symlink "$_DOTFILES_DIR"/config/lazygit "$HOME"/.config/lazygit

# vim / neovim
_symlink "$_DOTFILES_DIR"/config/vim "$HOME"/.vim
_symlink "$_DOTFILES_DIR"/config/nvim "$HOME"/.config/nvim

# python
_symlink "$_DOTFILES_DIR"/config/python/flake8 "$HOME"/.config/flake8
_symlink "$_DOTFILES_DIR"/config/python/pep8 "$HOME"/.config/pep8
_symlink "$_DOTFILES_DIR"/config/python/mypy "$HOME"/.config/mypy

# jetbrains
_symlink "$_DOTFILES_DIR"/config/jetbrains/.ideavimrc "$HOME"/.ideavimrc

# karabiner
_symlink "$_DOTFILES_DIR"/config/karabiner "$HOME"/.config/karabiner

# zellij
_symlink "$_DOTFILES_DIR"/config/zellij "$HOME"/.config/zellij

# gemini-cli
_symlink "$_DOTFILES_DIR"/config/gemini/settings.json "$HOME"/.gemini/settings.json

# claude code
_symlink "$_DOTFILES_DIR"/config/claude/settings.json "$HOME"/.claude/settings.json
_symlink "$_DOTFILES_DIR"/config/claude/CLAUDE.md "$HOME"/.claude/CLAUDE.md

# codex
_symlink "$_DOTFILES_DIR"/config/codex/AGENTS.md "$HOME"/.codex/AGENTS.md

# shared agent skills
for _skill_dir in "$_DOTFILES_DIR"/config/skills/*; do
	[ -f "$_skill_dir/SKILL.md" ] || continue
	_skill_name=$(basename "$_skill_dir")
	_symlink "$_skill_dir" "$HOME/.claude/skills/$_skill_name" || exit 1
	_symlink "$_skill_dir" "$HOME/.agents/skills/$_skill_name" || exit 1
done

# xmodmap
_symlink "$_DOTFILES_DIR"/config/Xmodmap/.Xmodmap "$HOME"/.Xmodmap

# tmux
_symlink "$_DOTFILES_DIR"/config/tmux/.tmux.conf "$HOME"/.tmux.conf
_symlink "$_DOTFILES_DIR"/config/tmux/.tmux.conf.local "$HOME"/.tmux.conf.local
_symlink "$_DOTFILES_DIR"/config/tmux/.tmux "$HOME"/.tmux
