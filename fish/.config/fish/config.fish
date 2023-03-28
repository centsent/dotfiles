if type -q starship
    starship init fish | source
end

if type -q zoxide
    zoxide init fish | source
end

set -l source_dir (dirname (status -f))

source $source_dir/env.fish
source $source_dir/aliases.fish

source /Users/theodo/.docker/init-fish.sh || true # Added by Docker Desktop
