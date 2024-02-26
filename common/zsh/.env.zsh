# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Set up starship prompt
eval "$(starship init zsh)"
# Set up zoxide
eval "$(zoxide init zsh)"

# asdf
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/plugins/java/set-java-home.zsh"
