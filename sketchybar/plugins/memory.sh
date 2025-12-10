#!/bin/bash

MEMORY=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100-$5}' | sed 's/%//')
sketchybar --set $NAME label="MEM: ${MEMORY}%"
