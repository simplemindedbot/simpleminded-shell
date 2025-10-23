#!/usr/bin/env bash

# Simpleminded Shell - Interactive Installation Script
# This script will guide you through installing and configuring modern CLI tools

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BOLD}${BLUE}===================================${NC}"
    echo -e "${BOLD}${BLUE}$1${NC}"
    echo -e "${BOLD}${BLUE}===================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

ask_yes_no() {
    local prompt="$1"
    local default="${2:-y}"
    local response
    
    if [[ "$default" == "y" ]]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi
    
    read -p "$prompt" response
    response=${response:-$default}
    
    [[ "$response" =~ ^[Yy]$ ]]
}

ask_input() {
    local prompt="$1"
    local default="$2"
    local response
    
    if [[ -n "$default" ]]; then
        read -p "$prompt [$default]: " response
        echo "${response:-$default}"
    else
        read -p "$prompt: " response
        echo "$response"
    fi
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

# Main installation flow
main() {
    clear
    print_header "Welcome to Simpleminded Shell Setup"
    
    echo "This script will help you install and configure modern CLI tools."
    echo "It will ask for your preferences and install only what you want."
    echo ""
    echo "Press Ctrl+C at any time to cancel."
    echo ""
    
    if ! ask_yes_no "Ready to begin?"; then
        echo "Installation cancelled."
        exit 0
    fi
    
    # Detect OS
    OS=$(detect_os)
    print_info "Detected OS: $OS"
    
    # Get user info
    USERNAME=$(whoami)
    HOME_DIR="$HOME"
    
    print_header "Configuration"
    
    # Ask about cheatsheet location
    DEFAULT_CHEATSHEET="$HOME_DIR/Documents/GitHub/simpleminded-shell/aliases_cheatsheet.md"
    CHEATSHEET_PATH=$(ask_input "Where should we create the aliases cheatsheet?" "$DEFAULT_CHEATSHEET")
    
    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$CHEATSHEET_PATH")"
    
    # Ask about editor
    if command_exists code; then
        DEFAULT_EDITOR="code"
    elif command_exists vim; then
        DEFAULT_EDITOR="vim"
    else
        DEFAULT_EDITOR="nano"
    fi
    EDITOR_CHOICE=$(ask_input "Preferred editor for 'zshconfig' command?" "$DEFAULT_EDITOR")
    
    # Check for Homebrew (macOS/Linux)
    print_header "Checking Prerequisites"
    
    if [[ "$OS" == "macos" ]] || [[ "$OS" == "linux" ]]; then
        if ! command_exists brew; then
            print_warning "Homebrew not found"
            if ask_yes_no "Install Homebrew? (recommended)"; then
                print_info "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            else
                print_error "Homebrew is required for easy installation. Exiting."
                exit 1
            fi
        else
            print_success "Homebrew installed"
        fi
    fi
    
    # Tool selection
    print_header "Tool Selection"
    
    echo "Select which tools to install:"
    echo ""
    
    declare -A TOOLS
    
    # Core CLI tools
    echo "${BOLD}Core CLI Tools (Rust-based):${NC}"
    TOOLS[bat]=$(ask_yes_no "  bat (better cat with syntax highlighting)" "y" && echo "y" || echo "n")
    TOOLS[fd]=$(ask_yes_no "  fd (better find, faster)" "y" && echo "y" || echo "n")
    TOOLS[ripgrep]=$(ask_yes_no "  ripgrep (better grep, blazingly fast)" "y" && echo "y" || echo "n")
    TOOLS[eza]=$(ask_yes_no "  eza (better ls with icons)" "y" && echo "y" || echo "n")
    echo ""
    
    # TUI applications
    echo "${BOLD}TUI Applications:${NC}"
    TOOLS[lazygit]=$(ask_yes_no "  lazygit (visual Git interface)" "y" && echo "y" || echo "n")
    TOOLS[lazydocker]=$(ask_yes_no "  lazydocker (visual Docker interface)" "y" && echo "y" || echo "n")
    TOOLS[zellij]=$(ask_yes_no "  zellij (terminal multiplexer)" "y" && echo "y" || echo "n")
    echo ""
    
    # Version management
    echo "${BOLD}Version Management:${NC}"
    TOOLS[mise]=$(ask_yes_no "  mise (universal version manager)" "y" && echo "y" || echo "n")
    echo ""
    
    # Documentation & utilities
    echo "${BOLD}Documentation & Utilities:${NC}"
    TOOLS[tealdeer]=$(ask_yes_no "  tealdeer (tldr - quick command examples)" "y" && echo "y" || echo "n")
    TOOLS[glow]=$(ask_yes_no "  glow (terminal markdown renderer)" "y" && echo "y" || echo "n")
    TOOLS[fzf]=$(ask_yes_no "  fzf (fuzzy finder)" "y" && echo "y" || echo "n")
    TOOLS[zoxide]=$(ask_yes_no "  zoxide (smart cd)" "y" && echo "y" || echo "n")
    echo ""
    
    # Data & AI
    echo "${BOLD}Data Processing & AI:${NC}"
    TOOLS[jq]=$(ask_yes_no "  jq (JSON processor)" "y" && echo "y" || echo "n")
    TOOLS[ollama]=$(ask_yes_no "  ollama (run LLMs locally)" "n" && echo "y" || echo "n")
    echo ""
    
    # Optional enhancements
    echo "${BOLD}Optional Enhancements:${NC}"
    TOOLS[starship]=$(ask_yes_no "  starship (customizable prompt)" "y" && echo "y" || echo "n")
    TOOLS[zsh-syntax-highlighting]=$(ask_yes_no "  zsh-syntax-highlighting" "y" && echo "y" || echo "n")
    echo ""
    
    # Installation
    print_header "Installing Tools"
    
    INSTALLED_TOOLS=()
    FAILED_TOOLS=()
    
    for tool in "${!TOOLS[@]}"; do
        if [[ "${TOOLS[$tool]}" == "y" ]]; then
            if command_exists "$tool" || command_exists "${tool//-/_}"; then
                print_success "$tool already installed"
                INSTALLED_TOOLS+=("$tool")
            else
                print_info "Installing $tool..."
                if brew install "$tool" >/dev/null 2>&1; then
                    print_success "$tool installed"
                    INSTALLED_TOOLS+=("$tool")
                else
                    print_error "Failed to install $tool"
                    FAILED_TOOLS+=("$tool")
                fi
            fi
        fi
    done
    
    # Post-installation tasks
    print_header "Post-Installation"
    
    # Update tldr cache if installed
    if [[ " ${INSTALLED_TOOLS[@]} " =~ " tealdeer " ]]; then
        print_info "Updating tldr cache..."
        tldr --update >/dev/null 2>&1 && print_success "tldr cache updated"
    fi
    
    # Configure .zshrc
    print_header "Configuring .zshrc"
    
    ZSHRC="$HOME_DIR/.zshrc"
    BACKUP="$ZSHRC.backup.$(date +%Y%m%d_%H%M%S)"
    
    if [[ -f "$ZSHRC" ]]; then
        if ask_yes_no "Backup existing .zshrc to $BACKUP?"; then
            cp "$ZSHRC" "$BACKUP"
            print_success "Backup created: $BACKUP"
        fi
    fi
    
    if ask_yes_no "Add simpleminded-shell configuration to .zshrc?"; then
        print_info "Adding configuration..."
        
        # Create marker to avoid duplicate additions
        MARKER="# SIMPLEMINDED-SHELL-CONFIG"
        
        if grep -q "$MARKER" "$ZSHRC" 2>/dev/null; then
            print_warning "Configuration already exists in .zshrc"
        else
            cat >> "$ZSHRC" << EOFZSHRC

# ============================================================================
$MARKER
# Added by simpleminded-shell installer on $(date)
# ============================================================================

# --- Environment Variables ---
EOFZSHRC

            # Add bat configuration if installed
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " bat " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'

# bat: Use as default pager for man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p --style=plain'"
export BAT_THEME="Monokai Extended"
EOFZSHRC
            fi
            
            # Add fzf configuration if installed
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " fzf " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'

# fzf: Use fd for file searching
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
EOFZSHRC
            fi
            
            # Add mise activation if installed
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " mise " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'

# mise: Universal version manager
eval "$(mise activate zsh)"
EOFZSHRC
            fi
            
            # Add zoxide activation if installed
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " zoxide " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'

# zoxide: Smart cd
eval "$(zoxide init zsh)"
EOFZSHRC
            fi
            
            # Add fzf source if installed
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " fzf " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'

# fzf: Fuzzy finder
source <(fzf --zsh)
EOFZSHRC
            fi
            
            # Add starship if installed
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " starship " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'

# Starship: Modern prompt
eval "$(starship init zsh)"
EOFZSHRC
            fi
            
            # Add syntax highlighting if installed
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " zsh-syntax-highlighting " ]]; then
                if [[ "$OS" == "macos" ]]; then
                    cat >> "$ZSHRC" << 'EOFZSHRC'

