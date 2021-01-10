#--------------------------------------------------------------#
##        set unicode                                         ##
#--------------------------------------------------------------#
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8

#--------------------------------------------------------------#
##        editor                                              ##
#--------------------------------------------------------------#
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#--------------------------------------------------------------#
##        PATH                                                ##
#--------------------------------------------------------------#
# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
# rust
export PATH="$HOME/.cargo/bin:$PATH"
# local bin
export PATH=~/.local/bin:$PATH
