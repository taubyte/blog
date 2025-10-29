#!/bin/bash
# new-post.command - Double-click to create a new post (macOS)
# This script prompts for post name and creates a new post

cd "$(dirname "$0")/../.."

# Prompt for post name
POST_NAME=$(osascript -e 'Tell application "System Events" to display dialog "Enter post name:" default answer "" with title "Create New Post"' -e 'text returned of result' 2>/dev/null)

if [ -z "$POST_NAME" ]; then
    osascript -e 'display alert "Error" message "Post name cannot be empty!"' 2>/dev/null
    exit 1
fi

# Run the script
./new-post.sh "$POST_NAME"

# Show success message
osascript -e "display alert \"Success\" message \"Post created at content/posts/${POST_NAME}.md\" buttons {\"OK\"}" 2>/dev/null

