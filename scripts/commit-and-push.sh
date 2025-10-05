#!/bin/bash

# Commit and push script for Math library
# Usage: ./scripts/commit-and-push.sh <commit-message> [--with-docs]
# Example: ./scripts/commit-and-push.sh "Fix bug in complex numbers"
# Example: ./scripts/commit-and-push.sh "Update documentation" --with-docs

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <commit-message> [--with-docs]"
    echo "Example: $0 \"Fix bug in complex numbers\""
    echo "Example: $0 \"Update documentation\" --with-docs"
    exit 1
fi

COMMIT_MESSAGE=$1
BUILD_DOCS=false

# Check for --with-docs flag
if [ "$2" == "--with-docs" ]; then
    BUILD_DOCS=true
fi

echo "=Ý Preparing to commit and push"
echo "Message: $COMMIT_MESSAGE"

# Check if we're on main branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" != "main" ]; then
    echo "   Warning: You are on branch '$BRANCH', not 'main'"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Build documentation if requested
if [ "$BUILD_DOCS" = true ]; then
    echo "=Ú Building documentation..."
    ./scripts/deploy-docs.sh
fi

# Check if there are changes to commit
if git diff --quiet && git diff --staged --quiet; then
    echo "9  No changes to commit"
    exit 0
fi

echo "=¾ Committing changes..."
git add -A
git commit -m "$COMMIT_MESSAGE"

echo " Changes committed successfully"
echo "=€ Pushing to GitHub..."
git push origin "$BRANCH"

echo ""
echo " Done!"
echo ""
echo "What was done:"
if [ "$BUILD_DOCS" = true ]; then
    echo " Documentation built and deployed"
fi
echo " Changes committed with message: \"$COMMIT_MESSAGE\""
echo " Pushed to branch: $BRANCH"
echo ""
