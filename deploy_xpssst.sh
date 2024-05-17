#!/bin/bash

# Check for root privileges
if [[ $(id -u) -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Set paths
SCRIPT_DIR=$(pwd)
PYTHON_SCRIPT="$SCRIPT_DIR/xpssst"
MAN_PAGE="$SCRIPT_DIR/xpssst.1"
INSTALL_DIR="/usr/local/bin"
MAN_DIR="/usr/share/man/man1"

# Check if the Python script is a file
if [[ ! -f "$PYTHON_SCRIPT" ]]; then
    echo "The specified Python script does not exist or is not a file: $PYTHON_SCRIPT"
    exit 1
fi

# Check if the man page is a file
if [[ ! -f "$MAN_PAGE" ]]; then
    echo "The specified man page does not exist or is not a file: $MAN_PAGE"
    exit 1
fi

# Copy the Python script to the specified install directory
cp "$PYTHON_SCRIPT" "$INSTALL_DIR"
if [[ $? -ne 0 ]]; then
    echo "Failed to copy Python script"
    exit 1
fi

# Make the Python script executable
chmod +x "$INSTALL_DIR/$(basename "$PYTHON_SCRIPT")"

# Ensure the target directory for the man page exists
mkdir -p "$MAN_DIR"

# Copy the man page to the appropriate man section directory
cp "$MAN_PAGE" "$MAN_DIR"
if [[ $? -ne 0 ]]; then
    echo "Failed to copy man page"
    exit 1
fi

# Update man database
mandb

echo "Deployment successful"
