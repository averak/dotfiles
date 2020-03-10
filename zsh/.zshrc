#               __
#   ____  _____/ /_  __________
#  /_  / / ___/ __ \/ ___/ ___/
#   / /_(__  ) / / / /  / /__
#  /___/____/_/ /_/_/   \___/


# --------------------------------------------------
#  Source Prezto
# --------------------------------------------------

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


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
PATH=$HOME/.phpenv/bin:$PATH
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


# --------------------------------------------------
#  オプション
# --------------------------------------------------

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob


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

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
     alias -g C='| putclip'
fi


# --------------------------------------------------
#  gitコマンド補完機能セット
# --------------------------------------------------

# autoloadの文より前に記述
fpath=(~/.zsh/completion $fpath)


# --------------------------------------------------
#  コマンド入力補完
# --------------------------------------------------

# 補完機能有効にする
autoload -U compinit
compinit -u

# 補完候補に色つける
autoload -U colors
colors

# 単語の入力途中でもTab補完を有効化
setopt complete_in_word
# 補完リストの表示間隔を狭くする
setopt list_packed

# コマンドの打ち間違いを指摘してくれる
setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "


# --------------------------------------------------
#  $ tree でディレクトリ構成表示
# --------------------------------------------------

alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/| /g'"



# --------------------------------------------------
#  git エイリアス
# --------------------------------------------------

alias g="git"
compdef g=git

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

