#!/bin/bash

# Release script for Math library
# Usage: ./scripts/release.sh <commit-message> <version>
# Example: ./scripts/release.sh "Add new statistics module" 0.2.0

set -e

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <commit-message> <version>"
    echo "Example: $0 \"Add new statistics module\" 0.2.0"
    exit 1
fi

COMMIT_MESSAGE=$1
VERSION=$2
TAG="v$VERSION"

echo "🚀 Preparing release $VERSION"
echo "📝 Commit message: $COMMIT_MESSAGE"

# Check if we're on main branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" != "main" ]; then
    echo "❌ Error: Must be on main branch to release"
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

echo "📚 Building and deploying documentation..."
./scripts/deploy-docs.sh

echo "💾 Committing changes..."
git add -A
if git diff --staged --quiet; then
    echo "ℹ️  No changes to commit"
else
    git commit -m "$COMMIT_MESSAGE"
    echo "✅ Changes committed"
fi

echo "✅ Creating git tag $TAG..."
git tag -a "$TAG" -m "Release version $VERSION"

echo "✅ Pushing to GitHub..."
git push origin main
git push origin "$TAG"

echo ""
echo "🎉 Release $VERSION complete!"
echo ""
echo "What was done:"
echo "✓ Tests passed"
echo "✓ Release build successful"
echo "✓ Documentation built and deployed"
echo "✓ Changes committed with message: \"$COMMIT_MESSAGE\""
echo "✓ Tag $TAG created"
echo "✓ Pushed to GitHub"
echo ""
echo "Next steps:"
echo "1. Go to https://github.com/PinkQween/Math/releases"
echo "2. The release should be created automatically by GitHub Actions"
echo "3. Verify the release and edit if needed"
echo "4. Documentation is live at https://math.hannaskairipa.com"
echo ""
