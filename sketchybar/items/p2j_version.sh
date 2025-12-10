#!/bin/bash

p2j_version=(
  update_freq=60
  icon.drawing=off
  label.font="$FONT:Bold:12.0"
  script="$PLUGIN_DIR/p2j_version.sh"
  padding_right=10
)

sketchybar --add item p2j_version right \
           --set p2j_version "${p2j_version[@]}"
