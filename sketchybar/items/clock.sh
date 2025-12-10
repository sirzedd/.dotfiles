#!/bin/bash

clock=(
  update_freq=30
  icon.drawing=off
  label.font="$FONT:Bold:12.0"
  script="$PLUGIN_DIR/clock.sh"
  padding_right=10
)

sketchybar --add item clock right \
           --set clock "${clock[@]}"
