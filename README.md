# Dotfiles

A collection of configuration files and setup scripts to quickly set up and maintain a development environment.

## Compatibility

- macOS
- Ubuntu
- Cent7

## Quick Start

First, clone this repository.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/averak/dotfiles/master/install.sh)"
```

Incidentally, this script will perform the following tasks.

- `make install` - install essential tools
- `make symlink` - create symbolic links for dotfiles

If you want to know details, just execute `make help` in the repository.

### Change default shell

You need to add `zsh` to the list of available shells. (required sudo)

```sh
echo $(which zsh) >> /etc/shells
chsh -s $(which zsh) $USER
```

### Local configuration

If you want to customize the configuration, you can add .sh files to the [./local](./local) directory.

## Tools

Configuration files for tools that are no longer in use are still retained.

The tools that are actually used are as follows.

| Tool                                                        | configuration                            | Category             |
|-------------------------------------------------------------|------------------------------------------|----------------------|
| [zsh](https://github.com/zsh-users/zsh)                     | [./config/zsh](./config/zsh)             | Shell                |
| [sheldon](https://github.com/rossmacarthur/sheldon)         | [./config/sheldon](./config/sheldon)     | Shell Plugin Manager |
| [neovim](https://github.com/neovim/neovim)                  | [./config/nvim](./config/nvim)           | Text Editor          |
| [zellij](https://github.com/zellij-org/zellij)              | [./config/zellij](./config/zellij)       | Terminal Multiplexer |
| [ghostty](https://github.com/ghostty-org/ghostty)           | [./config/ghostty](./config/ghostty)     | Terminal Emulator    |
| [lazygit](https://github.com/jesseduffield/lazygit)         | [./config/lazygit](./config/lazygit)     | Git Terminal UI      |
| [gitui](https://github.com/extrawurst/gitui)                | [./config/gitui](./config/gitui)         | Git Terminal UI      |
| [karabiner](https://github.com/pqrs-org/Karabiner-Elements) | [./config/karabiner](./config/karabiner) | Keyboard Customizer  |
