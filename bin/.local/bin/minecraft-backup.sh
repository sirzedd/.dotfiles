#!/bin/bash

# Define the Minecraft folder and backup folder paths
minecraft_folder="$HOME/minecraft/"
backup_folder="/media/sir/Vedia/game/minecraft-server/"

# Create a date string in the format yyyy-MM-dd
date_string=$(date +"%Y-%m-%d")

# Define the backup file name with the date
backup_file_name="minecraft-office.${date_string}.tar.gz"

# Check if the Minecraft folder exists
if [ ! -d "$minecraft_folder" ]; then
    echo "Minecraft folder not found: $minecraft_folder"
    exit 1
fi

# Change to the Minecraft folder
cd "$minecraft_folder" || exit 1

# Create the tar.gz archive
tar -cpzvf "$backup_file_name" .

# Move the backup to the specified folder
mv "$backup_file_name" "$backup_folder"

# Print a success message
echo "Backup completed: $backup_file_name moved to $backup_folder"
