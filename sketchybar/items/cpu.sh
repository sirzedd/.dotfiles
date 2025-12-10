#!/bin/bash

cpu_percent=(
  label.font="$FONT:Bold:12.0"
  icon.drawing=off
  padding_left=10
  update_freq=2
  mach_helper="$HELPER"
)

sketchybar --add item cpu.percent right         \
           --set cpu.percent "${cpu_percent[@]}"
