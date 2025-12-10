#!/bin/bash

VERSION=$(curl -s http://localhost:8333/api/gitlab/p2j-version 2>/dev/null || echo "N/A")
sketchybar --set $NAME label="P2J: $VERSION"
