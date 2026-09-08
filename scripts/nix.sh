#!/usr/bin/env bash
set -euo pipefail

# Applying uncommitted dotfile edits is expected. Inherit this setting in the
# Nix commands that Home Manager invokes as well, without changing global config.
export NIX_CONFIG="${NIX_CONFIG:-}"$'\nwarn-dirty = false'

# A freshly installed Nix is not yet on the invoking shell's PATH.
for candidate in "$HOME/.nix-profile/bin/nix" /nix/var/nix/profiles/default/bin/nix; do
  if [[ -x "$candidate" ]]; then
    exec "$candidate" --extra-experimental-features 'nix-command flakes' "$@"
  fi
done
exec nix --extra-experimental-features 'nix-command flakes' "$@"
