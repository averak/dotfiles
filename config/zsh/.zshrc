fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -C
autoload -U +X bashcompinit && bashcompinit
autoload -Uz colors && colors

setopt complete_in_word
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

setopt no_nomatch
setopt prompt_subst
setopt transient_rprompt
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_no_store
setopt hist_verify
setopt share_history
setopt extended_history
setopt append_history
setopt auto_cd
setopt auto_pushd
setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types
setopt no_flow_control
setopt print_eight_bit
setopt pushd_ignore_dups
setopt rec_exact
setopt autoremoveslash
setopt complete_in_word
setopt glob
setopt glob_complete
setopt extended_glob
setopt mark_dirs
setopt numeric_glob_sort
setopt magic_equal_subst
setopt always_last_prompt

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
