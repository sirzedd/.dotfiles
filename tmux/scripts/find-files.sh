#!/bin/bash


selection=$(fd --type f --hidden --follow --exclude .git \
  | fzf --preview 'bat --style=numbers --color=always {}' \
        --preview-window=right:60%)

if [ ! -z "$selection" ]; then
    clear
    nvim "$selection"
fi

