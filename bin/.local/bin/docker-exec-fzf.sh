#!/bin/bash

# List running Docker containers with their IDs and names, and pass to fzf for selection
container_id=$(docker ps --format "{{.ID}}: {{.Names}}" | fzf | cut -d: -f1)

# Check if a container was selected
if [ -n "$container_id" ]; then
  # Exec into the container with a full interactive bash shell
  docker exec -it "$container_id" /bin/bash || docker exec -it "$container_id" /bin/sh
else
  echo "No container selected."
fi

