#!/bin/bash
 
searchterm=$(printf '' | fzf --print-query --prompt="Search: ")
if [ ! -z "$searchterm" ]; then
  selection=$(rg --color=always --line-number --no-heading --smart-case "$searchterm" \
    | fzf --ansi \
          --delimiter : \
          --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
          --preview-window '+{2}-/2')
  
  if [ ! -z "$selection" ]; then
    file=$(echo "$selection" | awk -F: '{print $1}')
    line=$(echo "$selection" | awk -F: '{print $2}')
    nvim "$file" "+$line"
  fi
fi

