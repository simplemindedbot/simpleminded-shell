# Installation Guide

Complete installation instructions for all simpleminded-shell tools.

## Prerequisites

### macOS

Install Homebrew if you don't have it:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Linux

Most tools are available via package managers. See individual tool sections below.

---

## Quick Install (All Tools)

### macOS (Homebrew)

```bash
# Core CLI tools (Rust-based)
brew install bat fd ripgrep eza

# TUI applications
brew install lazygit lazydocker zellij

# Version management
brew install mise

# Documentation & utilities
brew install tealdeer glow fzf zoxide

# Data processing & AI
brew install jq ollama

# Update tldr cache
tldr --update
```

---

## Individual Tool Installation

### Core CLI Tools

#### bat
```bash
# macOS
brew install bat

# Linux (Debian/Ubuntu)
sudo apt install bat

# Linux (Arch)
sudo pacman -S bat

# From source
cargo install bat
```

#### fd
```bash
# macOS
brew install fd

# Linux (Debian/Ubuntu)
sudo apt install fd-find

# Linux (Arch)
sudo pacman -S fd

# From source
cargo install fd-find
```

#### ripgrep
```bash
# macOS
brew install ripgrep

# Linux (Debian/Ubuntu)
sudo apt install ripgrep

# Linux (Arch)
sudo pacman -S ripgrep

# From source
cargo install ripgrep
```

#### eza
```bash
# macOS
brew install eza

# Linux (Debian/Ubuntu) - Add repository first
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install eza

# From source
cargo install eza
```

---

### TUI Applications

#### lazygit
```bash
# macOS
brew install lazygit

# Linux (Direct download)
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Arch Linux
sudo pacman -S lazygit
```

#### lazydocker
```bash
# macOS
brew install lazydocker

# Linux (Direct download)
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# From source (requires Go)
go install github.com/jesseduffield/lazydocker@latest
```

#### zellij
```bash
# macOS
brew install zellij

# Linux (Cargo)
cargo install zellij

# Linux (Direct download)
# Check https://github.com/zellij-org/zellij/releases for latest
```

---

### Version Management

#### mise
```bash
# macOS
brew install mise

# Linux (install script)
curl https://mise.run | sh

# From source
cargo install mise
```

**Post-install**: Add to your `.zshrc`:
```bash
eval "$(mise activate zsh)"
```

**Migration from pyenv**:
```bash
# mise will automatically detect pyenv installations
mise use --global python@3.12.11
# Keep pyenv installed - mise uses symlinks to pyenv's builds
```

---

### Documentation & Utilities

#### tealdeer (tldr)
```bash
# macOS
brew install tealdeer

# Linux
cargo install tealdeer

# Update cache after installation
tldr --update
```

#### glow
```bash
# macOS
brew install glow

# Linux (Go)
go install github.com/charmbracelet/glow@latest

# Linux (Debian/Ubuntu)
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update
sudo apt install glow
```

#### fzf
```bash
# macOS
brew install fzf

# Linux (Debian/Ubuntu)
sudo apt install fzf

# From Git (all platforms)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

#### zoxide
```bash
# macOS
brew install zoxide

# Linux
cargo install zoxide

# Or use install script
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

**Post-install**: Add to `.zshrc`:
```bash
eval "$(zoxide init zsh)"
```

---

### Data Processing

#### jq
```bash
# macOS
brew install jq

# Linux (Debian/Ubuntu)
sudo apt install jq

# Linux (Arch)
sudo pacman -S jq
```

---

### AI & LLMs

#### ollama
```bash
# macOS
brew install ollama

# Linux (install script)
curl -fsSL https://ollama.com/install.sh | sh

# Manual download
# Visit https://ollama.com/download
```

**Post-install**:
```bash
# Start ollama service
ollama serve

# In another terminal, pull a model
ollama pull llama2
```

---

## Optional Tools

### Starship Prompt
```bash
# macOS
brew install starship

# Linux
curl -sS https://starship.rs/install.sh | sh
```

Add to `.zshrc`:
```bash
eval "$(starship init zsh)"
```

### zsh-syntax-highlighting
```bash
# macOS
brew install zsh-syntax-highlighting

# Add to .zshrc
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

---

## Verification

After installation, verify tools are accessible:

```bash
# Check versions
bat --version
fd --version
rg --version
eza --version
lazygit --version
lazydocker --version
zellij --version
mise --version
tldr --version
glow --version
fzf --version
zoxide --version
jq --version
ollama --version

# Check if in PATH
which bat fd rg eza lazygit mise
```

---

## Configuration

After installing tools, see [CONFIGURATION.md](CONFIGURATION.md) for:
- Complete `.zshrc` setup
- Environment variables
- Shell enhancements
- Aliases and functions

---

## Troubleshooting

### Command not found

**Issue**: `command not found: bat`

**Fix**:
1. Check if installed: `brew list | grep bat`
2. Check PATH: `echo $PATH`
3. Reload shell: `source ~/.zshrc`
4. Reinstall: `brew reinstall bat`

### mise not working

**Issue**: `mise: command not found` or version not switching

**Fix**:
1. Ensure activation in `.zshrc`: `eval "$(mise activate zsh)"`
2. Check mise install: `which mise`
3. Run mise doctor: `mise doctor`
4. Check for conflicts with pyenv init (should be removed)

### tldr no cache

**Issue**: `tldr: Page not found`

**Fix**:
```bash
tldr --update
tldr --clear-cache
tldr --update
```

### Fonts/Icons not showing (eza)

**Issue**: Icons show as boxes/question marks

**Fix**: Install a Nerd Font
```bash
# macOS
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
# Then set terminal to use Hack Nerd Font
```

---

## Next Steps

1. ✅ Install all tools
2. ✅ Verify installations
3. 📝 Configure your `.zshrc` - see [CONFIGURATION.md](CONFIGURATION.md)
4. 🎨 Learn the aliases - see [ALIASES.md](ALIASES.md)
5. 🚀 Start using! - see [USAGE.md](USAGE.md)

---

**Last Updated**: 2025-10-23
