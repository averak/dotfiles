Dotfiles
========

My dotfiles
![](./img/terminal.png)


## Environments
- CentOS 7
- Ubuntu 16.04 and 18.04


## Setup
1. Setup dotfiles and install software as follow
```sh
# clone this repository
$ git clone https://github.com/AjxLab/dotfiles
$ cd dotfiles
```
2. Install Nerd Fonts
```sh
$ sh fonts/install.sh
```
3. Change Default Shell
```sh
# add zsh to the list of available shells (required sudo)
$ echo $(which zsh) >> /etc/shells
$ chsh -s $(which zsh)
```
### Linux
```sh
# install essential tools (required sudo)
$ ./install.sh
```
### MacOS
```sh
# install essential tools (required sudo)
$ ./macos/install.sh
$ ./install.sh
```
### Build Latest Vim/Neovim
```sh
$ ./vim-build.sh
```
