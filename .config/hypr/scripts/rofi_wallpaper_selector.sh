#!/bin/bash

WALLPAPER_DIR="/home/fiamanillah/Pictures/Wallpapers"

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Error" "Wallpaper directory not found."
    exit 1
fi

# ==========================================
# STEP 1: SELECT WALLPAPER
# ==========================================
file_list=""
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,gif}; do
    [ -e "$img" ] || continue
    basename_img=$(basename "$img")
    file_list+="${basename_img}\0icon\x1f${img}\n"
done

theme_override='
window { width: 900px; }
listview { columns: 3; lines: 3; spacing: 20px; }
element { orientation: vertical; padding: 15px; }
element-icon { size: 200px; horizontal-align: 0.5; }
element-text { horizontal-align: 0.5; }
'

selected_wallpaper=$(echo -en "$file_list" | rofi -dmenu -i -p "󰸉 Wallpaper" -theme-str "$theme_override")

if [ -z "$selected_wallpaper" ]; then
    exit 0
fi

WALLPAPER_PATH="$WALLPAPER_DIR/$selected_wallpaper"

# ==========================================
# STEP 2: SELECT MONITOR
# ==========================================
monitor_options="󰍹  Laptop (eDP-1)\n󰍹  External (HDMI-A-1)\n󰍺  Both Monitors"

monitor_theme='
window { width: 400px; }
listview { columns: 1; lines: 3; spacing: 5px; }
element { orientation: horizontal; padding: 10px; }
element-icon { size: 0px; }
element-text { horizontal-align: 0.0; }
'

selected_monitor=$(echo -e "$monitor_options" | rofi -dmenu -i -p "󰍹 Display" -theme-str "$monitor_theme")

if [ -z "$selected_monitor" ]; then
    exit 0
fi

# ==========================================
# STEP 3: APPLY WITH RANDOM ANIMATION
# ==========================================
# Curated smooth transitions and random angle generator
TRANSITIONS=("fade" "wipe" "wave" "grow" "center" "outer")
RAND_TRANS=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
RAND_ANGLE=$((RANDOM % 360))

# 144 FPS for high refresh rate, step 45 for smooth speed
SWWW_PARAMS="--transition-fps 144 --transition-type $RAND_TRANS --transition-angle $RAND_ANGLE --transition-step 45"

case "$selected_monitor" in
    *"Laptop"*)
        swww img "$WALLPAPER_PATH" -o "eDP-1" $SWWW_PARAMS
        notify-send "Wallpaper" "Applied to Laptop" -i "$WALLPAPER_PATH"
        ;;
    *"External"*)
        swww img "$WALLPAPER_PATH" -o "HDMI-A-1" $SWWW_PARAMS
        notify-send "Wallpaper" "Applied to External" -i "$WALLPAPER_PATH"
        ;;
    *"Both"*)
        swww img "$WALLPAPER_PATH" $SWWW_PARAMS
        notify-send "Wallpaper" "Applied to Both Monitors" -i "$WALLPAPER_PATH"
        ;;
esac