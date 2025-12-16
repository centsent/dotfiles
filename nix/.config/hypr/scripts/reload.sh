#!/bin/bash
pkill -f waybar
pkill -f vicinae
waybar &
hyprctl reload
killall swww-daemon
swww-daemon
vicinae server
