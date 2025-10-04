#!/bin/bash
set -e

echo "🔨 Building DocC documentation..."

# Build the package to ensure symbols exist
swift build --target Math

# Generate DocC documentation directly under docs/documentation/math
xcrun docc convert Sources/Math \
    --output-path ./docs/documentation/math \
    --transform-for-static-hosting \
    --hosting-base-path /documentation/math

echo "✅ Documentation built successfully"

# Disable Jekyll for GitHub Pages
touch ./docs/.nojekyll

# Optional: Create a README or index.html at root if needed for GitHub Pages
cat > ./docs/README.md << 'EOF'
# Math Documentation

The Math documentation is available [here](documentation/math/).
EOF

echo "✅ Documentation prepared for deployment"

# --- Fix generated index.html for proper base paths ---
INDEX_FILE="./docs/documentation/math/index.html"

if [ -f "$INDEX_FILE" ]; then
    echo "🔧 Updating index.html paths for hosting base"

    # Insert <base> tag after <head> open
    sed -i '' '/<head>/a\
    <base href="/documentation/math/">
    ' "$INDEX_FILE"

    # Remove leading slashes from JS and CSS paths
    sed -i '' -E 's/src="\/documentation\/math\/(js\/[^"]+)"/src="\1"/g' "$INDEX_FILE"
    sed -i '' -E 's/href="\/documentation\/math\/(css\/[^"]+)"/href="\1"/g' "$INDEX_FILE"

    echo "✅ index.html updated for correct relative paths"
else
    echo "⚠️  index.html not found at $INDEX_FILE"
fi
