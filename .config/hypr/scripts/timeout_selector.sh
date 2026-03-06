#!/bin/bash

CONF="$HOME/.config/hypr/hypridle.conf"

# Define options for the Rofi menu
options="  5 Minutes\n  10 Minutes\n  30 Minutes\n  1 Hour\n󰅶  Disable Auto-Sleep"

# Show rofi menu
choice=$(echo -e "$options" | rofi -dmenu -i -p "Screen Timeout" -theme-str 'window {width: 500px;}')

# Assign time values in seconds based on selection
case "$choice" in
    *"5 Minutes") DIM=150; LOCK=300; DPMS=330 ;;
    *"10 Minutes") DIM=450; LOCK=600; DPMS=630 ;;
    *"30 Minutes") DIM=1650; LOCK=1800; DPMS=1830 ;;
    *"1 Hour") DIM=3450; LOCK=3600; DPMS=3630 ;;
    *"Disable Auto-Sleep")
        # Kill hypridle to completely stop auto-sleeping
        killall hypridle
        notify-send "Screen Timeout" "Auto-sleep disabled" -i dialog-information
        exit 0
        ;;
    *) exit 0 ;;
esac

# Update values in hypridle.conf using tags
sed -i "s/timeout = [0-9]*.*# DIM_TIMEOUT/timeout = $DIM                                # DIM_TIMEOUT/" "$CONF"
sed -i "s/timeout = [0-9]*.*# LOCK_TIMEOUT/timeout = $LOCK                                # LOCK_TIMEOUT/" "$CONF"
sed -i "s/timeout = [0-9]*.*# DPMS_TIMEOUT/timeout = $DPMS                                # DPMS_TIMEOUT/" "$CONF"

killall hypridle
sleep 0.5
hyprctl dispatch exec hypridle

# Send notification confirming the change
TEXT=$(echo "$choice" | sed 's/  //;s/󰅶  //')
notify-send "Screen Timeout" "Set to $TEXT" -i dialog-information