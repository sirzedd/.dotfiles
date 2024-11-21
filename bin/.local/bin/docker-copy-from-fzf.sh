#!/bin/bash

# Get the list of running Docker containers with IDs and names, and select one with fzf
container_id=$(docker ps --format "{{.ID}}: {{.Names}}" | fzf | cut -d: -f1)

# Check if a container was selected
if [ -n "$container_id" ]; then
  # Prompt for the file or directory path inside the container
  echo "Enter the path to the file or directory inside the container (e.g., /path/in/container):"
  read -r container_path

  # Check if the path is provided
  if [ -z "$container_path" ]; then
    echo "No path provided."
    exit 1
  fi

  # Prompt for the destination path on the local machine
  echo "Enter the destination path on your local machine (e.g., /path/on/host):"
  read -r local_path

  # Copy the file or directory from the selected container to the local machine
  docker cp "$container_id:$container_path" "$local_path"

  # Confirm successful copy
  if [ $? -eq 0 ]; then
    echo "Successfully copied $container_id:$container_path to $local_path"
  else
    echo "Failed to copy the file."
  fi
else
  echo "No container selected."
fi

