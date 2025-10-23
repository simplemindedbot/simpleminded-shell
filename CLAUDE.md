# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **documentation and configuration repository** for "Simpleminded Shell" - a modern terminal setup using Rust-based CLI tools with transparent replacements for traditional Unix commands. This is NOT a code repository with source to build - it's a collection of installation scripts, documentation, and shell configuration guidance.

**Core Philosophy**: Use old commands you know, get new features automatically (e.g., type `cat`, get `bat` with syntax highlighting).

## Repository Structure

```
simpleminded-shell/
├── README.md              # Main overview and quick start
├── install.sh             # Interactive installation script (Bash)
└── docs/
    ├── TOOLS.md          # Detailed tool descriptions
    ├── ALIASES.md        # Complete alias reference
    ├── INSTALLATION.md   # Step-by-step install guide
    └── SUMMARY.md        # Summary document
```

## Key Commands

### Testing the Installation Script
```bash
# Test the script without actually installing
bash -n install.sh          # Check syntax

# Test in a subshell (safer)
bash install.sh

# The script is interactive - test all branches:
# - Yes/No prompts for each tool
# - Different OS detection paths
# - Existing vs new installations
```

### Viewing Current Aliases
```bash
# See all configured aliases and functions
aliases                     # Uses glow to render formatted output

# The actual aliases are defined in the user's ~/.zshrc
# This repo only provides configuration snippets
```

### Documentation Tools Used
- **glow** - Terminal markdown renderer (for `aliases` command)
- **tldr** - Quick command examples (updated via `tldr --update`)

## Development Guidelines

### When Modifying install.sh

1. **Test all conditional paths**: The script has multiple branches for:
   - macOS vs Linux
   - Tool already installed vs new installation
   - Yes/No user responses
   - Existing .zshrc vs new configuration

2. **Preserve idempotency**: Script should be safe to run multiple times
   - Check if tools already exist before installing
   - Check for configuration markers before adding to .zshrc
   - Use `SIMPLEMINDED-SHELL-CONFIG` marker to prevent duplicates

3. **Maintain consistency**: When adding a new tool:
   - Add to the tool selection section
   - Add installation logic
   - Add .zshrc configuration snippets
   - Add aliases/functions
   - Update documentation files
   - Update the cheatsheet template

### When Modifying Documentation

1. **Keep docs in sync**:
   - README.md = high-level overview
   - docs/TOOLS.md = detailed tool descriptions with install commands
   - docs/ALIASES.md = comprehensive alias reference
   - The `aliases` command output = actual runtime reference

2. **Update counts**: README.md mentions specific numbers (e.g., "80+ aliases", "11 utility functions")
   - Count actual aliases in install.sh when updating

3. **Maintain the philosophy**: All docs emphasize:
   - Transparent replacement (use old commands)
   - Zero learning curve
   - Smart defaults
   - Discoverable via `aliases` command

### Tool Categories

The setup is organized into these categories:
1. **Core CLI Tools** (Rust-based): bat, fd, ripgrep, eza
2. **TUI Applications**: lazygit, lazydocker, zellij
3. **Version Management**: mise (replaces pyenv, nvm, rbenv)
4. **Documentation**: tealdeer (tldr), glow
5. **Search & Navigation**: fzf, zoxide
6. **Data Processing**: jq
7. **AI/LLM**: ollama
8. **Optional**: starship (prompt), zsh-syntax-highlighting

## Important Implementation Details

### Alias Naming Pattern
- Original command = modern replacement (e.g., `cat='bat --paging=never'`)
- Add suffix for enhanced versions (e.g., `fda='fd -H'` for hidden files)
- Keep old behavior available (e.g., `catp='bat'` for original bat with paging)

### Shell Functions (Complex Operations)
The repo includes these utility functions:
- `search` - Interactive search with fzf and bat preview
- `ff` - Fuzzy find and edit files
- `gcb` - Git checkout branch with fzf
- `cdf` - CD with fzf preview
- `extract` - Universal archive extractor
- `backup` - Create timestamped backups
- `sizeof` - Quick directory size
- `fkill` - Interactive process killer

### Configuration Files
- User's **~/.zshrc** contains the actual configuration (not in this repo)
- This repo provides **snippets** to add to .zshrc
- The install.sh script generates and appends configuration
- A marker `# SIMPLEMINDED-SHELL-CONFIG` prevents duplicate additions

## Common Tasks

### Adding a New Tool

1. Add to install.sh tool selection (around line 150-192)
2. Add installation logic (tool will be in `${!TOOLS[@]}` array)
3. Add .zshrc configuration snippet if needed
4. Add aliases for the tool
5. Update README.md tool count and list
6. Add detailed description to docs/TOOLS.md
7. Add aliases to docs/ALIASES.md
8. Update the cheatsheet template (around line 469-531)

### Testing Changes

Since this is a shell configuration repo:
- Test install.sh in a clean environment or VM
- Verify .zshrc snippets in a test shell
- Check that all tool installations succeed
- Verify aliases work as expected after sourcing .zshrc
- Test with both existing and missing tools

### Updating Documentation

- Keep examples realistic and tested
- Show before/after comparisons when helpful
- Emphasize the "simpleminded" philosophy (easy, discoverable)
- Include both basic and power-user examples

## Platform Support

- **Primary**: macOS with Homebrew
- **Secondary**: Linux with Homebrew
- All tools are cross-platform (Rust-based or available on both)
- Windows/WSL not currently supported in install.sh

## Notes

- This repo documents a PERSONAL SETUP that others can fork/customize
- Not a distributed package - users run install.sh locally
- No build process, CI/CD, or tests
- Documentation-heavy, code-light by design
