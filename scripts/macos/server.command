#!/bin/bash
# server.command - Double-click to start development server (macOS)
# This script starts the Hugo development server

cd "$(dirname "$0")/../.."

# Open Terminal window if run from Finder
if [ -t 0 ]; then
    # Running from terminal
    exec ./server.sh
else
    # Running from Finder - open Terminal window
    osascript -e "tell application \"Terminal\" to do script \"cd '$(pwd)' && ./server.sh\""
fi

