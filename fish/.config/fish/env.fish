set -gx EDITOR nvim

set -gx PATH ~/.local/bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# bun
set -g BUN_INSTALL $HOME/.bun
set -gx PATH $BUN_INSTALL/bin $PATH

# composer
set -g COMPOSER_HOME $HOME/.composer
set -g PATH $COMPOSER_HOME/vendor/bin $PATH

# cargo
set -g CARGO_HOME $HOME/.cargo
set -g PATH $CARGO_HOME/bin $PATH

# mason
set -g MASON_HOME $HOME/.local/share/nvim/mason
set -g PATH $MASON_HOME/bin $PATH
