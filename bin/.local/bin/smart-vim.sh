#!/bin/bash

FILE="$1"
MAX_SIZE=$((2 * 1024 * 1024)) # 2 MB

# Get the file size in bytes
FILE_SIZE=$(stat -c%s "$FILE")

if [ "$FILE_SIZE" -gt "$MAX_SIZE" ]; then
    echo "Large file detected. Opening without plugins..."
    nvim -u NONE "$FILE"
else
    echo "Opening with full configuration..."
    nvim "$FILE"
fi
