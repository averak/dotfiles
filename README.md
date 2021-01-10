# Dotfiles

[![](https://github.com/averak/dotfiles/workflows/macos/badge.svg)](https://github.com/averak/dotfiles/actions)
[![](https://github.com/averak/dotfiles/workflows/ubuntu/badge.svg)](https://github.com/averak/dotfiles/actions)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE.txt)

## Requirements

- macOS
- Ubuntu
- Cent7

## Usage

### Install

```sh
# install essential tools (required sudo)
$ /bin/bash -c "$(curl -sS https://raw.githubusercontent.com/averak/dotfiles/master/setup.sh)"
```

### Build Vim & Neovim

```sh
$ ./scripts/vim_build.sh
```

### Change Default Shell

```sh
# add zsh to the list of available shells (required sudo)
$ echo $(which zsh) >> /etc/shells
$ chsh -s $(which zsh)
```
