# Dotfiles

![CI](https://github.com/averak/dotfiles/workflows/CI/badge.svg)

A collection of configuration files and setup scripts to quickly set up and maintain a development environment.

## Compatibility

- macOS
- Ubuntu
- Cent7

## Quick Start

First, clone this repository.

```shell
git clone git@github.com:averak/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
```

And then, install essential tools. (required sudo)

```shell
make
```

Incidentally, `make` will perform the following tasks.

- `make install` - install essential tools
- `make symlink` - create symbolic links for dotfiles

If you want to know details, just execute `make help`.

### Change default shell

You need to add `zsh` to the list of available shells. (required sudo)

```sh
echo $(which zsh) >> /etc/shells
chsh -s $(which zsh) $USER
```

### Customize

If you want to customize the configuration, you can add .sh files to the [./local](./local) directory.
