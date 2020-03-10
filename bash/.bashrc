#      __               __
#     / /_  ____ ______/ /_
#    / __ \/ __ `/ ___/ __ \
#   / /_/ / /_/ (__  ) / / /
#  /_.___/\__,_/____/_/ /_/


# --------------------------------------------------
#  Source Starship
# --------------------------------------------------

eval "$(starship init bash)"
export BASH_SILENCE_DEPRECATION_WARNING=1


# --------------------------------------------------
#  vcs_info
# --------------------------------------------------

# デフォルトエディタをVimに設定
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'


# --------------------------------------------------
#  PATH
# --------------------------------------------------

# Python
PATH=$HOME/.pyenv/bin:$PATH
PATH=$HOME/.pyenv/shims:$PATH

# Ruby
PATH=$HOME/.rbenv/bin:$PATH
PATH=$HOME/.rbenv/shims:$PATH

# PHP
PATH=$OME/.phpenv/bin:$PATH
PATH=$HOME/.phpenv/shims:$PATH

# Perl
PATH=$HOME/.plenv/bin:$PATH
PATH=$HOME/.plenv/shims:$PATH

# Rust
PATH=$HOME/.cargo/bin:$PATH

# Node.js
PATH=$HOME/.nodenv/bin:$PATH

# Laravel
PATH=$HOME/.composer/vendor/bin:$PATH

# Brainfuck
PATH=$HOME/.bf/bin:$PATH

# Clangd
PATH=/usr/local/opt/llvm/bin:$PATH

export PATH

eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(phpenv init -)"
eval "$(plenv init -)"
eval "$(nodenv init -)"



# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=$PATH:$HOME/.nodebrew/current/bin

export PATH="$HOME/.cargo/bin:$PATH"



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

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
     alias C='| putclip'
fi


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

