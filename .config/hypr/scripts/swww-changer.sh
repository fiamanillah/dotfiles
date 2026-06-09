#!/bin/bash
# ==========================================
# SWWW WALLPAPER CHANGER
# Randomly rotates wallpapers on both monitors
# ==========================================

# Give swww daemon time to start on login
sleep 3

WALLPAPER_DIR="/home/fiamanillah/Pictures/Wallpapers"
INTERVAL=1800 # ← FIXED: was 300000000 (~9.5 years). Now 30 minutes.
MONITOR1="eDP-1"
MONITOR2="HDMI-A-1"

TRANSITIONS=("fade" "wipe" "wave" "grow" "center" "outer")

if [ ! -d "$WALLPAPER_DIR" ]; then
  notify-send "swww-changer" "Wallpaper directory not found: $WALLPAPER_DIR" -u critical
  exit 1
fi

# Set initial wallpapers immediately on startup
mapfile -t INIT_IMAGES < <(find "$WALLPAPER_DIR" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png \) | shuf -n 2)
[ -n "${INIT_IMAGES[0]}" ] && swww img "${INIT_IMAGES[0]}" -o "$MONITOR1" --transition-type fade --transition-fps 144 --transition-step 60
[ -n "${INIT_IMAGES[1]}" ] && swww img "${INIT_IMAGES[1]}" -o "$MONITOR2" --transition-type fade --transition-fps 144 --transition-step 60

while true; do
  sleep "$INTERVAL"

  mapfile -t IMAGES < <(find "$WALLPAPER_DIR" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | shuf -n 2)

  IMG1="${IMAGES[0]}"
  IMG2="${IMAGES[1]}"

  TRANS1=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
  TRANS2=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
  ANGLE1=$((RANDOM % 360))
  ANGLE2=$((RANDOM % 360))

  [ -n "$IMG1" ] && swww img "$IMG1" -o "$MONITOR1" \
    --transition-fps 144 \
    --transition-type "$TRANS1" \
    --transition-angle "$ANGLE1" \
    --transition-step 45

  [ -n "$IMG2" ] && swww img "$IMG2" -o "$MONITOR2" \
    --transition-fps 144 \
    --transition-type "$TRANS2" \
    --transition-angle "$ANGLE2" \
    --transition-step 45
done

