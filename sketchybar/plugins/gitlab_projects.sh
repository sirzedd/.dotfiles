#!/bin/bash

PROJECTS=$(curl -s http://localhost:8333/api/gitlab/projects 2>/dev/null)

if [ -z "$PROJECTS" ]; then
  exit 0
fi

# Remove all existing project items
sketchybar --remove '/gitlab.project.*/'

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

# Parse projects and create groups
echo "$PROJECTS" | jq -r '.[] | @base64' | while read -r project; do
  _jq() {
    echo "$project" | base64 --decode | jq -r "$1"
  }
  
  PROJECT_NAME=$(_jq '.name')
  MAIN_BRANCH=$(_jq '.mainBranch')
  
  # Fetch pipeline status for main branch
  PIPELINE=$(curl -s "http://localhost:8333/api/gitlab/pipelines?projectName=$PROJECT_NAME&branch=$MAIN_BRANCH" 2>/dev/null)
  STATUS=$(echo "$PIPELINE" | jq -r '.[0].status // "unknown"')
  
  # Fetch merge requests count
  MR_COUNT=$(curl -s "http://localhost:8333/api/gitlab/merge-requests?projectName=$PROJECT_NAME" 2>/dev/null | jq '. | length' 2>/dev/null || echo "0")
  
  # Set background color and icon based on main branch status
  case "$STATUS" in
    "success") BG_COLOR=0xff00ff00; ICON="✓" ;;
    "failed") BG_COLOR=0xffff0000; ICON="✗" ;;
    "running") BG_COLOR=0xffffff00; ICON="⏳" ;;
    "cancelled") BG_COLOR=0xffff00ff; ICON="✗" ;;
    "created") BG_COLOR=0xffffff00; ICON="🔨" ;;
    "waiting_for_resource") BG_COLOR=0xffffff00; ICON="⏸" ;;
    "preparing") BG_COLOR=0xffffff00; ICON="👨‍🍳" ;;
    "pending") BG_COLOR=0xffffff00; ICON="⏳" ;;
    "skipped") BG_COLOR=0xffff8000; ICON="⏭" ;;
    "manual") BG_COLOR=0xff0080ff; ICON="👤" ;;
    "scheduled") BG_COLOR=0xff0080ff; ICON="🕐" ;;
    *) BG_COLOR=0xffff0000; ICON="?" ;;
  esac
  
  # Create project group
  sketchybar --add item "gitlab.project.$PROJECT_NAME" right \
             --set "gitlab.project.$PROJECT_NAME" \
                   icon="$ICON" \
                   icon.font="Hack Nerd Font:Regular:14.0" \
                   icon.color=0xffffffff \
                   icon.padding_right=2 \
                   label="$PROJECT_NAME $MR_COUNT" \
                   label.font="Hack Nerd Font:Regular:12.0" \
                   label.color=0xffffffff \
                   label.padding_left=2 \
                   label.padding_right=5 \
                   background.color=0x1a1b26 \
                   background.border_color="$BG_COLOR" \
                   background.border_width=1 \
                   background.height=26 \
                   background.corner_radius=8 \
                   background.padding_left=5 \
                   background.padding_right=5 \
                   padding_right=10 \
                   update_freq=60 \
                   popup.align=right \
                   script="$PLUGIN_DIR/gitlab_project_update.sh $PROJECT_NAME $MAIN_BRANCH" \
                   click_script="$POPUP_CLICK_SCRIPT"
  
  # Fetch all pipelines for popup
  PIPELINES=$(curl -s "http://localhost:8333/api/gitlab/pipelines?projectName=$PROJECT_NAME" 2>/dev/null)
  
  # Add pipeline items to popup
  echo "$PIPELINES" | jq -r '.[] | @base64' | head -10 | while read -r pipeline; do
    _jq_pipe() {
      echo "$pipeline" | base64 --decode | jq -r "$1"
    }
    
    PIPE_ID=$(_jq_pipe '.id')
    PIPE_STATUS=$(_jq_pipe '.status')
    PIPE_REF=$(_jq_pipe '.ref // "main"')
    PIPE_CREATED=$(_jq_pipe '.createdAt')
    PIPE_URL=$(_jq_pipe '.webUrl')
    
    # Format date
    PIPE_DATE=$(date -j -f "%Y-%m-%dT%H:%M:%S" "$(echo $PIPE_CREATED | cut -d'.' -f1)" "+%m/%d %H:%M" 2>/dev/null || echo "")
    
    case "$PIPE_STATUS" in
      "success") PIPE_COLOR=0xff00ff00; PIPE_ICON="✓" ;;
      "failed") PIPE_COLOR=0xffff0000; PIPE_ICON="✗" ;;
      "running") PIPE_COLOR=0xffffff00; PIPE_ICON="⏳" ;;
      "cancelled") PIPE_COLOR=0xffff00ff; PIPE_ICON="✗" ;;
      "created") PIPE_COLOR=0xffffff00; PIPE_ICON="🔨" ;;
      "waiting_for_resource") PIPE_COLOR=0xffffff00; PIPE_ICON="⏸" ;;
      "preparing") PIPE_COLOR=0xffffff00; PIPE_ICON="👨🍳" ;;
      "pending") PIPE_COLOR=0xffffff00; PIPE_ICON="⏳" ;;
      "skipped") PIPE_COLOR=0xffff8000; PIPE_ICON="⏭" ;;
      "manual") PIPE_COLOR=0xff0080ff; PIPE_ICON="👤" ;;
      "scheduled") PIPE_COLOR=0xff0080ff; PIPE_ICON="🕐" ;;
      *) PIPE_COLOR=0xffff0000; PIPE_ICON="?" ;;
    esac
    
    sketchybar --add item "gitlab.project.$PROJECT_NAME.pipe.$PIPE_ID" popup."gitlab.project.$PROJECT_NAME" \
               --set "gitlab.project.$PROJECT_NAME.pipe.$PIPE_ID" \
                     icon="$PIPE_ICON" \
                     icon.color="$PIPE_COLOR" \
                     label="$PIPE_REF: $PIPE_STATUS $PIPE_DATE" \
                     click_script="open '$PIPE_URL'"
  done
done
