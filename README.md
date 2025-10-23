# Simpleminded Shell

> A modern, powerful terminal setup that's simple to use. Stop memorizing commands - just type what feels natural.

This repository documents a complete modern shell environment built with Rust-based CLI tools, smart aliases, and TUI applications. The philosophy: **use the old commands you know, get the new features automatically.**

## 🎯 Philosophy

- **Transparent replacements**: Type `cat`, get `bat`. Type `find`, get `fd`. Zero learning curve.
- **Discoverable**: `aliases` command shows you everything available
- **Fast**: Rust-based tools are blazingly fast
- **Beautiful**: Syntax highlighting, icons, formatted output
- **Smart defaults**: Tools configured to "just work"

## 🚀 Quick Start

```bash
# Clone this repo
git clone https://github.com/yourusername/simpleminded-shell.git
cd simpleminded-shell

# Install all tools (macOS with Homebrew)
brew install bat fd ripgrep eza lazygit lazydocker zellij mise tealdeer glow fzf zoxide jq ollama

# Update tldr cache
tldr --update

# Copy configuration snippets to your ~/.zshrc (see CONFIGURATION.md)
# Then reload your shell
source ~/.zshrc
```

## 📚 Documentation

- **[TOOLS.md](docs/TOOLS.md)** - Detailed descriptions of all modern CLI tools
- **[INSTALLATION.md](docs/INSTALLATION.md)** - Step-by-step installation guide
- **[CONFIGURATION.md](docs/CONFIGURATION.md)** - Complete .zshrc configuration
- **[ALIASES.md](docs/ALIASES.md)** - All aliases and what they do
- **[FUNCTIONS.md](docs/FUNCTIONS.md)** - Utility shell functions
- **[USAGE.md](docs/USAGE.md)** - Real-world examples and workflows
- **[AI-SETUP.md](docs/AI-SETUP.md)** - Configure AI assistants (Claude, Copilot, ChatGPT, etc.) to understand your environment
- **[MCP-SERVER.md](docs/MCP-SERVER.md)** - MCP Server for automatic AI integration (recommended!)

## 🔧 What's Included

### Core Modern CLI Tools (All Rust-based)
- **bat** - Better `cat` with syntax highlighting
- **fd** - Better `find` with intuitive syntax
- **ripgrep (rg)** - Better `grep`, blazingly fast
- **eza** - Better `ls` with icons and Git integration

### TUI Applications
- **lazygit** - Visual Git interface
- **lazydocker** - Visual Docker interface  
- **zellij** - Modern terminal multiplexer (tmux alternative)

### Utilities & Tools
- **mise** - Universal version manager (replaces pyenv, nvm, rbenv, etc.)
- **tealdeer (tldr)** - Quick command examples
- **glow** - Terminal markdown renderer
- **fzf** - Fuzzy finder for everything
- **zoxide** - Smart `cd` that learns your habits
- **jq** - JSON processor
- **ollama** - Run LLMs locally

### Smart Features
- **80+ aliases** - Use old commands, get new features automatically
- **11 utility functions** - Powerful workflows with simple commands
- **Custom tldr pages** - Document your own workflows
- **Integrated tools** - Everything works together seamlessly

## 💡 Key Features

### Transparent Tool Replacement
```bash
cat file.py        # Actually runs: bat --paging=never file.py
find . -name "*.md"  # Actually runs: fd *.md
grep "pattern"     # Actually runs: rg pattern
ls                 # Actually runs: eza --color=always --group-directories-first --icons
```

### Powerful Aliases
```bash
ll                 # Detailed list with icons and git status
lg                 # Launch lazygit
ff                 # Fuzzy find files with preview
search "pattern"   # Search files with preview
z project          # Jump to frequently-used directory
```

### Documentation at Your Fingertips
```bash
aliases            # View all your aliases (beautifully formatted)
tldr docker        # Quick docker examples
cheatsh tar        # Get tar command examples
md README.md       # Render markdown in terminal
```

### AI Assistant Integration

Your setup works seamlessly with AI coding assistants!

**🔥 NEW: MCP Server (Recommended)**

Automatic AI integration via the Model Context Protocol - no manual setup needed!

```bash
# Install the MCP server
uvx simpleminded-shell-mcp

# Configure Claude Code once, then AI automatically knows your environment
```

AI assistants automatically:
- Know that `cat` runs `bat`, `grep` runs `rg`, etc.
- Translate traditional commands to your modern equivalents
- Check which tools you have installed
- Provide examples tailored to your setup

**See [MCP-SERVER.md](docs/MCP-SERVER.md)** for setup instructions.

**Alternative: Manual Setup**

Use the `aliases` command to show your environment:

```bash
aliases            # Show AI your complete environment
```

**See [AI-SETUP.md](docs/AI-SETUP.md)** for manual configuration per AI tool.

## 🎨 Examples

### Before and After

**Before (traditional commands):**
```bash
cat ~/.zshrc | grep alias
find . -type f -name "*.py"
grep -r "function" --include="*.js" .
ls -la
git status
git add .
git commit -m "message"
```

**After (with simpleminded-shell):**
```bash
cat ~/.zshrc | rg alias    # bat with syntax highlighting + ripgrep
fd -e py                   # Faster, simpler syntax
rg "function" --type js    # Much faster, colored output
ll                         # Icons, git status, beautiful
lg                         # Visual TUI for all git operations
```

## 🔍 Quick Reference

### File Operations
- `cat` → syntax-highlighted viewing
- `ll` → detailed list with icons
- `lt` → tree view
- `ff` → fuzzy find and edit files

### Search
- `rg pattern` → fast code search
- `search pattern` → search with preview
- `fd pattern` → find files

### Git
- `lg` → lazygit TUI
- `gs` → git status
- `gcb` → fuzzy checkout branch
- `gll` → visual log with diffs

### Docker
- `ld` → lazydocker TUI
- `dexec` → fuzzy select container to exec into

### Documentation
- `tldr command` → quick examples
- `aliases` → view all aliases
- `cheatsh command` → online examples

## 🤝 Contributing

This is a personal setup repository, but feel free to:
- Fork and customize for your needs
- Open issues for questions
- Submit PRs for improvements

## 📝 License

MIT License - feel free to use and modify as needed.

## 🙏 Credits

Built on the shoulders of giants:
- All the amazing Rust CLI tool developers
- The Homebrew team
- The open-source community

---

**Last Updated**: 2025-10-23

**See [TOOLS.md](docs/TOOLS.md) for detailed tool descriptions and [AI-SETUP.md](docs/AI-SETUP.md) to configure your AI assistants.**
