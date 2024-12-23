eval "$(starship init bash)"
export BASH_SILENCE_DEPRECATION_WARNING=1

#--------------------------------------------------------------#
##        aliases                                             ##
#--------------------------------------------------------------#

alias l='exa --icons'
alias ls='l'
alias la='l -a'
alias ll='l -l'
alias lg='lazygit'

# typo correction
alias sl='ls'
alias dc='cd'

#--------------------------------------------------------------#
##        any tools                                           ##
#--------------------------------------------------------------#

if [[ -x "$(command -v mise)" ]]; then
    eval "$(mise activate bash)"
    source <(mise completion --usage bash)
fi;

if [[ -x "$(command -v docker)" ]]; then
    source <(docker completion bash)
fi;

if [[ -x "$(command -v zellij)" ]]; then
    # https://github.com/zellij-org/zellij/issues/1933
    . <( zellij setup --generate-completion bash | sed -Ee 's/^(_(zellij) ).*/compdef \1\2/' )
fi;

if [[ -x "$(command -v gcloud)" ]]; then
    GCLOUD_SDK_PATH=$(gcloud info --format="value(installation.sdk_root)")
    source "$GCLOUD_SDK_PATH/path.bash.inc"
    source "$GCLOUD_SDK_PATH/completion.bash.inc"
fi;

if [[ -x "$(command -v fzf)" ]]; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
    export FZF_DEFAULT_OPTS='--height 40% --reverse --preview "bat --theme=TwoDark --style=numbers --color=always --line-range :200 {}"'
fi;

if [[ -x "$(command -v kubectl)" ]]; then
    source <(kubectl completion bash)
fi;

if [[ -x "$(command -v terraform)" ]]; then
    complete -C "$(which terraform)" terraform
fi
