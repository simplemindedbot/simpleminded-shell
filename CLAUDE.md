# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **documentation and configuration repository** for "Simpleminded Shell" - a modern terminal setup using Rust-based CLI tools with transparent replacements for traditional Unix commands. The repository has two main components:

1. **Shell configuration and documentation** (root) - Installation scripts, docs, and shell setup guides
2. **MCP Server** (mcp-server/) - Python package that exposes shell environment to AI assistants

**Core Philosophy**: Use old commands you know, get new features automatically (e.g., type `cat`, get `bat` with syntax highlighting).

## Repository Structure

```
simpleminded-shell/
├── install.sh             # Interactive installation script (Bash)
├── README.md              # Main overview and quick start
├── docs/                  # Documentation files
│   ├── TOOLS.md          # Detailed tool descriptions
│   ├── ALIASES.md        # Complete alias reference
│   ├── INSTALLATION.md   # Step-by-step install guide
│   ├── AI-SETUP.md       # Manual AI assistant configuration
│   └── MCP-SERVER.md     # MCP server setup guide
└── mcp-server/           # Python MCP server package
    ├── src/
    │   ├── server.py              # Main MCP server implementation
    │   ├── config_parser.py       # Auto-detect shell config
    │   ├── alias_detector.py      # Parse aliases from shell config
    │   ├── command_translator.py  # Translate traditional→modern commands
    │   ├── tool_checker.py        # Check tool installation status
    │   └── example_provider.py    # Provide usage examples
    ├── tests/             # Pytest test suite
    ├── pyproject.toml     # Python package configuration
    └── README.md          # MCP server documentation
```

## Common Development Tasks

### Testing the Installation Script

```bash
# Check syntax without executing
bash -n install.sh

# Test in a subshell (safer)
bash install.sh
```

The script is interactive - test all branches (yes/no prompts, OS detection, tool installation paths).

### Working with the MCP Server

```bash
# Navigate to MCP server directory
cd mcp-server

# Install in development mode with dependencies
uv pip install -e ".[dev]"

# Run tests
uv run pytest

# Run tests with verbose output
uv run pytest -v

# Run specific test file
uv run pytest tests/test_alias_detector.py

# Run the server locally
python -m src.server
# Or use the entry point
simpleminded-mcp
```

### Code Quality Checks

```bash
cd mcp-server

# Format code with Black
uv run black src/ tests/

# Check formatting without modifying
uv run black --check src/ tests/

# Type checking with mypy
uv run mypy src/

# Run all checks (what CI runs)
uv run black --check src/ tests/
uv run mypy src/
uv run pytest
```

### Building and Publishing

```bash
cd mcp-server

# Build package
uv build --python 3.13

# Verify package
uvx twine check dist/*

# Test locally before publishing
uv pip install -e .
simpleminded-mcp
```

## Architecture Overview

### Shell Configuration Layer

The `install.sh` script is the main entry point for users. It:
- Detects OS (macOS/Linux) via `detect_os()`
- Interactively prompts for tool selection (stored in `TOOLS` associative array)
- Installs tools via Homebrew
- Appends configuration to `~/.zshrc` with a `SIMPLEMINDED-SHELL-CONFIG` marker
- Creates an aliases cheatsheet at a user-specified location

**Key Implementation Details:**
- Uses marker `# SIMPLEMINDED-SHELL-CONFIG` to prevent duplicate configuration on re-runs
- Configuration is idempotent - safe to run multiple times
- Checks for existing tool installation before attempting install
- Creates timestamped backups of .zshrc before modification

### MCP Server Architecture

The MCP server provides programmatic access to shell environment for AI assistants.

**Component Responsibilities:**

1. **config_parser.py** - Auto-detects shell config file by checking standard locations (~/.zshrc, ~/.bashrc, etc.) and looking for the `SIMPLEMINDED-SHELL-CONFIG` marker

2. **alias_detector.py** - Parses shell aliases from configuration file, extracting alias definitions and categorizing them

3. **command_translator.py** - Translates traditional Unix commands to modern equivalents (e.g., `grep -r "pattern"` → `rg "pattern"`)

4. **tool_checker.py** - Checks if tools are installed and retrieves version information using `command -v` and version flags

5. **example_provider.py** - Provides usage examples for tools, organized by use case and tool category

6. **server.py** - Main MCP server that exposes resources (read-only config/status) and tools (interactive translation/checking)

**MCP Resources Provided:**
- `simpleminded://config/info` - Configuration location
- `simpleminded://aliases/all` - All shell aliases
- `simpleminded://tools/status` - Tool installation status
- `simpleminded://examples/all` - Usage examples

