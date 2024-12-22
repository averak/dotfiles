# Dotfiles

[![](https://github.com/averak/dotfiles/workflows/build/badge.svg)](https://github.com/averak/dotfiles/actions)
[![](https://github.com/averak/dotfiles/workflows/vint/badge.svg)](https://github.com/averak/dotfiles/actions)

A collection of configuration files and setup scripts to quickly set up and maintain a development environment.

## Compatibility

- macOS
- Ubuntu
- Cent7

## Quick Start

First, clone this repository.

```sh
git clone git@github.com:averak/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
```

And then, install essential tools. (required sudo)

```sh
make install
```

Incidentally, `make install` will perform the following tasks.

- `make update` - update dotfiles
- `make deploy` - deploy dotfiles to your env
- `make init` - init some settings

If you want to know details, just execute `make help`.

### Change default shell

You need to add `zsh` to the list of available shells. (required sudo)

```sh
echo $(which zsh) >> /etc/shells
chsh -s $(which zsh) $USER
```
