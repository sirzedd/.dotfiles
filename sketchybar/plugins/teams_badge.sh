#!/bin/bash
badge=$(osascript ~/.config/sketchybar/plugins/teams_badge.scpt)
if [ "$badge" -gt 0 ]; then
    /opt/homebrew/bin/sketchybar --set teams_badge label=$badge \
                                      background.border_color=0xff00ff00
    echo "$badge"
else
    echo "0"
    /opt/homebrew/bin/sketchybar --set teams_badge label=0 \
                                      background.border_color=0xffffffff
fi

