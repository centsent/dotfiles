#!/bin/bash
#
pkill -f waybar
waybar &
hyprctl reload
killall swww-daemon
swww-daemon
