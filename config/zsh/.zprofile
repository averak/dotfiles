export TERM=xterm-256color

export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:/opt/metasploit-framework/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin

export DOTFILES_DIR=$HOME/dotfiles
setopt nullglob
for file in "$DOTFILES_DIR/local/"*.sh; do
    source "$file"
done
unsetopt nullglob

if command -v aqua &> /dev/null; then
  export PATH="$(aqua root-dir)/bin:$PATH"
fi
