if type -q starship
    starship init fish | source
end

if type -q zoxide
    zoxide init fish | source
end

set -l source_dir (dirname (status -f))

source $source_dir/env.fish
source $source_dir/aliases.fish

test -d "$HOME/.tea" && "$HOME/.tea/tea.xyz/v*/bin/tea" --magic=fish --silent | source
