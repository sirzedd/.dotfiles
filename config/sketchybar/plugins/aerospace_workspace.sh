#!/bin/bash

# Get focused workspace from AeroSpace
WORKSPACE=$(aerospace list-workspaces --focused)

if [ -n "$WORKSPACE" ]; then
  sketchybar --set $NAME label="$WORKSPACE"
else
  sketchybar --set $NAME label="N/A"
fi