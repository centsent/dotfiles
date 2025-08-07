#!/bin/bash

directory=~/Wallpapers
log_file=/tmp/wallpaper.log
interval=600

log() {
  echo "$(date): $1" >>"$log_file"
}

check_dependencies() {
  if ! command -v swww &>/dev/null; then
    log "error: swww command not found"
    exit 1
  fi

  if ! command -v find &>/dev/null; then
    log "error: find command not found"
    exit 1
  fi

  if ! command -v shuf &>/dev/null; then
    log "error: shuf command not found"
    exit 1
  fi
}

wait_for_swww() {
  local retries=30
  local count=0

  while ! swww query &>/dev/null; do
    if [ $count -ge $retries ]; then
      log "error: swww daemon failed to initialize"
      exit 1
    fi
    log "Waiting for swww daemon to initialize ($count/$retries)"
    sleep 2
    ((count++))
  done
}

select_random_wallpaper() {
  local wallpaper

  if [ ! -d "$directory" ]; then
    log "error: directory $directory does not exist"
    return 1
  fi

  wallpaper=$(find "$directory" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

  if [ -z "$wallpaper" ] || [ ! -f "$wallpaper" ]; then
    log "warning: no valid wallpapers found in $directory"
    return 1
  fi

  echo "$wallpaper"
  return 0
}

main() {
  log "change wallpaper script started"

  check_dependencies

  wait_for_swww

  if [ ! -d "$directory" ]; then
    log "error: directory $directory does not exist"
    exit 1
  fi

  log "Starting wallpaper change loop, interval: $interval seconds"

  while true; do
    if random_background=$(select_random_wallpaper); then
      if swww img "$random_background"; then
        log "Successfully set wallpaper: $random_background"
      else
        log "Error: Failed to set wallpaper: $random_background"
      fi
    else
      log "Error: Failed to select random wallpaper"
    fi

    log "Waiting $interval seconds before changing wallpaper"
    sleep $interval
  done
}

main
