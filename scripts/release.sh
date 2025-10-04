#!/bin/bash

# Release script for Math library
# Usage: ./scripts/release.sh <version>
# Example: ./scripts/release.sh 0.1.0

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 0.1.0"
    exit 1
fi

VERSION=$1
TAG="v$VERSION"

echo "🚀 Preparing release $VERSION"

# Check if we're on main branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" != "main" ]; then
    echo "❌ Error: Must be on main branch to release"
    exit 1
fi

# Check if working directory is clean
if ! git diff-index --quiet HEAD --; then
    echo "❌ Error: Working directory is not clean. Commit or stash changes first."
    exit 1
fi

# Check if tag already exists
if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo "❌ Error: Tag $TAG already exists"
    exit 1
fi

echo "✅ Running tests..."
swift test

echo "✅ Building release..."
swift build -c release

echo "✅ Checking CHANGELOG.md..."
if ! grep -q "## \[$VERSION\]" CHANGELOG.md; then
    echo "⚠️  Warning: CHANGELOG.md doesn't contain section for version $VERSION"
    echo "   Please update CHANGELOG.md before continuing"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo "✅ Creating git tag $TAG..."
git tag -a "$TAG" -m "Release version $VERSION"

echo "✅ Pushing to GitHub..."
git push origin main
git push origin "$TAG"

echo ""
echo "🎉 Release $VERSION complete!"
echo ""
echo "Next steps:"
echo "1. Go to https://github.com/PinkQween/Math/releases"
echo "2. The release should be created automatically by GitHub Actions"
echo "3. Verify the release and edit if needed"
echo "4. Announce the release if desired"
echo ""