**MCP Tools Provided:**
- `translate_command` - Convert traditional → modern command
- `check_tool` - Check tool installation and version
- `get_examples` - Get usage examples for a tool
- `explain_alias` - Explain what an alias does
- `recommend_tools` - Get tool recommendations for a task

## Tool Categories

The setup organizes tools into categories (used throughout docs and install.sh):

1. **Core CLI Tools** (Rust-based): bat, fd, ripgrep, eza
2. **TUI Applications**: lazygit, lazydocker, zellij
3. **Version Management**: mise (replaces pyenv, nvm, rbenv)
4. **Documentation**: tealdeer (tldr), glow
5. **Search & Navigation**: fzf, zoxide
6. **Data Processing**: jq
7. **AI/LLM**: ollama
8. **Optional**: starship (prompt), zsh-syntax-highlighting

## Alias Naming Pattern

Consistent pattern used in install.sh and documented in docs:
- Original command = modern replacement (e.g., `cat='bat --paging=never'`)
- Add suffix for enhanced versions (e.g., `fda='fd -H'` for hidden files)
- Keep original tool behavior available (e.g., `catp='bat'` for bat with paging)

## Testing and CI/CD

### GitHub Actions Workflows

**test.yml** - Runs on push to main and PRs:
- Tests across Python 3.10, 3.11, 3.12, 3.13
- Runs pytest suite
- Code quality checks: Black formatting, mypy type checking
- Note: mypy has `continue-on-error: true` (type checking is advisory)

**publish.yml** - Runs on version tags (v*):
- Builds package with `uv build`
- Verifies with twine
- Publishes to PyPI using Trusted Publishing
- Working directory: `mcp-server/`

### Running Tests Like CI

```bash
cd mcp-server

# Mimic CI test job
uv run pytest

# Mimic CI lint job
uv run black --check src/ tests/
uv run mypy src/  # May have errors (continue-on-error in CI)
```

## Configuration Files

- User's **~/.zshrc** contains actual shell configuration (not in this repo)
- This repo provides **snippets** that install.sh appends to .zshrc
- The `SIMPLEMINDED-SHELL-CONFIG` marker prevents duplicate configuration
- MCP server reads from this configuration to provide context to AI

## Python Package Details

**Package name**: `simplemindedshellmcp`
**Entry point**: `simpleminded-mcp` command (runs `src.server:main`)
**Python version**: Requires Python 3.10+
**Dependencies**: `mcp>=0.1.0`
**Dev dependencies**: pytest, pytest-asyncio, black, mypy

**Type checking configuration**:
- Uses mypy with `disallow_untyped_defs = true`
- All functions should have type hints
- `mypy src/` should pass (though CI allows failures during development)

**Code formatting**:
- Black with line length 100
- Target Python 3.10, 3.11, 3.12

## Important Implementation Notes

### When Modifying install.sh

1. **Test all conditional paths**: OS detection, tool existence checks, yes/no prompts
2. **Preserve idempotency**: Check before adding to .zshrc, check tool installation before attempting
3. **Update documentation counts**: README.md mentions "80+ aliases", "11 utility functions" - count and update when adding features
4. **Maintain consistency**: When adding a new tool, update all locations:
   - Tool selection prompts (line ~150-192)
   - Installation logic (line ~200-216)
   - .zshrc configuration snippets
   - Aliases section
   - Cheatsheet template (line ~469-531)
   - docs/TOOLS.md
   - docs/ALIASES.md

### When Modifying MCP Server

1. **Maintain type hints**: All functions must have type annotations
2. **Update tests**: Add test coverage for new functionality
3. **Resources vs Tools**: Resources are read-only data, Tools are interactive functions
4. **Keep components modular**: Each module (config_parser, alias_detector, etc.) has a single responsibility

## Platform Support

- **Primary**: macOS with Homebrew
- **Secondary**: Linux with Homebrew
- All tools are cross-platform (Rust-based or available on both)
- Windows/WSL not currently supported in install.sh
- MCP server is platform-agnostic (Python 3.10+)

## Publishing Workflow

1. Update version in `mcp-server/pyproject.toml`
2. Commit changes
3. Create and push tag: `git tag v0.5.0 && git push origin v0.5.0`
4. GitHub Actions automatically builds and publishes to PyPI
5. Verify at https://pypi.org/project/simplemindedshellmcp/

## Notes

- This is a PERSONAL SETUP repository that others can fork/customize
- Not a distributed application - users run install.sh locally
- Documentation-heavy, code-light by design (except MCP server)
- The MCP server is the only "code" component requiring tests and CI/CD
