#!/bin/bash

# Target directory (user's directory)
TARGET_DIR="~/.mcode"
TARGET_DIR_EXPANDED=$(eval echo "$TARGET_DIR")

# Determine the correct source directory for mcode files
# Always use the directory containing this script as the base
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR="$SCRIPT_DIR"

echo "Script directory: $SCRIPT_DIR"
echo "Source directory: $SOURCE_DIR"

# Check if target directory exists, create if not
if [ ! -d "$TARGET_DIR_EXPANDED" ]; then
    echo "Target directory does not exist, creating..."
    mkdir -p "$TARGET_DIR_EXPANDED"
    if [ $? -ne 0 ]; then
        echo "Error: Cannot create target directory"
        exit 1
    fi
    echo "Target directory created successfully"
fi

# Check if mcode subdirectory exists, remove if it does
MCODE_DIR="$TARGET_DIR_EXPANDED/mcode"
if [ -d "$MCODE_DIR" ]; then
    echo "Existing mcode directory found, removing..."
    rm -rf "$MCODE_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Cannot remove existing mcode directory"
        exit 1
    fi
    echo "Existing mcode directory removed successfully"
fi

# Create mcode subdirectory in target
mkdir -p "$MCODE_DIR"

# Copy only the contents of the source directory to target
# This ensures we only copy mcode files, not other project files
echo "Copying mcode files from $SOURCE_DIR to $MCODE_DIR..."
cp -r "$SOURCE_DIR"/* "$MCODE_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Cannot copy mcode files"
    exit 1
fi

echo "Operation completed: mcode files successfully copied to $TARGET_DIR/mcode"