# Syntax highlighting (load last)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
EOFZSHRC
                fi
            fi
            
            # Add aliases
            cat >> "$ZSHRC" << EOFZSHRC

# --- Aliases ---
EOFZSHRC

            # bat aliases
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " bat " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'
alias cat='bat --paging=never'
alias catp='bat'
alias less='bat'
alias more='bat'
alias bathelp='bat --list-themes'
alias batp='bat --style=plain'
EOFZSHRC
            fi
            
            # fd aliases
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " fd " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'
alias find='fd'
alias fda='fd -H'
alias fdall='fd -HI'
EOFZSHRC
            fi
            
            # ripgrep aliases
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " ripgrep " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'
alias grep='rg'
alias rga='rg -uuu'
alias rgi='rg -i'
alias rgf='rg --files | rg'
alias rgc='rg --count'
alias rgl='rg --files-with-matches'
alias rgv='rg --invert-match'
alias rgw='rg --word-regexp'
alias rgt='rg --type-list'
alias rgpy='rg --type py'
alias rgjs='rg --type js'
alias rgmd='rg --type md'
EOFZSHRC
            fi
            
            # eza aliases
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " eza " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
alias ldir='eza -D --icons'
alias ldira='eza -Da --icons'
EOFZSHRC
            fi
            
            # Git/Docker TUI aliases
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " lazygit " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'
alias lg='lazygit'
EOFZSHRC
            fi
            
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " lazydocker " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'
alias ld='lazydocker'
EOFZSHRC
            fi
            
            # Git shortcuts
            cat >> "$ZSHRC" << 'EOFZSHRC'
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
EOFZSHRC
            
            # tldr aliases
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " tealdeer " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'
alias tl='tldr'
alias tlup='tldr --update'
alias tll='tldr --list'
EOFZSHRC
            fi
            
            # jq aliases
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " jq " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'
alias jqp='jq -C | less -R'
alias jqr='jq -r'
alias jqc='jq -c'
alias jqs='jq -S'
alias jqk='jq "keys"'
alias jqv='jq "values"'
alias jql='jq "length"'
EOFZSHRC
            fi
            
            # ollama aliases
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " ollama " ]]; then
                cat >> "$ZSHRC" << 'EOFZSHRC'
