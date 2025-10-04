# Documentation Guide

This document explains how to build, preview, and deploy the Math library documentation to GitHub Pages.

## Overview

The Math library uses **Swift-DocC** (Documentation Compiler) to generate beautiful, interactive documentation from inline code comments and dedicated documentation articles.

### Documentation Structure

```
Math/
├── Sources/Math/Math.docc/        # DocC catalog
│   ├── Math.md                    # Landing page
│   ├── Arithmetic.md              # Arithmetic guide
│   ├── Trigonometry.md            # Trigonometry guide
│   └── ...                        # Other topic pages
├── docs/                          # Generated HTML (for GitHub Pages)
├── scripts/
│   └── deploy-docs.sh             # Deployment script
└── DOCUMENTATION.md               # This file
```

## Building Documentation Locally

### Prerequisites

- Xcode 14.0+ (includes DocC)
- Swift 5.9+

### Option 1: Xcode Preview (Recommended for Development)

1. Open the package in Xcode:
   ```bash
   open Package.swift
   ```

2. Build documentation:
   - Menu: **Product** → **Build Documentation** (⌃⌘D)

3. Browse documentation in Xcode's Documentation window

### Option 2: Command Line Build

```bash
# Build for local preview
swift package generate-documentation \
    --target Math \
    --output-path ./docs-preview

# Open in browser
open ./docs-preview/documentation/math/index.html
```

### Option 3: Using Xcode's docc Command

```bash
# Preview with live reloading
docc preview Sources/Math/Math.docc \
    --fallback-display-name Math \
    --fallback-bundle-identifier com.math.Math \
    --fallback-bundle-version 1.0.0

# Opens preview server at http://localhost:8000
```

## Deploying to GitHub Pages

The library provides multiple deployment options. Choose the one that best fits your workflow.

### Quick Deploy (Using the Script)

```bash
# Run the deployment script
./scripts/deploy-docs.sh

# Then deploy using one of the options the script suggests
```

### Option 1: Git Subtree (Recommended - Preserves History)

This method maintains the commit history of your documentation.

```bash
# 1. Build documentation
./scripts/deploy-docs.sh

# 2. Commit the docs
git add docs/
git commit -m "Update documentation"

# 3. Deploy to gh-pages branch
git subtree split --prefix docs -b gh-pages
git push -f origin gh-pages:gh-pages
git branch -D gh-pages
```

**Advantages:**
- Preserves documentation history
- Works with any Git hosting service
- Full control over deployment

**Disadvantages:**
- Slightly more complex commands
- Larger repository size (history is duplicated)

### Option 2: ghp-import (Simplest - Replaces History)

This Python tool makes deployment a one-liner but replaces the gh-pages branch history each time.

```bash
# 1. Install ghp-import
pip install ghp-import

# 2. Build documentation
./scripts/deploy-docs.sh

# 3. Deploy (builds, commits, and pushes in one command)
ghp-import -n -p -f docs
```

**Advantages:**
- Single command deployment
- Automatic commit and push
- Widely used and maintained

**Disadvantages:**
- Replaces gh-pages history (not incremental)
- GitHub-specific
- Requires Python

### Option 3: Manual Deployment (Most Control)

For those who want full control over the process:

```bash
# 1. Build documentation
./scripts/deploy-docs.sh

# 2. Switch to gh-pages branch
git checkout --orphan gh-pages  # First time only
# OR
git checkout gh-pages           # Subsequent times

# 3. Clear existing content
git rm -rf .

# 4. Copy documentation
cp -r docs/* .
cp docs/.nojekyll .

# 5. Commit and push
git add .
git commit -m "Update documentation $(date +%Y-%m-%d)"
git push origin gh-pages

# 6. Return to main branch
git checkout main
```

### Option 4: GitHub Actions (Automated - Best for Teams)

Create `.github/workflows/docs.yml`:

