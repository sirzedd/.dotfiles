#!/bin/bash

memory=(
  update_freq=5
  icon.drawing=off
  label.font="$FONT:Bold:12.0"
  script="$PLUGIN_DIR/memory.sh"
  padding_right=10
)

sketchybar --add item memory right \
           --set memory "${memory[@]}"
