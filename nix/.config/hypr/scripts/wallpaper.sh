#!/bin/bash

directory=~/Wallpapers

if [ -d "$directory" ]; then
  while true; do
    random_background=$(find "$directory" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)
    swww img "$random_background"

    # Wait for 600 seconds (10 minutes) before changing the wallpaper again
    sleep 600
  done
fi
