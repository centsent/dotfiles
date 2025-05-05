#!/bin/zsh

# Check if eza is installed, and if it is, set up an alias for it
if type eza >/dev/null; then
  alias l="eza --long --color --icons --all"
  alias ls="eza --grid --color --icons --all"
fi

# Check if rip is installed, and if it is, set up an alias for it
if type rip >/dev/null; then
  alias rm="rip"
fi

if type xcp >/dev/null; then
  alias cp="xcp"
fi

if type topgrade >/dev/null; then
  alias tg="topgrade"
fi

if type z >/dev/null; then
  alias cd="z"
fi

if type bat >/dev/null; then
  alias cat="bat"
fi

if type procs >/dev/null; then
  alias ps="procs"
fi

if type pnpm >/dev/null; then
  alias pn="pnpm"
fi

if type emerge >/dev/null; then
  alias seup="sudo emerge --ask --verbose --update --deep --newuse @world"
  alias se="sudo emerge --ask --verbose"
fi
