export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

export TERM=xterm-256color

export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:$HOME/dotfiles/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.anyenv/bin:$PATH
export PATH=$PATH:$HOME/.fzf/bin

export DOTFILES_DIR=$HOME/dotfiles
for file in "$DOTFILES_DIR/local/"*.sh; do
    source "$file"
done
