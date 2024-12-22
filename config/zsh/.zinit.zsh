if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  yes | sh -c "$(curl -fsSL https://git.io/zinit-install)"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet PZTM::helper
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::aws
zinit snippet OMZP::gcloud
zinit snippet OMZP::yarn
zinit snippet OMZP::npm
zinit snippet OMZP::node
zinit snippet OMZP::pip
zinit snippet OMZP::golang
zinit snippet OMZP::gradle
zinit snippet OMZP::terraform
zinit snippet OMZP::kubectl
zinit cdclear -q

autoload -Uz compinit && compinit

# theme
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# autocompletions
# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma-continuum/history-search-multi-word

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# ↑↓で補完候補を選択できるようにする
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

[[ -d .cache/zinit/completions ]] || mkdir -p .cache/zinit/completions
