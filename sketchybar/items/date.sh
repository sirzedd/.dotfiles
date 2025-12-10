#!/bin/bash

date_item=(
  update_freq=30
  icon.drawing=off
  label.font="$FONT:Bold:12.0"
  script="$PLUGIN_DIR/date.sh"
  padding_right=10
)

sketchybar --add item date right \
           --set date "${date_item[@]}"
