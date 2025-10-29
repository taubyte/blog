#!/bin/bash
# new-post.sh - Create a new blog post

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
    echo "❌ Hugo not found. Run './scripts/linux/setup.sh' first"
    exit 1
fi

if [ -z "$1" ]; then
    echo "Usage: ./scripts/new-post.sh <post-name>"
    echo "Example: ./scripts/new-post.sh my-awesome-post"
    exit 1
fi

POST_NAME="$1"
echo "📝 Creating new post: $POST_NAME"
$HUGO_CMD new content "posts/${POST_NAME}.md"

echo ""
echo "✅ Post created at: content/posts/${POST_NAME}.md"
echo "📝 Edit the file and set draft = false when ready to publish"