```yaml
name: Deploy Documentation

on:
  push:
    branches: [main]
    paths:
      - 'Sources/**'
      - 'Package.swift'

jobs:
  deploy-docs:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3

      - name: Build Documentation
        run: |
          swift package --allow-writing-to-directory ./docs \
            generate-documentation --target Math \
            --disable-indexing \
            --transform-for-static-hosting \
            --hosting-base-path Math \
            --output-path ./docs

          touch ./docs/.nojekyll

          cat > ./docs/index.html << 'EOF'
          <!DOCTYPE html>
          <html>
          <head>
            <meta http-equiv="refresh" content="0; url=documentation/math/">
          </head>
          <body>
            <p>Redirecting to <a href="documentation/math/">documentation</a>...</p>
          </body>
          </html>
          EOF

      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./docs
          force_orphan: true
```

## Enabling GitHub Pages

After deploying, enable GitHub Pages in your repository settings:

1. Go to repository **Settings** → **Pages**
2. Source: **Deploy from a branch**
3. Branch: **gh-pages** / **root**
4. Click **Save**

Documentation will be available at: `https://YOUR_USERNAME.github.io/Math/`

## Writing Documentation

### Inline Documentation

Use triple-slash comments for types, functions, and properties:

```swift
/// Computes the factorial of a number.
///
/// The factorial of n (written n!) is the product of all positive
/// integers less than or equal to n.
///
/// ## Example
/// ```swift
/// let result = Math(5)~!  // 120
/// ```
///
/// - Parameter n: A non-negative integer
/// - Returns: The factorial of n
/// - Complexity: O(n)
public static postfix func ~! (x: Math) -> Math {
    // Implementation
}
```

### Documentation Articles

Create `.md` files in `Sources/Math/Math.docc/`:

```markdown
# My Topic

A brief description.

## Overview

Detailed overview with examples.

## Topics

### Subsection

- ``Math``
- ``Math/someFunction()``

## See Also

- <doc:RelatedTopic>
```

### Linking

- Link to symbols: `` ``Math`` ``
- Link to articles: `<doc:ArticleName>`
- Link to external: `[Text](https://example.com)`

## Troubleshooting

### Documentation not showing up

1. Ensure DocC catalog exists: `Sources/Math/Math.docc/Math.md`
2. Check Swift package is properly configured
3. Rebuild: `swift package clean && swift package generate-documentation`

### GitHub Pages shows 404

1. Verify `docs/.nojekyll` exists
2. Check GitHub Pages settings point to gh-pages branch
3. Wait 5-10 minutes for deployment to propagate
4. Check `docs/index.html` has correct redirect path

### Build fails

```bash
# Clean and rebuild
swift package clean
rm -rf .build
swift build
swift package generate-documentation --target Math
```

### Links broken in deployed docs

Ensure you're using the correct hosting base path:

```bash
--hosting-base-path Math  # Should match repository name
```

## Continuous Documentation

### Before Committing

```bash
# 1. Write inline documentation
# 2. Preview changes
swift package generate-documentation --target Math
open .build/documentation/math/index.html

# 3. Update articles in Math.docc/ as needed
# 4. Rebuild and verify
```

### Deployment Checklist

- [ ] All public APIs have documentation comments
- [ ] Examples compile and run correctly
- [ ] Links between topics work
- [ ] Images/assets load properly
- [ ] Build succeeds without warnings
- [ ] Preview looks good locally
- [ ] Deploy to gh-pages
- [ ] Verify on GitHub Pages

## Best Practices

1. **Document all public APIs** - Every public type, function, and property
2. **Include examples** - Show how to use the API
3. **Link related concepts** - Use See Also sections
4. **Keep it current** - Update docs with code changes
5. **Preview before deploying** - Always check locally first

## Resources

- [Swift-DocC Documentation](https://www.swift.org/documentation/docc/)
- [DocC Tutorial](https://developer.apple.com/documentation/docc)
- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Pages Docs](https://docs.github.com/en/pages)

## Support

- Issues: [GitHub Issues](https://github.com/PinkQween/Math/issues)
- Discussions: [GitHub Discussions](https://github.com/PinkQween/Math/discussions)
