#--------------------------------------------------------------#
##        set unicode                                         ##
#--------------------------------------------------------------#
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

#--------------------------------------------------------------#
##        editor                                              ##
#--------------------------------------------------------------#
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#--------------------------------------------------------------#
##        PATH                                                ##
#--------------------------------------------------------------#
# pyenv
export PYENV_ROOT=$HOME/.anyenv/envs/pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init --path)"
# anyenv
export PATH=$PATH:$HOME/.anyenv/bin:$PATH
eval "$(anyenv init -)"
# rust
export PATH=$PATH:$HOME/.cargo/bin
# java
export JAVA_HOME="$HOME/.anyenv/envs/jenv/versions/`jenv version-name`"
# local bin
export PATH=$PATH:$HOME/.local/bin
# dotfiles bin
export PATH=$PATH:$HOME/dotfiles/bin
# homebrew
export PATH=$PATH:/opt/homebrew/bin
