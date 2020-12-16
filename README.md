# Dotfiles

[![](https://github.com/averak/dotfiles/workflows/macos/badge.svg)](https://github.com/averak/dotfiles/actions)
[![](https://github.com/averak/dotfiles/workflows/ubuntu/badge.svg)](https://github.com/averak/dotfiles/actions)

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

## Usage

### Install

```sh
# install essential tools (required sudo)
$ ./scripts/install.sh
```

### Build Latest Vim/Neovim

```sh
$ ./scripts/vim-build.sh
```
