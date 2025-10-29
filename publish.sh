#!/bin/bash

# Taubyte Blog - Publish Script
# Builds the site and pushes to GitHub for deployment

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

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    print_error "Not in a git repository. Please run 'git init' first."
    exit 1
fi

# Get commit message from parameter or prompt
COMMIT_MSG="$1"
if [ -z "$COMMIT_MSG" ]; then
    echo -n "Enter commit message (or press Enter for default): "
    read COMMIT_MSG
    if [ -z "$COMMIT_MSG" ]; then
        COMMIT_MSG="Update blog post $(date +"%Y-%m-%d %H:%M")"
    fi
fi

print_status "Publishing blog with commit: $COMMIT_MSG"

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    print_status "Found uncommitted changes, adding them..."
    git add .
fi

# Build the site locally to check for errors
print_status "Building site locally to check for errors..."
if ! ../hugo --minify; then
    print_error "Build failed! Please fix errors before publishing."
    exit 1
fi

print_status "Build successful! Site generated in public/"

# Commit changes
print_status "Committing changes..."
git commit -m "$COMMIT_MSG" || print_warning "No changes to commit"

# Push to GitHub
print_status "Pushing to GitHub..."
if git remote | grep -q origin; then
    git push origin main || git push origin master || {
        print_error "Failed to push to GitHub. Make sure you have set up the remote repository."
        echo ""
        echo "To set up GitHub remote:"
        echo "1. Create a new repository on GitHub"
        echo "2. Run: git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
        echo "3. Run: git push -u origin main"
        exit 1
    }
else
    print_warning "No GitHub remote found. Please add one:"
    echo "git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
    echo "git push -u origin main"
    exit 1
fi

print_status "Successfully published to GitHub! 🚀"
echo ""
print_status "If you've set up GitHub Pages or Actions, your site will be deployed automatically."
print_status "Check your repository's Actions tab for deployment status."
