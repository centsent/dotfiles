#!/bin/bash
pkill -f waybar
pkill -f vicinae
waybar &
hyprctl reload
killall awww-daemon
awww-daemon
vicinae server
