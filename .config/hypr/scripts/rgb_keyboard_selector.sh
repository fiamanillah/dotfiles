#!/bin/bash

# Hardware Paths
ANIM_PATH="/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/four_zoned_kb/four_zone_mode"
STATIC_PATH="/sys/module/linuwu_sense/drivers/platform:acer-wmi/acer-wmi/four_zoned_kb/per_zone_mode"

# STEP 1: Choose Mode
mode_options="🌊 Wave\n🌈 Neon\n🫁 Breath\n✨ Zoom\n💫 Shifting\n🛑 Static\n🌑 Off"
mode_choice=$(echo -e "$mode_options" | rofi -dmenu -i -p "Effect" -theme-str 'window {width: 400px;}')
[ -z "$mode_choice" ] && exit 0

# STEP 2: Choose Color (if applicable)
HEX="FF5722"; R=255; G=87; B=34; NAME="Orange"
if [[ "$mode_choice" != *"Wave"* && "$mode_choice" != *"Neon"* && "$mode_choice" != *"Off"* ]]; then
    color_options="🟠 Orange\n🔵 Blue\n🟢 Green\n🔴 Red\n🟣 Purple\n⚪ White"
    color_choice=$(echo -e "$color_options" | rofi -dmenu -i -p "Color" -theme-str 'window {width: 400px;}')
    [ -z "$color_choice" ] && exit 0
    case "$color_choice" in
        *"Orange") HEX="FF5722"; R=255; G=87; B=34; NAME="Orange" ;;
        *"Blue")   HEX="0000FF"; R=0; G=0; B=255; NAME="Blue" ;;
        *"Green")  HEX="00FF00"; R=0; G=255; B=0; NAME="Green" ;;
        *"Red")    HEX="FF0000"; R=255; G=0; B=0; NAME="Red" ;;
        *"Purple") HEX="B400FF"; R=180; G=0; B=255; NAME="Purple" ;;
        *"White")  HEX="FFFFFF"; R=255; G=255; B=255; NAME="White" ;;
    esac
fi

# STEP 3: Choose Speed
speed=4
if [[ "$mode_choice" != *"Static"* && "$mode_choice" != *"Off"* ]]; then
    speed_choice=$(echo -e "🐢 Slow (2)\n🚶 Normal (4)\n🏃 Fast (7)\n🚀 Max (9)" | rofi -dmenu -i -p "Speed" -theme-str 'window {width: 400px;}')
    case "$speed_choice" in *"Slow"*) speed=2;; *"Fast"*) speed=7;; *"Max"*) speed=9;; esac
fi

# STEP 4: Apply
case "$mode_choice" in
    *"Wave")     echo "3,$speed,100,1,0,0,0" > $ANIM_PATH ;;
    *"Neon")     echo "2,$speed,100,1,0,0,0" > $ANIM_PATH ;;
    *"Breath"*)  echo "1,$speed,100,1,$R,$G,$B" > $ANIM_PATH ;;
    *"Zoom"*)    echo "5,$speed,100,1,$R,$G,$B" > $ANIM_PATH ;;
    *"Shifting"*) echo "4,$speed,100,1,$R,$G,$B" > $ANIM_PATH ;;
    *"Static"*)  echo "$HEX,$HEX,$HEX,$HEX,100" > $STATIC_PATH ;;
    *"Off")      echo "000000,000000,000000,000000,0" > $STATIC_PATH ;;
esac

notify-send "Keyboard RGB" "Applied $mode_choice" -i keyboard