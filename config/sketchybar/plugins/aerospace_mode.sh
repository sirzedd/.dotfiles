#!/bin/sh

MODE_FILE="$HOME/.config/aerospace/current_mode"

if [ -f "$MODE_FILE" ]; then 
  MODE=$(cat "$MODE_FILE") 
else MODE="main" 
fi

/opt/homebrew/bin/sketchybar --set binding_mode label="$MODE"
