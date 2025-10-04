# Quick Release Guide

## TL;DR - Release Checklist

For a quick release of version `X.Y.Z`:

```bash
# 1. Make sure everything is ready
swift test                    # All tests must pass
swift build -c release       # Must build successfully

# 2. Update CHANGELOG.md
# - Add release date to version section
# - Create new [Unreleased] section at top

# 3. Commit and run release script
git add .
git commit -m "Prepare release vX.Y.Z"
./scripts/release.sh X.Y.Z
```

That's it! The GitHub Action will handle creating the release automatically.

---

## Detailed Steps

### 1. Pre-Release Checks

```bash
# Ensure you're on main branch
git checkout main
git pull origin main

# Run all tests
swift test

# Build in release mode
swift build -c release

# Check for uncommitted changes
git status
```

### 2. Update CHANGELOG.md

Edit `CHANGELOG.md`:

```markdown
# Changelog

## [Unreleased]
<!-- New section for future changes -->

## [X.Y.Z] - 2025-10-04

### Added
- New feature 1
- New feature 2

### Fixed
- Bug fix 1

### Changed
- Breaking change 1 (if any)
```

### 3. Commit Changes

```bash
git add CHANGELOG.md
git commit -m "Prepare release vX.Y.Z"
git push origin main
```

### 4. Create Release

Option A - Use the script (recommended):
```bash
./scripts/release.sh X.Y.Z
```

Option B - Manual:
```bash
git tag -a vX.Y.Z -m "Release version X.Y.Z"
git push origin main
git push origin vX.Y.Z
```

### 5. Verify Release

1. Go to https://github.com/PinkQween/Math/actions
2. Watch the "Release" workflow complete
3. Check https://github.com/PinkQween/Math/releases
4. Edit release notes if needed

### 6. Test Installation

```bash
# Create a test project
mkdir test-math
cd test-math
swift package init --type executable

# Add dependency
cat > Package.swift << EOF
// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "test-math",
    dependencies: [
        .package(url: "https://github.com/PinkQween/Math.git", from: "X.Y.Z")
    ],
    targets: [
        .executableTarget(name: "test-math", dependencies: ["Math"])
    ]
)
EOF

# Test it works
swift package update
swift build
```

## Version Numbers

- **Alpha** (0.x.x): Early development, expect breaking changes
- **Beta** (1.0.0-beta.x): Feature-complete, minimal API changes
- **RC** (1.0.0-rc.x): Release candidate, final testing
- **Stable** (1.0.0+): Production-ready, semantic versioning

### Current Version: 0.1.0 (Alpha)

Next releases:
- 0.1.1 - Bug fixes only
- 0.2.0 - New features (backward compatible if possible)
- 1.0.0-beta.1 - First beta (when API is stable)
- 1.0.0 - First stable release

## Troubleshooting

**Q: Tag already exists**
```bash
# Delete local tag
git tag -d vX.Y.Z

# Delete remote tag
git push origin :refs/tags/vX.Y.Z
```

**Q: Need to fix something after tagging**
```bash
# Delete the tag and redo
git tag -d vX.Y.Z
git push origin :refs/tags/vX.Y.Z

# Make fixes
git add .
git commit -m "Fix for release"

# Re-run release
./scripts/release.sh X.Y.Z
```

**Q: GitHub Action failed**
- Check https://github.com/PinkQween/Math/actions
- Fix the issue
- Re-run the workflow or delete/recreate the tag

## Post-Release

- [ ] Announce on relevant channels
- [ ] Update any documentation sites
- [ ] Monitor for issues
- [ ] Respond to GitHub issues/discussions
