#!/bin/bash

# Give swww daemon time to start on login
sleep 3 

# Directory containing your wallpapers
WALLPAPER_DIR="/home/fiamanillah/Pictures/Wallpapers"
INTERVAL=300000000 
MONITOR1="eDP-1"
MONITOR2="HDMI-A-1"

# Curated list of smooth transition styles
TRANSITIONS=("fade" "wipe" "wave" "grow" "center" "outer")

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Directory $WALLPAPER_DIR does not exist."
    exit 1
fi

while true; do
    # Find all images and pick two random ones
    mapfile -t IMAGES < <(find "$WALLPAPER_DIR" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | shuf -n 2)

    IMG1="${IMAGES[0]}"
    IMG2="${IMAGES[1]}"

    # Generate a random transition and a random angle (0-359) for EACH monitor
    TRANS1=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
    TRANS2=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
    ANGLE1=$((RANDOM % 360))
    ANGLE2=$((RANDOM % 360))

    # Apply to Laptop (eDP-1)
    if [ -n "$IMG1" ]; then
        swww img "$IMG1" -o "$MONITOR1" \
            --transition-fps 144 \
            --transition-type "$TRANS1" \
            --transition-angle "$ANGLE1" \
            --transition-step 45
    fi

    # Apply to External Monitor (HDMI-A-1)
    if [ -n "$IMG2" ]; then
        swww img "$IMG2" -o "$MONITOR2" \
            --transition-fps 144 \
            --transition-type "$TRANS2" \
            --transition-angle "$ANGLE2" \
            --transition-step 45
    fi

    # Wait before changing again
    sleep $INTERVAL
done