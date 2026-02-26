#!/bin/bash

# Define options for the Rofi menu
options="  Performance\n  Balanced\n  Power Saver"

# Show rofi menu
choice=$(echo -e "$options" | rofi -dmenu -i -p "Power Profile" -theme-str 'window {width: 400px;}')

# Apply the selected power profile using powerprofilesctl
case "$choice" in
    *"Performance")
        powerprofilesctl set performance
        notify-send "Power Profile" "Set to Performance Mode" -i dialog-information
        ;;
    *"Balanced")
        powerprofilesctl set balanced
        notify-send "Power Profile" "Set to Balanced Mode" -i dialog-information
        ;;
    *"Power Saver")
        powerprofilesctl set power-saver
        notify-send "Power Profile" "Set to Power Saver Mode" -i dialog-information
        ;;
    *) exit 0 ;;
esac