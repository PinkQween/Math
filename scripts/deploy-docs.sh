#!/bin/bash

# Deploy documentation to GitHub Pages
# This script builds DocC documentation and deploys it to gh-pages branch

set -e  # Exit on error

echo "🔨 Building DocC documentation..."

# Build documentation
swift package --allow-writing-to-directory ./docs \
    generate-documentation --target Math \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path Math \
    --output-path ./docs

echo "✅ Documentation built successfully"

echo "📝 Creating .nojekyll file (disables Jekyll processing)..."
touch ./docs/.nojekyll

echo "📄 Creating index.html redirect..."
cat > ./docs/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Redirecting to Math Documentation</title>
    <meta http-equiv="refresh" content="0; url=documentation/math/">
    <link rel="canonical" href="documentation/math/">
</head>
<body>
    <p>Redirecting to <a href="documentation/math/">Math Documentation</a>...</p>
</body>
</html>
EOF

echo "✅ Documentation prepared for deployment"
echo ""
echo "📤 To deploy to GitHub Pages, run ONE of the following:"
echo ""
echo "Option 1 - Using git subtree (preserves history):"
echo "  git add docs/"
echo "  git commit -m \"Update documentation\""
echo "  git subtree split --prefix docs -b gh-pages"
echo "  git push -f origin gh-pages:gh-pages"
echo "  git branch -D gh-pages"
echo ""
echo "Option 2 - Using ghp-import (simpler, but replaces history):"
echo "  pip install ghp-import"
echo "  ghp-import -n -p -f docs"
echo ""
echo "Option 3 - Manual deployment:"
echo "  1. git checkout gh-pages"
echo "  2. git rm -rf ."
echo "  3. cp -r docs/* ."
echo "  4. git add ."
echo "  5. git commit -m \"Update documentation\""
echo "  6. git push origin gh-pages"
echo "  7. git checkout main"
echo ""
echo "After deployment, documentation will be available at:"
echo "https://YOUR_USERNAME.github.io/Math/"
