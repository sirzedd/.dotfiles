#!/bin/bash

# Find the window ID of the currently focused window
FOCUSED_WINDOW_ID=$(xdotool getwindowfocus)

# Find the name of the currently focused window
FOCUSED_WINDOW_NAME=$(xdotool getwindowname $FOCUSED_WINDOW_ID)

# If the focused window is alacritty, hide it; otherwise, bring up alacritty
if [[ $FOCUSED_WINDOW_NAME == "Alacritty" ]]; then
  xdotool windowminimize $FOCUSED_WINDOW_ID
else
  wmctrl -a Alacritty || alacritty
fi

