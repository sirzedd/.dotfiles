#!/bin/bash 

MODE_FILE="$HOME/.config/aerospace/current_mode"

echo $1 > $MODE_FILE

if [ -f "$MODE_FILE" ]; then 
  MODE=$(cat "$MODE_FILE") 
else MODE="main" 
fi

#/opt/homebrew/bin/sketchybar --set binding_mode label="$MODE"

/opt/homebrew/bin/sketchybar --trigger aerospace_mode_change

