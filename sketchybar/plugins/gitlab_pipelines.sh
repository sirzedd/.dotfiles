#!/bin/bash

# Configuration
API_URL="http://localhost:8333/api/gitlab"
PROJECTS=("appcode" "builder")
SKETCHYBAR="/opt/homebrew/bin/sketchybar"
JQ="/opt/homebrew/bin/jq"

# Function to get status icon
get_status_icon() {
  local status="$1"
  case "$status" in
    "success") echo "🟢" ;;
    "failed") echo "🔴" ;;
    "running") echo "⏳" ;;
    "pending") echo "⏳" ;;
    "canceled") echo "⬜" ;;
    *) echo "❓" ;;
  esac
}
#SUCCESS_ICON="🟢"
#FAILED_ICON="🔴"
#RUNNING_ICON="🟡"
#CANCELED_ICON="⬜"

#"success") echo "✅" ;;
#"failed") echo "❌" ;;
#"running") echo "⏳" ;;
#"pending") echo "⏳" ;;
#"canceled") echo "🛑" ;;
# Function to format date
format_date() {
  local date_str="$1"
  # Convert ISO 8601 to readable format (e.g., "Jun 19 09:00")
  date -j -f "%Y-%m-%dT%H:%M:%SZ" "$date_str" "+%b %d %H:%M" 2>/dev/null || echo "$date_str"
}

# Function to fetch and process pipelines for a project
process_project() {
  local project="$1"
  local item_name="gitlab.$project"
  local popup_name="gitlab.$project.popup"

  # Fetch pipeline data
  echo "calling $API_URL/$project/pipelines"
  response=$(curl -s "$API_URL/$project/pipelines")
  if [[ $? -ne 0 ]]; then
    $SKETCHYBAR --set "$item_name" label="$project: Error" icon="⚠️"
    return
  fi

  # Parse JSON with jq
  pipelines=$(echo "$response" | $JQ -c '.[]')
  if [[ -z "$pipelines" ]]; then
    $SKETCHYBAR --set "$item_name" label="$project: No Pipelines" icon="⚠️"
    return
  fi

  # Find latest main pipeline
  main_pipeline=$(echo "$response" | $JQ -c '.[] | select(.ref == "main")' | head -n 1)
  if [[ -z "$main_pipeline" ]]; then
    master_pipeline=$(echo "$response" | $JQ -c '.[] | select(.ref == "master")' | head -n 1)
    if [[ -z "$master_pipeline" ]]; then
      $SKETCHYBAR --set "$item_name" label="$project: No Main Pipeline" icon="⚠️"
      return
    fi
    main_pipeline=$master_pipeline
  fi

  # Extract main pipeline status and set icon
  status=$(echo "$main_pipeline" | $JQ -r '.status')
  icon=$(get_status_icon "$status")
  $SKETCHYBAR --set "$item_name" label="$project" icon="$icon"

  # Reset popup menu
  #$SKETCHYBAR --remove "/$popup_name\..*/" 2>/dev/null
  $SKETCHYBAR --remove "$popup_name" 2>/dev/null

  # Create popup menu items
  index=0
  while IFS= read -r pipeline; do
    id=$(echo "$pipeline" | $JQ -r '.id')
    status=$(echo "$pipeline" | $JQ -r '.status')
    ref=$(echo "$pipeline" | $JQ -r '.ref')
    sha=$(echo "$pipeline" | $JQ -r '.sha | .[:7]') # Short SHA
    created_by=$(echo "$pipeline" | $JQ -r '.createdBy')
    created_at=$(echo "$pipeline" | $JQ -r '.createdAt')
    web_url=$(echo "$pipeline" | $JQ -r '.webUrl')
    status_icon=$(get_status_icon "$status")

    # Format popup label
    created_at_formatted=$(format_date "$created_at")
    label="ID: $id | Ref: $ref | SHA: $sha | By: $created_by | At: $created_at_formatted"

    # Add menu item
    $SKETCHYBAR --add item "$popup_name" popup."$item_name" \
                --set "$popup_name" label="$label" icon="$status_icon" icon.padding_right=10 \
                click_script="open '$web_url'; $SKETCHYBAR --set $item_name popup.drawing=off"

    ((index++))
  done <<< "$pipelines"
}

# Handle mouse events
case "$SENDER" in
  "mouse.entered")
    # Show popup when hovering
    $SKETCHYBAR --set "$NAME" popup.drawing=on
    ;;
  "mouse.exited" | "mouse.exited.global")
    # Hide popup when exiting
    $SKETCHYBAR --set "$NAME" popup.drawing=off
    ;;
esac

# Process each project
for project in "${PROJECTS[@]}"; do
  process_project "$project"
done