#!/bin/bash

# Taubyte Blog - New Post Creator
# Usage: ./new-post.sh "Post Title" [category] [tags]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper function to print colored output
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
    echo "Usage: $0 \"Post Title\" [category] [tags]"
    echo "Example: $0 \"My New Post\" \"Tech\" \"hugo,web,tutorial\""
    exit 1
fi

TITLE="$1"
CATEGORY="${2:-General}"
TAGS="${3:-blog}"

# Generate slug from title
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
DATE=$(date +"%Y-%m-%d")
DATETIME=$(date +"%Y-%m-%dT%H:%M:%S%z")
FILENAME="content/posts/${DATE}-${SLUG}.md"

print_status "Creating new post: $TITLE"
print_status "Slug: $SLUG"
print_status "Category: $CATEGORY"
print_status "Tags: $TAGS"

# Create the post file
cat > "$FILENAME" << EOF
+++
title = '$TITLE'
date = $DATETIME
draft = false
description = "Enter a brief description of your post here"
tags = [$(echo "$TAGS" | sed 's/,/", "/g' | sed 's/^/"/;s/$/"/')]
categories = ["$CATEGORY"]
author = "Your Name"
+++

# $TITLE

Write your post content here using Markdown.

## Introduction

Start with an engaging introduction that hooks your readers.

## Main Content

Add your main content sections here.

### Subsection

Use subsections to organize your content effectively.

## Code Examples

If you're writing about technical topics, you can include code blocks:

\`\`\`bash
echo "Hello, World!"
\`\`\`

## Conclusion

Wrap up your post with a thoughtful conclusion.

---

*Happy blogging! 🚀*
EOF

print_status "Post created at: $FILENAME"
print_status "Opening post for editing..."

# Try to open with common editors
if command -v code &> /dev/null; then
    code "$FILENAME"
elif command -v nano &> /dev/null; then
    nano "$FILENAME"
elif command -v vim &> /dev/null; then
    vim "$FILENAME"
else
    print_warning "No editor found. Please edit the file manually: $FILENAME"
fi

echo ""
print_status "Next steps:"
echo "1. Edit your post content in $FILENAME"
echo "2. When ready to publish, run: ./publish.sh \"$TITLE\""
echo "3. Or use the combined workflow: ./post-and-publish.sh \"$TITLE\" \"$CATEGORY\" \"$TAGS\""
