#!/bin/bash

# Taubyte Blog - One-Command Post and Publish
# Creates a new post and immediately publishes it to GitHub

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if title is provided
if [ -z "$1" ]; then
    print_error "Please provide a post title"
    echo "Usage: $0 \"Post Title\" [category] [tags] [commit_message]"
    echo "Example: $0 \"My New Post\" \"Tech\" \"hugo,web\" \"Add new tech post\""
    exit 1
fi

TITLE="$1"
CATEGORY="${2:-General}"
TAGS="${3:-blog}"
COMMIT_MSG="${4:-Add new post: $TITLE}"

print_status "🚀 Starting one-command post and publish workflow"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Step 1: Create the post
print_status "📝 Step 1: Creating new post..."
if ! ./new-post.sh "$TITLE" "$CATEGORY" "$TAGS"; then
    print_error "Failed to create post"
    exit 1
fi

# Generate filename for later reference
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
DATE=$(date +"%Y-%m-%d")
FILENAME="content/posts/${DATE}-${SLUG}.md"

echo ""
print_status "📝 Post created successfully!"
print_warning "⏸️  PAUSE: Please edit your post content now."
echo "File location: $FILENAME"
echo ""
echo "When you're done editing:"
echo "1. Save and close your editor"
echo "2. Press ENTER to continue with publishing"
echo "3. Or press Ctrl+C to cancel publishing"

read -p "Press ENTER when ready to publish..." dummy

# Step 2: Publish to GitHub
print_status "🚀 Step 2: Publishing to GitHub..."
if ! ./publish.sh "$COMMIT_MSG"; then
    print_error "Failed to publish to GitHub"
    print_warning "Your post was created but not published. You can publish later with:"
    echo "./publish.sh \"$COMMIT_MSG\""
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
print_status "🎉 SUCCESS! Your post has been created and published!"
echo ""
print_status "📄 Post: $TITLE"
print_status "📁 File: $FILENAME"
print_status "🏷️  Category: $CATEGORY"
print_status "🔖 Tags: $TAGS"
print_status "💬 Commit: $COMMIT_MSG"
echo ""
print_status "🌐 Your blog will be deployed automatically via GitHub Actions"
print_status "📊 Check deployment status at: https://github.com/YOUR_USERNAME/YOUR_REPO/actions"
echo ""
print_status "Happy blogging! 🚀✨"
