fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

autoload -Uz colors && colors
setopt complete_in_word
zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt ignore_eof
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt list_packed
setopt auto_cd
setopt auto_pushd
setopt correct

source $DOTFILES_DIR/config/zsh/.zinit.zsh

#--------------------------------------------------------------#
##        aliases                                             ##
#--------------------------------------------------------------#

alias l='exa --icons'
alias ls='l'
alias la='l -a'
alias ll='l -l'
alias lg='lazygit'
alias -g L='| less'
alias -g G='| grep'

# typo correction
alias sl='ls'
alias dc='cd'

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

#--------------------------------------------------------------#
##        any tools                                           ##
#--------------------------------------------------------------#

if [ -e "$HOME/.anyenv" ]; then
    export ANYENV_ROOT="$HOME/.anyenv"
    eval "$(anyenv init -)"
fi

if [[ -x "$(command -v docker)" ]]; then
    source <(docker completion zsh)
fi;

if [[ -x "$(command -v zellij)" ]]; then
    # https://github.com/zellij-org/zellij/issues/1933
    . <( zellij setup --generate-completion zsh | sed -Ee 's/^(_(zellij) ).*/compdef \1\2/' )
fi;

if [[ -x "$(command -v gcloud)" ]]; then
    GCLOUD_SDK_PATH=$(gcloud info --format="value(installation.sdk_root)")
    source "$GCLOUD_SDK_PATH/path.zsh.inc"
    source "$GCLOUD_SDK_PATH/completion.zsh.inc"
fi;

if [[ -x "$(command -v fzf)" ]]; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
    export FZF_DEFAULT_OPTS='--height 40% --reverse --preview "bat --theme=TwoDark --style=numbers --color=always --line-range :200 {}"'
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi;

if [[ -x "$(command -v kubectl)" ]]; then
    source <(kubectl completion zsh)
fi;

if [[ -x "$(command -v terraform)" ]]; then
    complete -C "$(which terraform)" terraform
fi
