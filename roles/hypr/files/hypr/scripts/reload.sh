#!/bin/bash
#
killall waybar
waybar &
hyprctl reload
killall swww-daemon
swww-daemon
