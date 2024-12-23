eval "$(starship init bash)"
export BASH_SILENCE_DEPRECATION_WARNING=1

#--------------------------------------------------------------#
##        any tools                                           ##
#--------------------------------------------------------------#

if [[ -x "$(command -v mise)" ]]; then
    eval "$(mise activate zsh)"
fi;

if [[ -x "$(command -v gcloud)" ]]; then
    GCLOUD_SDK_PATH=$(gcloud info --format="value(installation.sdk_root)")
    source "$GCLOUD_SDK_PATH/path.zsh.inc"
fi;

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --preview "bat --theme=TwoDark --style=numbers --color=always --line-range :200 {}"'

#--------------------------------------------------------------#
##        aliases                                             ##
#--------------------------------------------------------------#

if [[ -x "$(command -v exa)" ]]; then
    alias ls='exa'
fi;
alias l='ls'
alias la='l -a'
alias ll='l -l'
alias lg='lazygit'

# typo correction
alias sl='ls'
alias dc='cd'
