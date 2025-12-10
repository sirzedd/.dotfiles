#!/bin/bash

PROJECT_NAME=$1
MAIN_BRANCH=$2

# Fetch pipeline status for main branch
PIPELINE=$(curl -s "http://localhost:8333/api/gitlab/pipelines?projectName=$PROJECT_NAME&branch=$MAIN_BRANCH" 2>/dev/null)
STATUS=$(echo "$PIPELINE" | jq -r '.[0].status // "unknown"')

# Fetch merge requests count
MR_COUNT=$(curl -s "http://localhost:8333/api/gitlab/merge-requests?projectName=$PROJECT_NAME" 2>/dev/null | jq '. | length' 2>/dev/null || echo "0")

# Set background border color and icon based on main branch status
case "$STATUS" in
  "success") BG_COLOR=0xff00ff00; ICON="✓" ;;
  "failed") BG_COLOR=0xffff0000; ICON="✗" ;;
  "running") BG_COLOR=0xffffff00; ICON="⏳" ;;
  "cancelled") BG_COLOR=0xffff00ff; ICON="✗" ;;
  "created") BG_COLOR=0xffffff00; ICON="🔨" ;;
  "waiting_for_resource") BG_COLOR=0xffffff00; ICON="⏸" ;;
  "preparing") BG_COLOR=0xffffff00; ICON="👨🍳" ;;
  "pending") BG_COLOR=0xffffff00; ICON="⏳" ;;
  "skipped") BG_COLOR=0xffff8000; ICON="⏭" ;;
  "manual") BG_COLOR=0xff0080ff; ICON="👤" ;;
  "scheduled") BG_COLOR=0xff0080ff; ICON="🕐" ;;
  *) BG_COLOR=0xffff0000; ICON="?" ;;
esac

sketchybar --set "$NAME" background.border_color="$BG_COLOR" icon="$ICON" label="$PROJECT_NAME $MR_COUNT"
