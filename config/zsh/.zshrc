#               __
#   ____  _____/ /_  __________
#  /_  / / ___/ __ \/ ___/ ___/
#   / /_(__  ) / / / /  / /__
#  /___/____/_/ /_/_/   \___/


#--------------------------------------------------------------#
##        source zprezto                                      ##
#--------------------------------------------------------------#
[[ -f ~/.zprezto/init.zsh ]] && source ~/.zprezto/init.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

#--------------------------------------------------------------#
##        source each PC settings                             ##
#--------------------------------------------------------------#
[ -f ~/dotfiles/local/local.conf ] && source ~/dotfiles/local/local.conf

#--------------------------------------------------------------#
##        set 256color                                        ##
#--------------------------------------------------------------#
TERM=xterm-256color

#--------------------------------------------------------------#
##        zsh options                                         ##
#--------------------------------------------------------------#
# zsh補完
autoload -U compinit && compinit
# カラー設定
autoload -Uz colors && colors
#単語の入力途中でもTab補完を有効化
setopt complete_in_word
# 補完候補をハイライト
zstyle ':completion:*:default' menu select=1
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
#大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# Ctrl+Dでzshを終了しない
setopt ignore_eof
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 補完リストの表示間隔を狭くする
setopt list_packed
# cdなしでディレクトリを移動
setopt auto_cd
# cdでディレクトリの移動履歴表示
setopt auto_pushd
# コマンドのうち間違え防止
setopt correct

#--------------------------------------------------------------#
##        fzf settings                                        ##
#--------------------------------------------------------------#
export PATH=$PATH:$HOME/.fzf/bin
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --preview "bat --theme=TwoDark --style=numbers --color=always --line-range :200 {}"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#--------------------------------------------------------------#
##        alias                                               ##
#--------------------------------------------------------------#
alias l='exa --icons'
alias ls='l'
alias la='l -a'
alias ll='l -l'
alias sl='ls'
alias dc='cd'
alias c='clear'
alias -g L='| less'
alias -g G='| grep'
# editor
alias vi='vim'
alias cot="open -a CotEditor"
alias edit="open -a textedit"
# git
alias gs='git status --short --branch'
alias gg='git graph'
alias ga='git add -A'
alias gc='git commit -m'
alias gps='git push'
alias gp='git pull'
alias gf='git fetch'
alias gm='git merge'
alias gr='git reset'
alias gd='git diff'
alias gco='git checkout'
alias gsw='git switch'
alias gb='git branch'
alias lg='lazygit'
# clipboard
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
