#!/usr/bin/env bash
# Reload Hyprland and restart the session helpers it launches.
#
# Note on backgrounding: awww-daemon and vicinae both run in the foreground
# until killed. Previously awww-daemon was started without `&`, so the script
# blocked there and never reached `vicinae server` -- leaving vicinae killed on
# line 3 but never restarted.

set -uo pipefail

# pkill/killall exit non-zero when nothing matched, which is expected here.
pkill -f waybar || true
pkill -f vicinae || true
killall awww-daemon || true

hyprctl reload

start() {
  nohup "$@" >/dev/null 2>&1 &
  disown
}

start waybar
start awww-daemon
start vicinae server
