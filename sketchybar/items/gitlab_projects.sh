#!/bin/bash

sketchybar --add event gitlab_projects_update

sketchybar --add item gitlab_projects_loader right \
           --set gitlab_projects_loader \
                 update_freq=60 \
                 script="$PLUGIN_DIR/gitlab_projects.sh" \
                 drawing=off
