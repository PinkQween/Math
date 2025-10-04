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

1. **Update Version Information**
   ```bash
   # Update CHANGELOG.md with release date
   # Add new [Unreleased] section for future changes
   ```

2. **Commit Changes**
   ```bash
   git add .
   git commit -m "Release v0.1.0"
   ```

3. **Create Git Tag**
   ```bash
   git tag -a v0.1.0 -m "Release version 0.1.0"
   ```

4. **Push to GitHub**
   ```bash
   git push origin main
   git push origin v0.1.0
   ```

5. **Create GitHub Release**
   - Go to: https://github.com/PinkQween/Math/releases/new
   - Select the tag: `v0.1.0`
   - Title: `v0.1.0 - Initial Alpha Release`
   - Description: Copy from CHANGELOG.md
   - Check "This is a pre-release" for alpha/beta versions
   - Click "Publish release"

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
