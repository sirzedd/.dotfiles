#!/bin/bash
badge=$(osascript ~/.config/sketchybar/plugins/outlook_badge.scpt)
if [ "$badge" -gt 0 ]; then
    echo "$badge"
    /opt/homebrew/bin/sketchybar --set outlook_badge label=$badge \
                                      background.border_color=0xff00ff00
else
    echo "0"

    /opt/homebrew/bin/sketchybar --set outlook_badge label=0 \
                                      background.border_color=0xffffffff
fi

