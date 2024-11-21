#!/bin/bash

# Get the list of running Docker containers with IDs and names, and select one with fzf
container_id=$(docker ps --format "{{.ID}}: {{.Names}}" | fzf | cut -d: -f1)

# Check if a container was selected
if [ -n "$container_id" ]; then
  # Prompt for the local file to copy
  echo "Enter the path to the local file you want to copy:"
  read -r local_file

  # Check if the file exists
  if [ ! -f "$local_file" ]; then
    echo "File does not exist: $local_file"
    exit 1
  fi

  # Prompt for the target directory/path inside the container
  echo "Enter the target path inside the container (e.g., /tmp/):"
  read -r container_path

  # Copy the file into the selected container
  docker cp "$local_file" "$container_id:$container_path"

  # Confirm successful copy
  if [ $? -eq 0 ]; then
    echo "Successfully copied $local_file to $container_id:$container_path"
  else
    echo "Failed to copy the file."
  fi
else
  echo "No container selected."
fi

## Pick any image to copy into
##!/bin/bash
#
## Prompt the user to select an image using fzf
#image_name=$(docker images --format "{{.Repository}}:{{.Tag}}" | fzf)
#
## Check if an image was selected
#if [ -n "$image_name" ]; then
#  # Ask for the file path to copy into the container
#  echo "Enter the local file path to copy:"
#  read -r local_file
#
#  # Check if the file exists
#  if [ -f "$local_file" ]; then
#    # Create a temporary container from the selected image
#    container_id=$(docker create "$image_name")
#
#    # Ask for the destination path in the container
#    echo "Enter the destination path in the container:"
#    read -r container_path
#
#    # Copy the file into the container
#    docker cp "$local_file" "$container_id:$container_path"
#
#    # Clean up by removing the temporary container
#    docker rm "$container_id"
#
#    echo "File copied successfully to $container_path inside the container."
#  else
#    echo "File not found: $local_file"
#  fi
#else
#  echo "No image selected."
#fi
#
