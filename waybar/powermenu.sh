#!/usr/bin/env bash

RESULT=$(echo -e "power off\nreboot\nlog out\nlock screen" | rofi -dmenu)

case "$RESULT" in
    "power off") systemctl poweroff
    ;;
    "reboot") reboot
    ;;
    "log out") hyprctl dispatch exit
    ;;
    "lock screen") hyprlock
    ;;
esac

