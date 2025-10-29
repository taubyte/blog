#!/bin/bash
# setup.command - Double-click to install Hugo (macOS)
# This script sets up Hugo for the blog

cd "$(dirname "$0")/../.."

# Open Terminal window if run from Finder
if [ -t 0 ]; then
    # Running from terminal
    exec ./setup.sh
else
    # Running from Finder - open Terminal window
    osascript -e "tell application \"Terminal\" to do script \"cd '$(pwd)' && ./setup.sh && echo '' && echo 'Press any key to close...' && read -n 1\""
fi

