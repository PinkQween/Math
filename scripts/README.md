# Scripts

Automation scripts for the Math library.

## Available Scripts

### =€ release.sh

Automated release script that handles the complete release process.

**Usage:**
```bash
./scripts/release.sh <commit-message> <version>
```

**Example:**
```bash
./scripts/release.sh "Add new statistics features" 0.2.0
```

**What it does:**
1.  Runs all tests (`swift test`)
2. =( Builds release version (`swift build -c release`)
3.  Checks CHANGELOG.md for version entry
4. =Ú Builds and deploys documentation
5. =¾ Commits all changes with your commit message
6. <÷ Creates git tag (e.g., `v0.2.0`)
7. =€ Pushes to GitHub (main branch + tag)

**Requirements:**
- Must be on `main` branch
- CHANGELOG.md should contain `## [version]` section
- All changes should be saved

**Output:**
- Creates tag like `v0.2.0`
- Pushes code and documentation
- GitHub Actions automatically creates release

---

### =¾ commit-and-push.sh

Quick commit and push script for regular development work.

**Usage:**
```bash
./scripts/commit-and-push.sh <commit-message> [--with-docs]
```

**Examples:**
```bash
# Simple commit and push
./scripts/commit-and-push.sh "Fix bug in complex numbers"

# Commit with documentation rebuild
./scripts/commit-and-push.sh "Update API documentation" --with-docs
```

**What it does:**
- Stages all changes (`git add -A`)
- Commits with your message
- Pushes to current branch
- Optionally rebuilds documentation (with `--with-docs`)

**Flags:**
- `--with-docs`: Rebuilds and deploys documentation before committing

**Note:** Works on any branch, not just `main`

---

### =Ú deploy-docs.sh

Builds and deploys DocC documentation to the `docs/` directory.

**Usage:**
```bash
./scripts/deploy-docs.sh
```

**What it does:**
1. =( Builds documentation using `xcodebuild docbuild`
2. =æ Copies `.doccarchive` to `docs/` directory
3.  Adds CNAME file for custom domain
4.  Adds `.nojekyll` for GitHub Pages
5. =Ý Prepares files for git commit

**Output:**
- `docs/` directory ready for deployment
- Documentation will be live at `math.hannaskairipa.com` after push

**Note:** This script is automatically called by `release.sh` and `commit-and-push.sh --with-docs`

---

## Workflow Examples

### Regular Development

```bash
# Make changes to code
vim Sources/Math/Core/Complex.swift

# Test your changes
swift test

# Commit and push
./scripts/commit-and-push.sh "Improve complex number performance"
```

### Documentation Updates

```bash
# Update documentation
vim Sources/Math/Math.docc/ComplexNumbers.md

# Commit and push with documentation rebuild
./scripts/commit-and-push.sh "Update complex numbers tutorial" --with-docs
```

### Creating a Release

```bash
# 1. Update CHANGELOG.md
vim CHANGELOG.md
# Add ## [0.2.0] - 2025-10-05 section

# 2. Run release script
./scripts/release.sh "Release v0.2.0 with statistics module" 0.2.0

# 3. Wait for GitHub Actions to create the release
# 4. Visit https://github.com/PinkQween/Math/releases
```

---

## Script Requirements

All scripts require:
- macOS with Xcode installed
- Swift 6.1+
- Git configured
- GitHub repository access

For documentation building:
- `xcodebuild` available in PATH
- DocC support (included with Xcode)

---

## Troubleshooting

### "Error: Could not find Math.doccarchive"

The documentation build may have failed. Try:
```bash
swift clean
swift build
./scripts/deploy-docs.sh
```

### "Error: Must be on main branch to release"

The release script only works on the `main` branch:
```bash
git checkout main
./scripts/release.sh "Your message" 0.2.0
```

### "Error: Tag vX.X.X already exists"

The version you're trying to release already has a tag:
```bash
# View existing tags
git tag

# Use a different version number
./scripts/release.sh "Your message" 0.3.0
```

### Changes not appearing on website

After pushing, GitHub Pages takes 2-5 minutes to deploy:
- Visit: https://github.com/PinkQween/Math/actions
- Wait for "pages build and deployment" to complete
- Check: https://math.hannaskairipa.com

---

## Contributing

When adding new scripts:
1. Make them executable: `chmod +x scripts/your-script.sh`
2. Add usage instructions at the top
3. Use `set -e` to exit on errors
4. Provide helpful error messages
5. Update this README

---

## See Also

- [RELEASE.md](../RELEASE.md) - Full release process documentation
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines
- [CHANGELOG.md](../CHANGELOG.md) - Version history
