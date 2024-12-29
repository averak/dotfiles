#!/usr/bin/env bash

_DOTFILES_DIR=$HOME/dotfiles

if [ ! -d "$_DOTFILES_DIR" ]; then
  git clone git@github.com:averak/dotfiles.git "$_DOTFILES_DIR"
  cd "$_DOTFILES_DIR" || exit
  make
else
  cd "$_DOTFILES_DIR" || exit
  git switch master
  git pull
  make
fi
