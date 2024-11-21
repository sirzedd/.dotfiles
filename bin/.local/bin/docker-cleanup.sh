#!bin/bash

# Calculate disk usage for each option with error handling

# Stopped containers size
stopped_containers_size=$(docker ps -a --filter "status=exited" --format "{{.ID}}" | xargs -r docker inspect --format='{{.SizeRw}}' 2>/dev/null | awk '{s+=$1} END {printf "%.2f", s/1024/1024/1024}')

# Dangling images size
dangling_images_size=$(docker images -f "dangling=true" --format "{{.ID}}" | xargs -r docker inspect --format='{{.Size}}' 2>/dev/null | awk '{s+=$1} END {printf "%.2f", s/1024/1024/1024}')

# Unused volumes size (check for UsageData key existence)
unused_volumes_size=$(docker volume ls -qf "dangling=true" | xargs -r -I {} sh -c 'docker inspect {} --format "{{if .UsageData}}{{.UsageData.Size}}{{else}}0{{end}}"' 2>/dev/null | awk '{s+=$1} END {printf "%.2f", s/1024/1024/1024}')

# Unused networks size (Docker networks usually don't store size, so we'll estimate as 0 for simplicity)
unused_networks_size="0"

# Total system prune size from docker system df
total_system_prune_size=$(docker system df --format "{{.Reclaimable}}" | tail -n1 | awk '{print $1}')

# Define cleanup options with sizes
options=(
  "Remove stopped containers (~${stopped_containers_size:-0} GB)"
  "Remove dangling images (~${dangling_images_size:-0} GB)"
  "Remove unused volumes (~${unused_volumes_size:-0} GB)"
  "Remove unused networks (~${unused_networks_size} GB)"
  "Full system prune (all unused data, ~${total_system_prune_size:-0} GB)"
)

# Let user pick an option using fzf
selected_option=$(printf "%s\n" "${options[@]}" | fzf --prompt="Select Docker cleanup task: ")

# Run the appropriate Docker command based on the selected option
case "$selected_option" in
  "Remove stopped containers"*)
    echo "Removing stopped containers..."
    docker container prune -f
    ;;

  "Remove dangling images"*)
    echo "Removing dangling images..."
    docker image prune -f
    ;;

  "Remove unused volumes"*)
    echo "Removing unused volumes..."
    docker volume prune -f
    ;;

  "Remove unused networks"*)
    echo "Removing unused networks..."
    docker network prune -f
    ;;

  "Full system prune (all unused data)"*)
    echo "Performing full system prune..."
    docker system prune -a --volumes -f
    ;;

  *)
    echo "No option selected."
    ;;
esac

echo "Cleanup completed."
