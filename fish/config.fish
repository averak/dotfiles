#     _____      __
#    / __(_)____/ /_
#   / /_/ / ___/ __ \
#  / __/ (__  ) / / /
# /_/ /_/____/_/ /_/


# --------------------------------------------------
#  Source Starship
# --------------------------------------------------

starship init fish | source
set -x BASH_SILENCE_DEPRECATION_WARNING 1

# --------------------------------------------------
#  vcs_info
# --------------------------------------------------

# デフォルトエディタをVimに設定
set -x EDITOR vim
set -x VISUAL vim
set -x PAGER less


# --------------------------------------------------
#  PATH
# --------------------------------------------------

# Python
set -x PATH $HOME/.pyenv/bin $PATH
set -x PATH $HOME/.pyenv/shims $PATH

# Ruby
set -x PATH $HOME/.rbenv/bin $PATH
set -x PATH $HOME/.rbenv/shims $PATH

# PHP
set -x PATH $HOME/.phpenv/bin $PATH
set -x PATH $HOME/.phpenv/shims $PATH

# Perl
set -x PATH $HOME/.plenv/bin $PATH
set -x PATH $HOME/.plenv/shims $PATH

# Rust
set -x PATH $HOME/.cargo/bin $PATH

# Node.js
set -x PATH $HOME/.nodenv/bin $PATH

# Laravel
set -x PATH $HOME/.composer/vendor/bin $PATH

# Clangd
set -x PATH /usr/local/opt/llvm/bin $PATH

pyenv init - | source
rbenv init - | source
plenv init - | source
nodenv init - | source


# --------------------------------------------------
#  エイリアス
# --------------------------------------------------

# ls
alias l='exa --icons'
alias ls='l'
alias la='l -a'
alias ll='l -l'
alias l1='l -1'
alias sl='/usr/local/bin/sl'

# vi to vim
alias vi='vim'

# Jupyter Notebook
alias jn='jupyter notebook'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias c='clear'

alias :q="exit"

# ファイルを開く
alias cot="open -a CotEditor"
alias edit="open -a textedit"

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '


# --------------------------------------------------
#  git エイリアス
# --------------------------------------------------

alias g="git"

alias gs='git status --short --branch'
alias ga='git add -A'
alias gc='git commit -m'
alias gps='git push'
alias gpsu='git push -u origin'
alias gp='git pull origin'
alias gf='git fetch'
alias gfp='git fetch -p'

# logを見やすく
alias gl='git log --abbrev-commit --no-merges --date=short --date=iso'
# grep
alias glg='git log --abbrev-commit --no-merges --date=short --date=iso --grep'
# ローカルコミットを表示
alias glc='git log --abbrev-commit --no-merges --date=short --date=iso origin/html..html'

alias gd='git diff'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gbr='git branch -r'

alias gm='git merge'
alias gr='git reset'

