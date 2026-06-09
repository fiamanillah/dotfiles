#!/bin/bash
# ==========================================
# HYPRPAPER WALLPAPER CHANGER
# Randomly rotates wallpapers on both monitors
# ==========================================

# Give hyprpaper time to start on login
sleep 3

WALLPAPER_DIR="/home/fiamanillah/Pictures/Wallpapers"
INTERVAL=1800 # 30 minutes in seconds. Change this to change wallpaper faster!
MONITOR1="eDP-1"
MONITOR2="DP-2"

if [ ! -d "$WALLPAPER_DIR" ]; then
  notify-send "hyprpaper-changer" "Wallpaper directory not found: $WALLPAPER_DIR" -u critical
  exit 1
fi

while true; do
  # Pick two random wallpapers
  mapfile -t IMAGES < <(find "$WALLPAPER_DIR" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | shuf -n 2)
  
  IMG1="${IMAGES[0]}"
  IMG2="${IMAGES[1]}"

  if [ -n "$IMG1" ]; then
    hyprctl hyprpaper preload "$IMG1"
    hyprctl hyprpaper wallpaper "$MONITOR1,$IMG1"
  fi
  
  if [ -n "$IMG2" ]; then
    hyprctl hyprpaper preload "$IMG2"
    hyprctl hyprpaper wallpaper "$MONITOR2,$IMG2"
  fi

  # Unload unused wallpapers from memory
  sleep 2
  hyprctl hyprpaper unload all

  # Wait before next change
  sleep "$INTERVAL"
done
