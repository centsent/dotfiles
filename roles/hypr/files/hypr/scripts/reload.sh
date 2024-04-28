#!/bin/bash
#
killall waybar
waybar &
hyprctl reload
killall hyprpaper
hyprpaper
