# Release Process

This document describes the release process for the Math library.

## Versioning

We follow [Semantic Versioning](https://semver.org/) (SemVer):

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

### Pre-release versions:
- **Alpha** (`0.x.x`): Early development, API may change significantly
- **Beta** (`1.0.0-beta.x`): Feature complete, API mostly stable, testing phase
- **RC** (`1.0.0-rc.x`): Release candidate, final testing before stable

## Current Status

**Version**: 0.1.0-alpha (Initial Alpha Release)
**Status**: Ready for alpha testing
**Swift**: 6.1+
**Platforms**: macOS, Linux

## Quick Commit and Push

For regular commits (not releases), use the `commit-and-push.sh` script:

```bash
# Simple commit and push
./scripts/commit-and-push.sh "Fix bug in statistics module"

# Commit with documentation rebuild
./scripts/commit-and-push.sh "Update complex numbers tutorial" --with-docs
```

This script:
- Commits all changes with your message
- Pushes to the current branch
- Optionally rebuilds and deploys documentation (with `--with-docs` flag)

## Release Checklist

### Before Release

- [ ] All tests pass (`swift test`)
- [ ] Build succeeds (`swift build`)
- [ ] Update `CHANGELOG.md` with all changes
- [ ] Update version numbers in documentation examples
- [ ] Review and update `README.md` if needed
- [ ] Ensure all new features are documented
- [ ] Check that CI workflows pass on GitHub

### Creating a Release

We provide automated scripts to streamline the release process.

#### Using the Release Script (Recommended)

The `release.sh` script automates the entire release process:

```bash
# Usage: ./scripts/release.sh <commit-message> <version>
./scripts/release.sh "Release with new features" 0.2.0
```

This script will:
1. ✅ Run all tests
2. 🔨 Build release version
3. ✅ Check CHANGELOG.md for version entry
4. 📚 Build and deploy documentation
5. 💾 Commit all changes with your message
6. 🏷️ Create git tag
7. 🚀 Push to GitHub (main branch + tag)

**Requirements:**
- Must be on `main` branch
- CHANGELOG.md should have section for version
- All changes should be staged or saved

#### Manual Release Process

If you prefer manual control:

1. **Update Version Information**
   ```bash
   # Update CHANGELOG.md with release date and all changes
   # Add new [Unreleased] section for future changes
   ```

2. **Build Documentation**
   ```bash
   ./scripts/deploy-docs.sh
   ```

3. **Commit Changes**
   ```bash
   git add -A
   git commit -m "Release v0.2.0"
   ```

4. **Create Git Tag**
   ```bash
   git tag -a v0.2.0 -m "Release version 0.2.0"
   ```

5. **Push to GitHub**
   ```bash
   git push origin main
   git push origin v0.2.0
   ```

6. **GitHub Release (Automatic)**
   - GitHub Actions will automatically create a release
   - Go to https://github.com/PinkQween/Math/releases to verify
   - Edit the release notes if needed

### After Release

- [ ] Verify the release appears on GitHub
- [ ] Test installation via Swift Package Manager
- [ ] Announce on relevant channels (if applicable)
- [ ] Monitor for issues

## Alpha Release Notes (v0.1.0)

### What's Included
- ✅ Core arbitrary-precision arithmetic
- ✅ 50+ number properties
- ✅ 200+ units of measurement
- ✅ 70+ mathematical, physical, and astronomical constants
- ✅ Trigonometric and hyperbolic functions
- ✅ Matrix operations
- ✅ Triangle solver
- ✅ Number pronunciation
- ✅ 107 test cases (all passing)

### Known Limitations
- Some high-precision trigonometric calculations use placeholders
- Exponential/logarithm functions are slow with very large BigInt values
- Newton-Raphson iterations may not converge at extreme precision

### Feedback Welcome
This is an alpha release. We welcome feedback on:
- API design and usability
- Performance issues
- Missing features
- Documentation clarity
- Bug reports

## Future Roadmap

### v0.2.0 (Next Alpha)
- [ ] Improve performance of exp/ln functions
- [ ] Add more exotic units
- [ ] Enhanced matrix operations (determinant, inverse)
- [ ] Additional number sequences

### v0.3.0
- [ ] Complex number support
- [ ] Polynomial operations
- [ ] Statistical functions

### v1.0.0 (Stable)
- [ ] API stability guarantee
- [ ] Performance optimizations
- [ ] Comprehensive documentation
- [ ] Full test coverage

## Installation Testing

After release, verify installation works:

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/PinkQween/Math.git", from: "0.1.0")
]
```

```bash
swift package update
swift build
swift test
```

## Support

For questions or issues:
- GitHub Issues: https://github.com/PinkQween/Math/issues
- Discussions: https://github.com/PinkQween/Math/discussions
