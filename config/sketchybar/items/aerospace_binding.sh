#!/bin/bash

  space=(
    icon.padding_left=10
    icon.padding_right=15
    padding_left=2
    padding_right=2
    label.padding_right=20
    icon.highlight_color='green'
#    label.font="sketchybar-app-font:Regular:16.0"
    label.background.height=26
    label.background.drawing=on
    label.background.color='blue'
    label.background.corner_radius=8
#    label.drawing=off
  )

sketchybar --add event aerospace_mode_change

sketchybar --add item binding_mode left \
           --set binding_mode  script="$HOME/.config/sketchybar/plugins/aerospace_mode.sh" \
                "${space[@]}" \
           --subscribe binding_mode aerospace_mode_change

