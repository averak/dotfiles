# Dotfiles

[![](https://github.com/averak/dotfiles/workflows/ubuntu/badge.svg)](https://github.com/averak/dotfiles/actions)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE.txt)

## Requirements

- macOS
- Ubuntu
- Cent7

## Usage

First, clone this repository.

```sh
$ git clone --recursive https://github.com/averak/dotfiles ~/dotfiles
$ cd ~/dotfiles
```

### Setup

Install essential tools. (required sudo)

```sh
$ make install
```

Incidentally, `make install` will perform the following tasks.

- `make update` - update dotfiles
- `make deploy` - deploy dotfiles to your env
- `make init` - init some settings

If you want to know details, just execute `make help`.

### Change default shell

You need to add `zsh` to the list of available shells. (required sudo)

```sh
$ echo $(which zsh) >> /etc/shells
$ chsh -s $(which zsh) ${USER}
```

### Install latest vim & neovim

You can install there with `make install`, but if you want to update to the latest version, execute the following.

```sh
$ ./bin/install-vim
```