alias ol='ollama'
alias olls='ollama list'
alias olrun='ollama run'
alias olpull='ollama pull'
alias olrm='ollama rm'
alias olps='ollama ps'
EOFZSHRC
            fi
            
            # glow alias
            if [[ " ${INSTALLED_TOOLS[@]} " =~ " glow " ]]; then
                cat >> "$ZSHRC" << EOFZSHRC
alias md='glow -p'
alias aliases='glow -p $CHEATSHEET_PATH'
alias cheat='glow -p $CHEATSHEET_PATH'
EOFZSHRC
            fi
            
            # Utility aliases
            cat >> "$ZSHRC" << EOFZSHRC
alias reload='source ~/.zshrc'
alias zshconfig='${EDITOR_CHOICE} ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'

# End of simpleminded-shell configuration
# ============================================================================
EOFZSHRC
            
            print_success "Configuration added to .zshrc"
        fi
    fi
    
    # Create aliases cheatsheet
    if ask_yes_no "Create aliases cheatsheet at $CHEATSHEET_PATH?"; then
        print_info "Creating cheatsheet..."
        mkdir -p "$(dirname "$CHEATSHEET_PATH")"
        
        cat > "$CHEATSHEET_PATH" << 'EOFCHEAT'
# Simpleminded Shell - Aliases Cheatsheet

