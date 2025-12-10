#!/bin/bash

notifications=(
  update_freq=10
  icon=$BELL
  icon.font="$FONT:Bold:14.0"
  label.drawing=off
  padding_right=10
)

sketchybar --add item notifications right \
           --set notifications "${notifications[@]}"
