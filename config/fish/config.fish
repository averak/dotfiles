#     _____      __
#    / __(_)____/ /_
#   / /_/ / ___/ __ \
#  / __/ (__  ) / / /
# /_/ /_/____/_/ /_/


#--------------------------------------------------------------#
##        source starship                                     ##
#--------------------------------------------------------------#
starship init fish | source
set -x BASH_SILENCE_DEPRECATION_WARNING 1

#--------------------------------------------------------------#
##        source each PC settings                             ##
#--------------------------------------------------------------#
[ -f ~/dotfiles/local/local.conf ] && source ~/dotfiles/local/local.conf

#--------------------------------------------------------------#
##        set 256color                                        ##
#--------------------------------------------------------------#
set -x TERM xterm-256color

#--------------------------------------------------------------#
##        fzf settings                                        ##
#--------------------------------------------------------------#
set -x PATH $PATH:$HOME/.fzf/bin
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git"'
set -x FZF_DEFAULT_OPTS '--preview "bat --theme=TwoDark --style=numbers --color=always --line-range :500 {}"'
set -x FZF_DEFAULT_OPTS '--height 40% --reverse --preview "bat --theme=TwoDark --style=numbers --color=always --line-range :200 {}"'

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
