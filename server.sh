#!/bin/bash
# server.sh - Start Hugo development server

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BLOG_DIR="$SCRIPT_DIR/.."

cd "$BLOG_DIR"

# Find Hugo binary
if command -v hugo &> /dev/null; then
    HUGO_CMD="hugo"
elif [ -f "../bin/hugo" ]; then
    HUGO_CMD="../bin/hugo"
elif [ -f "./bin/hugo" ]; then
    HUGO_CMD="./bin/hugo"
else
    echo "❌ Hugo not found. Run 'make setup' or './scripts/setup.sh' first"
    exit 1
fi

echo "🚀 Starting Hugo development server..."
echo "📍 Local: http://localhost:1313/blog/"
echo "🌐 Network: http://0.0.0.0:1313/blog/"
echo ""
echo "Press Ctrl+C to stop"
echo ""

$HUGO_CMD server --bind=0.0.0.0 --port=1313

