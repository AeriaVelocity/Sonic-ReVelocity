#!/bin/bash

# Script to build Sonic Re;Velocity packages for Windows and Linux

# Exit the script if any command fails
set -e

# Function to display error messages and exit
error_exit() {
    echo "Error: $1"
    echo "$2"
    exit 1
}

# Function to display a stage of the build process
stage() {
    echo "=== $1 ==="
}

# Check if the script is running from the Sonic Re;Velocity root repository
if [ ! -d ".git" ] && [ ! -f "project.godot" ]; then
    error_exit "Not running from the Sonic Re;Velocity root repository." "Please run this script from the root of the repository."
fi

# Get full paths to the necessary directories
root_folder=$(pwd)
export_folder=$(pwd)/export
extras_folder=$(pwd)/Extras

# Change directory to the 'export' folder
stage "Changing directory to export folder"
cd "$export_folder" || error_exit "Failed to change directory to export folder." "Please check the export folder path."

# Check if the necessary files exist
for file in sonic-revelocity.pck sonic-revelocity.exe sonic-revelocity.x86_64; do
    if [ ! -f "$file" ]; then
        error_exit "$file not found." "Please open Sonic Re;Velocity in Godot Engine, navigate to Project > Export... > Export All... and choose an export mode."
    fi
done

if [ ! -f "sonic-revelocity.apk" ]; then
    echo "Warning: sonic-revelocity.apk not found. Android build is not available, but this script does not need it."
    echo "If you're releasing for Android, open Sonic Re;Velocity in Godot Engine, navigate to Project > Export... > Android > Export Project > '/path/to/Sonic-ReVelocity/export/sonic-revelocity.apk'"
fi

# Create the 'Sonic-ReVelocity-windows' and 'Sonic-ReVelocity-linux' folders
stage "Creating export folders"
mkdir -p Sonic-ReVelocity-windows || error_exit "Failed to create Sonic-ReVelocity-windows." "Please check your file permissions and paths."
mkdir -p Sonic-ReVelocity-linux || error_exit "Failed to create Sonic-ReVelocity-linux." "Please check your file permissions and paths."

# Change directory back to the root folder
stage "Changing directory to root folder"
cd "$root_folder" || error_exit "Failed to change directory to root folder." "Please check the root folder path."

# Copy the Extras folder to both
stage "Copying Extras folder"
cp -r "$extras_folder" "$export_folder/Sonic-ReVelocity-windows/" || error_exit "Failed to copy Extras folder to Sonic-ReVelocity-windows." "Please check your file permissions and paths."
cp -r "$extras_folder" "$export_folder/Sonic-ReVelocity-linux/" || error_exit "Failed to copy Extras folder to Sonic-ReVelocity-linux." "Please check your file permissions and paths."

# Check for pandoc
stage "Generating README HTML file"
if ! command -v pandoc &> /dev/null; then
    error_exit "pandoc command not found." "Please install pandoc to continue."
fi

# Generate a README.html from the README.md with GitHub Flavored Markdown
pandoc README.md -t html --embed-resources -o "$export_folder/Sonic-ReVelocity-windows/README.html" || error_exit "Failed to generate Sonic-ReVelocity-windows/README.html." "Please check your pandoc command and try again."
pandoc README.md -t html --embed-resources -o "$export_folder/Sonic-ReVelocity-linux/README.html" || error_exit "Failed to generate Sonic-ReVelocity-linux/README.html." "Please check your pandoc command and try again."

# Change directory to the 'export' folder once more
stage "Changing directory to export folder"
cd "$export_folder" || error_exit "Failed to change directory to export folder." "Please check the export folder path."

# Copy files to the appropriate directories
stage "Copying game executables"
mv sonic-revelocity.exe Sonic-ReVelocity-windows/ || error_exit "Failed to move sonic-revelocity.exe" "Please check your file permissions and paths."
mv sonic-revelocity.x86_64 Sonic-ReVelocity-linux/ || error_exit "Failed to move sonic-revelocity.x86_64" "Please check your file permissions and paths."

stage "Copying game files"
cp sonic-revelocity.pck Sonic-ReVelocity-windows/ || error_exit "Failed to copy sonic-revelocity.pck" "Please check your file permissions and paths."
cp sonic-revelocity.pck Sonic-ReVelocity-linux/ || error_exit "Failed to copy sonic-revelocity.pck" "Please check your file permissions and paths."

# Check if the zip command is available
if ! command -v zip &> /dev/null; then
    error_exit "zip command not found." "Please install zip to continue."
fi

# Zip the directories
stage "Creating game archives"
zip -r Sonic-ReVelocity-windows.zip Sonic-ReVelocity-windows/ || error_exit "Failed to zip Sonic-ReVelocity-windows." "Please check your zip command and try again."
zip -r Sonic-ReVelocity-linux.zip Sonic-ReVelocity-linux/ || error_exit "Failed to zip Sonic-ReVelocity-linux." "Please check your zip command and try again."

# Output success message
stage "Packaging complete"
echo "The following files have been created:"
echo "- Sonic-ReVelocity-windows.zip"
echo "- Sonic-ReVelocity-linux.zip"
