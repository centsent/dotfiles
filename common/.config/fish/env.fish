set -gx EDITOR nvim

set -gx PATH ~/.local/bin $PATH

# cargo
set -g CARGO_HOME $HOME/.cargo
set -gx PATH $CARGO_HOME/bin $PATH
