Dotfiles
========

[![build](https://github.com/AjxLab/dotfiles/workflows/build/badge.svg)](https://github.com/AjxLab/dotfiles/actions)

![](./img/terminal.png)


## Environments
- MacOS
- CentOS 7
- Ubuntu


## Setup
1. Setup dotfiles and install software as follow
```sh
# clone this repository
$ git clone https://github.com/AjxLab/dotfiles
$ cd dotfiles
```
2. Install Nerd Fonts
```sh
$ ./scripts/fonts-install.sh
```
3. Change Default Shell
```sh
# add zsh to the list of available shells (required sudo)
$ echo $(which zsh) >> /etc/shells
$ chsh -s $(which zsh)
```
### Install
```sh
# install essential tools (required sudo)
$ ./scripts/install.sh
```
### Build Latest Vim/Neovim
```sh
$ ./scripts/vim-build.sh
```
