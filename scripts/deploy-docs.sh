#!/bin/bash
set -e

echo "🔨 Building DocC documentation..."

# Build the package (optional, ensures symbols exist)
swift build --target Math

# Generate DocC documentation
xcrun docc convert Sources/Math \
    --output-path ./docs \
    --transform-for-static-hosting \
    --hosting-base-path Math

echo "✅ Documentation built successfully"

# Disable Jekyll for GitHub Pages
touch ./docs/.nojekyll

# Create index.html redirect
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
