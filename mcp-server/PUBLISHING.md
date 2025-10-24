# Publishing to PyPI

**Modern automated publishing guide for 2025** using PyPI Trusted Publishers and GitHub Actions.

## Overview

This guide uses **PyPI Trusted Publishers** - the modern, secure way to publish Python packages. No API tokens, no secrets to manage. Just push a git tag and GitHub Actions automatically publishes to PyPI using OpenID Connect (OIDC) authentication.

**Benefits over traditional API tokens:**
- ✅ No long-lived credentials to secure
- ✅ No secrets to rotate or manage
- ✅ Automatic authentication via GitHub
- ✅ Better audit trail
- ✅ Industry best practice (2025)

## Quick Start

The publishing workflow is fully automated:

```bash
# 1. Update version in pyproject.toml
# 2. Commit changes
git add mcp-server/pyproject.toml
git commit -m "Bump version to 0.5.1"

# 3. Create and push tag
git tag v0.5.1
git push origin main --tags

# 4. GitHub Actions automatically builds and publishes to PyPI
# 5. Done! Package is live on PyPI within minutes
```

## Prerequisites

### 1. PyPI Account
- Create account at https://pypi.org
- Verify email
- **Enable 2FA** (required for publishing)

### 2. GitHub Repository
- Public repository (required for Trusted Publishers)
- Repository: `simplemindedbot/simpleminded-shell`
- Default branch: `main`

### 3. Tools Installed Locally
```bash
# uv (for building and testing)
curl -LsSf https://astral.sh/uv/install.sh | sh

# gh CLI (for repository management)
brew install gh
```

## Setup Instructions

### Step 1: Configure PyPI Trusted Publisher

**For first-time publishing (Pending Publisher):**

1. Go to https://pypi.org/manage/account/publishing/
2. Click "Add a new pending publisher"
3. Fill in the form:
   - **PyPI Project Name:** `simplemindedshellmcp`
   - **Owner:** `simplemindedbot`
   - **Repository name:** `simpleminded-shell`
   - **Workflow name:** `publish.yml`
   - **Environment name:** `pypi`
4. Click "Add"

This reserves the package name and authorizes your GitHub repository to publish it.

**For existing packages:**

1. Go to your project page: https://pypi.org/project/simplemindedshellmcp/
2. Click "Manage" → "Publishing"
3. Click "Add a new publisher"
4. Fill in the same information as above

### Step 2: Create GitHub Environment

1. Go to your repository settings: https://github.com/simplemindedbot/simpleminded-shell/settings/environments
2. Click "New environment"
3. Name it: `pypi`
4. Configure protection rules (optional but recommended):
   - ✅ Required reviewers (for extra safety)
   - ✅ Wait timer (gives you time to cancel bad releases)

### Step 3: Add GitHub Actions Workflow

The workflow file `.github/workflows/publish.yml` should already be in your repository. Here's what it does:

```yaml
name: Publish to PyPI

on:
  push:
    tags:
      - 'v*'

jobs:
  publish:
    name: Build and publish to PyPI
    runs-on: ubuntu-latest
    environment:
      name: pypi
    permissions:
      id-token: write  # Required for Trusted Publishing
      contents: read

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up uv
        uses: astral-sh/setup-uv@v6
        with:
          enable-cache: true

      - name: Install Python
        run: uv python install 3.13

      - name: Build package
        run: uv build --python 3.13
        working-directory: mcp-server

      - name: Verify package
        run: |
          uvx twine check mcp-server/dist/*

      - name: Publish to PyPI
        run: uv publish
        working-directory: mcp-server
```

**Key points:**
- ✅ Triggers only on version tags (`v*`)
- ✅ Uses `pypi` environment for protection
- ✅ `id-token: write` permission enables Trusted Publishing
- ✅ Uses latest `uv` for fast, reliable builds
- ✅ No secrets or tokens needed

## Versioning

