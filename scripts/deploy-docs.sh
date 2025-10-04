#!/bin/bash
set -e

echo "🔨 Building DocC documentation..."

# Build the package to ensure symbols exist
swift build --target Math

# Generate DocC documentation directly under docs/documentation/math
xcrun docc convert Sources/Math \
    --output-path ./docs/documentation/math \
    --transform-for-static-hosting \
    --hosting-base-path documentation/math

echo "✅ Documentation built successfully"

# Disable Jekyll for GitHub Pages
touch ./docs/.nojekyll

# Optional: Create a README or index.html at root if needed for GitHub Pages,
# but do NOT redirect via meta refresh (breaks JS/CSS paths)
cat > ./docs/README.md << 'EOF'
# Math Documentation

The Math documentation is available [here](documentation/math/).
EOF

echo "✅ Documentation prepared for deployment"
