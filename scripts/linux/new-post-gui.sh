#!/bin/bash
# new-post-gui.sh - GUI wrapper for creating new posts on Linux
# This script shows a GUI dialog and creates a new post

cd "$(dirname "$0")/../.."

# Try different GUI dialog tools
if command -v zenity &> /dev/null; then
    POST_NAME=$(zenity --entry --title="Create New Post" --text="Enter post name:" --entry-text="")
elif command -v kdialog &> /dev/null; then
    POST_NAME=$(kdialog --inputbox "Enter post name:" "" "Create New Post")
else
    # Fallback to terminal input
    read -p "Enter post name: " POST_NAME
fi

if [ -z "$POST_NAME" ]; then
    if command -v zenity &> /dev/null; then
        zenity --error --text="Post name cannot be empty!"
    elif command -v kdialog &> /dev/null; then
        kdialog --error "Post name cannot be empty!"
    else
        echo "Error: Post name cannot be empty!"
    fi
    exit 1
fi

# Run the script
./new-post.sh "$POST_NAME"

# Show success message
if command -v zenity &> /dev/null; then
    zenity --info --text="Post created at content/posts/${POST_NAME}.md"
elif command -v kdialog &> /dev/null; then
    kdialog --msgbox "Post created at content/posts/${POST_NAME}.md"
else
    echo "Success: Post created at content/posts/${POST_NAME}.md"
fi