Follow [Semantic Versioning](https://semver.org/):
- **MAJOR** (X.0.0): Breaking changes
- **MINOR** (0.X.0): New features, backward compatible
- **PATCH** (0.0.X): Bug fixes

Update version in `mcp-server/pyproject.toml`:
```toml
[project]
version = "0.5.0"
```

## Publishing a Release

### 1. Pre-Release Checklist

- [ ] All tests passing (`pytest` in mcp-server/)
- [ ] Version updated in `pyproject.toml`
- [ ] CHANGELOG updated (if you maintain one)
- [ ] README is accurate
- [ ] No sensitive data in code
- [ ] Committed to main branch

### 2. Create and Push Tag

```bash
# Ensure you're on main and up to date
git checkout main
git pull

# Create annotated tag (recommended)
git tag -a v0.5.0 -m "Release version 0.5.0"

# Push tag to GitHub (triggers workflow)
git push origin v0.5.0

# Or push all tags
git push --tags
```

### 3. Monitor Release

```bash
# Watch the GitHub Actions workflow
gh run list --limit 3
gh run watch

# Or visit: https://github.com/simplemindedbot/simpleminded-shell/actions
```

### 4. Verify Publication

```bash
# Wait 2-5 minutes for PyPI to index

# Check PyPI page
open https://pypi.org/project/simplemindedshellmcp/

# Test installation
uv pip install simplemindedshellmcp

# Test with uvx (recommended usage)
uvx simplemindedshellmcp --help
```

## Testing Before Release

### Local Testing

```bash
# Install in development mode
cd simpleminded-shell/mcp-server
uv pip install -e .

# Run tests
pytest

# Test entry point
simpleminded-mcp --help

# Uninstall
uv pip uninstall simplemindedshellmcp
```

### Build Testing

```bash
# Build locally
cd mcp-server
uv build

# Check package contents
tar -tzf dist/simpleminded_shell_mcp-*.tar.gz
unzip -l dist/simpleminded_shell_mcp-*.whl

# Verify package metadata
uvx twine check dist/*

# Test installation from local build
uv pip install dist/simpleminded_shell_mcp-*.whl
```

### TestPyPI Testing (Optional)

If you want to test on TestPyPI first:

1. Create TestPyPI account: https://test.pypi.org
2. Set up a separate pending publisher
3. Modify workflow to publish to TestPyPI:
   ```yaml
   - name: Publish to TestPyPI
     run: uv publish --publish-url https://test.pypi.org/legacy/
   ```
4. Test installation:
   ```bash
   uv pip install --index-url https://test.pypi.org/simple/ simplemindedshellmcp
   ```

## Troubleshooting

### "File already exists" Error

**Cause:** You're trying to publish a version that already exists on PyPI.

**Solution:** Increment the version number in `pyproject.toml` and create a new tag.

```bash
# Delete local tag if needed
git tag -d v0.5.0
git push origin :refs/tags/v0.5.0

# Create new version
# Edit pyproject.toml: version = "0.5.1"
git commit -am "Bump to 0.5.1"
git tag v0.5.1
git push origin main --tags
```

### Trusted Publisher Not Configured

**Error:** `Trusted publishing exchange failure`

**Solution:** Verify your PyPI Trusted Publisher settings:
- Go to https://pypi.org/manage/account/publishing/
- Check that all fields match exactly:
  - Repository: `simplemindedbot/simpleminded-shell`
  - Workflow: `publish.yml`
  - Environment: `pypi`

### Permission Denied Error

**Error:** `OpenID Connect token retrieval failed`

**Solution:** Check workflow permissions:
```yaml
permissions:
  id-token: write  # Must be present
  contents: read
```

### Build Failures

```bash
# Check locally first
cd mcp-server
uv build --verbose

# Common issues:
# - Missing dependencies in pyproject.toml
# - Invalid package structure
# - Python version incompatibility
```

### Package Not Found After Publishing

**Wait time:** PyPI indexing can take 2-10 minutes.

**Check status:**
```bash
# Check if version is live
curl -s https://pypi.org/pypi/simplemindedshellmcp/json | jq '.info.version'

# Check all versions
curl -s https://pypi.org/pypi/simplemindedshellmcp/json | jq '.releases | keys'
```

## Branch Protection

Recommended GitHub branch protection rules for `main`:

```bash
# Configure via gh CLI
gh api repos/simplemindedbot/simpleminded-shell/branches/main/protection \
  --method PUT \
  --field required_pull_request_reviews=null \
  --field enforce_admins=true \
  --field required_linear_history=true \
  --field allow_force_pushes=false \
  --field allow_deletions=false
```

Or configure in UI:
- https://github.com/simplemindedbot/simpleminded-shell/settings/branches
- ✅ Require linear history
- ✅ Block force pushes
- ✅ Block branch deletion

## Manual Publishing (Not Recommended)

If you need to publish manually without GitHub Actions:

```bash
# Build package
cd mcp-server
uv build

# Configure PyPI credentials
export TWINE_USERNAME="__token__"
export TWINE_PASSWORD="pypi-YOUR_API_TOKEN_HERE"

# Publish
uv publish

# Or use twine directly
uvx twine upload dist/*
```

**Note:** Manual publishing requires traditional API tokens and is less secure than Trusted Publishers. Only use this for testing or emergency situations.

## Automated Release Process (Advanced)

For fully automated releases with changelog generation:

```bash
# Install release tools
uv pip install python-semantic-release

# Configure in pyproject.toml
[tool.semantic_release]
version_variable = "pyproject.toml:version"
branch = "main"
upload_to_pypi = false  # Let GitHub Actions handle this

# Auto-generate release from commits
semantic-release version
semantic-release changelog
```

## Resources

### Official Documentation
- **PyPI Trusted Publishers:** https://docs.pypi.org/trusted-publishers/
- **uv Publishing Guide:** https://docs.astral.sh/uv/guides/package/
- **GitHub Actions:** https://docs.github.com/en/actions
- **Python Packaging:** https://packaging.python.org/

### Workflow Examples
- **uv + GitHub Actions:** https://docs.astral.sh/uv/guides/integration/github/
- **PyPA Publish Action:** https://github.com/pypa/gh-action-pypi-publish

### Tools
- **uv:** https://github.com/astral-sh/uv
- **gh CLI:** https://cli.github.com/
- **Semantic Versioning:** https://semver.org/

## Support

For issues:
- **PyPI:** https://pypi.org/help/
- **GitHub Issues:** https://github.com/simplemindedbot/simpleminded-shell/issues
- **uv Discord:** https://discord.gg/astral-sh

---

**Last Updated:** 2025-10-23
**Current Version:** 0.5.0