Quick reference for your modern CLI tool aliases.

## File Viewing & Searching

```bash
cat file.txt         # bat with syntax highlighting
less file.py         # bat with paging
find "*.py"          # fd (faster, respects .gitignore)
grep "pattern"       # ripgrep (much faster)
```

## File Listing

```bash
ls                   # eza with icons
ll                   # detailed list
lt                   # tree view
ldir                 # directories only
```

## Git

```bash
lg                   # lazygit (visual interface)
g                    # git
gs                   # git status
ga .                 # git add .
gc -m "msg"          # git commit
gp                   # git push
```

## Documentation

```bash
tl docker            # tldr examples
md README.md         # render markdown
aliases              # this cheatsheet!
```

## JSON

```bash
cat data.json | jqp  # pretty-print
jqr '.field' file    # raw output
jqk file.json        # show keys
```

## Quick Commands

```bash
reload               # reload .zshrc
zshconfig            # edit .zshrc
..                   # cd up one level
...                  # cd up two levels
```

---

Run `aliases` anytime to view this cheatsheet!
EOFCHEAT
        print_success "Cheatsheet created"
    fi
    
    # Final summary
    print_header "Installation Complete!"
    
    echo "${BOLD}Summary:${NC}"
    echo ""
    echo "  ${GREEN}✓${NC} Installed ${#INSTALLED_TOOLS[@]} tools"
    
    if [[ ${#FAILED_TOOLS[@]} -gt 0 ]]; then
        echo "  ${RED}✗${NC} Failed to install ${#FAILED_TOOLS[@]} tools: ${FAILED_TOOLS[*]}"
    fi
    
    echo ""
    echo "${BOLD}Next Steps:${NC}"
    echo ""
    echo "  1. Reload your shell:"
    echo "     ${BLUE}source ~/.zshrc${NC}"
    echo ""
    echo "  2. View your aliases:"
    echo "     ${BLUE}aliases${NC}"
    echo ""
    echo "  3. Try some commands:"
    echo "     ${BLUE}cat ~/.zshrc${NC}  (uses bat)"
    echo "     ${BLUE}find *.md${NC}     (uses fd)"
    echo "     ${BLUE}grep TODO${NC}     (uses ripgrep)"
    echo ""
    
    if [[ " ${INSTALLED_TOOLS[@]} " =~ " ollama " ]]; then
        echo "  4. For ollama, start the service and pull a model:"
        echo "     ${BLUE}ollama serve${NC}  (in one terminal)"
        echo "     ${BLUE}ollama pull llama2${NC}  (in another)"
        echo ""
    fi
    
    echo "${BOLD}Documentation:${NC}"
    echo "  GitHub: https://github.com/yourusername/simpleminded-shell"
    echo "  Cheatsheet: $CHEATSHEET_PATH"
    echo ""
    
    if ask_yes_no "Reload shell now?"; then
        exec zsh
    fi
}

# Run main function
main
