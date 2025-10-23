# Complete Alias Reference

All aliases configured in simpleminded-shell, organized by category.

## Quick Command Reference

Type `aliases` in your terminal to view the formatted cheatsheet anytime.

---

## Table of Contents

- [File Viewing & Searching](#file-viewing--searching)
- [File Listing (eza)](#file-listing-eza)
- [Git Tools](#git-tools)
- [Docker Tools](#docker-tools)
- [Directory Navigation](#directory-navigation)
- [Version Management (mise)](#version-management-mise)
- [Documentation Tools](#documentation-tools)
- [JSON Processing (jq)](#json-processing-jq)
- [AI/LLM (ollama)](#aillm-ollama)
- [System Tools](#system-tools)
- [Quick Tools & Utilities](#quick-tools--utilities)

---

## File Viewing & Searching

### bat (Better cat)

```bash
cat='bat --paging=never'           # Syntax-highlighted cat (replaces cat)
catp='bat'                         # bat with paging
less='bat'                         # Use bat for less
more='bat'                         # Use bat for more

# bat helpers
bathelp='bat --list-themes'        # List available color themes
batp='bat --style=plain'           # bat without line numbers/git decorations
batdiff='bat --diff'               # Show git diff with syntax highlighting
```

**Usage:**
```bash
cat config.py                      # View file with syntax highlighting
catp long-file.log                 # View with paging
bathelp                            # See available themes
batdiff                            # View git changes
```

---

### fd (Better find)

```bash
find='fd'                          # Modern find replacement

# fd helpers
fda='fd -H'                        # fd including hidden files
fdall='fd -HI'                     # fd including hidden AND ignored files
```

**Usage:**
```bash
find "*.py"                        # Find Python files (uses fd)
fda config                         # Find including hidden files
fdall node_modules                 # Search even in ignored directories
```

---

### ripgrep (Better grep)

```bash
grep='rg'                          # ripgrep instead of grep

# ripgrep helpers
rga='rg -uuu'                      # ripgrep all (no ignores, hidden, binary)
rgi='rg -i'                        # Case-insensitive ripgrep
rgf='rg --files | rg'              # Search filenames with ripgrep
rgc='rg --count'                   # Count matches per file
rgl='rg --files-with-matches'      # Only show filenames with matches
rgn='rg --line-number'             # Show line numbers (default anyway)
rgv='rg --invert-match'            # Invert match (like grep -v)
rgw='rg --word-regexp'             # Match whole words only
rgt='rg --type-list'               # List supported file types
rgpy='rg --type py'                # Search only Python files
rgjs='rg --type js'                # Search only JavaScript files
rgmd='rg --type md'                # Search only Markdown files
```

**Usage:**
```bash
grep "pattern"                     # Search with ripgrep
rgi "pattern"                      # Case-insensitive search
rgpy "function"                    # Search only in Python files
rgc "TODO"                         # Count TODOs per file
rgl "import"                       # List files containing imports
rgt                                # See all supported file types
```

---

## File Listing (eza)

```bash
ls='eza --color=always --group-directories-first --icons'
ll='eza -la --icons --octal-permissions --group-directories-first'
l='eza -bGF --header --git --color=always --group-directories-first --icons'
llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons'
la='eza --long --all --group --group-directories-first'
lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'
lS='eza -1 --color=always --group-directories-first --icons'
lt='eza --tree --level=2 --color=always --group-directories-first --icons'
l.="eza --group-directories-first --icons -a | grep -E '^\.'"
ldir='eza -D --icons'              # List only directories
ldira='eza -Da --icons'            # List all directories (including hidden)
tree='eza --tree'                  # Tree view with eza
```

**Usage:**
```bash
ls                                 # Basic listing with icons
ll                                 # Detailed list with permissions
llm                                # List sorted by modification time
lt                                 # Tree view (2 levels)
ldir                               # Show only directories
l.                                 # Show hidden files only
```

---

## Git Tools

```bash
lg='lazygit'                       # Git TUI
g='git'                            # Quick git
gs='git status'                    # Git status
ga='git add'                       # Git add
gc='git commit'                    # Git commit
gp='git push'                      # Git push
gl='git pull'                      # Git pull
gd='git diff'                      # Git diff
glog='git log --oneline --graph --decorate'  # Pretty git log
```

**Usage:**
```bash
lg                                 # Open lazygit TUI
gs                                 # Check status
ga .                               # Stage all files
gc -m "message"                    # Commit
gp                                 # Push
glog                               # View commit history
```

---

## Docker Tools

```bash
ld='lazydocker'                    # Docker TUI
dps='docker ps'                    # List containers
dimg='docker images'               # List images
```

**Usage:**
```bash
ld                                 # Open lazydocker TUI
dps                                # See running containers
dimg                               # See available images
```

---

## Directory Navigation

```bash
..='cd ..'                         # Up one directory
...='cd ../..'                     # Up two directories
....='cd ../../..'                 # Up three directories
.....='cd ../../../..'             # Up four directories
~='cd ~'                           # Go to home directory
-='cd -'                           # Go to previous directory
```

**Usage:**
```bash
..                                 # Go up one level
...                                # Go up two levels
-                                  # Go back to previous directory
```

---

## Version Management (mise)

```bash
mup='mise upgrade'                 # Upgrade mise itself
mls='mise list'                    # List installed tools
mi='mise install'                  # Install a tool
mu='mise use'                      # Use a tool version
mc='mise current'                  # Show current versions
```

**Usage:**
```bash
mls                                # See installed versions
mi python@3.12                     # Install Python 3.12
mu python@3.12                     # Use Python 3.12 for this directory
mc                                 # See what versions are active
```

---

## Documentation Tools

### tldr

```bash
tl='tldr'                          # Short alias for tldr
tlup='tldr --update'               # Update tldr cache
tll='tldr --list'                  # List all available pages
tlclear='tldr --clear-cache'       # Clear tldr cache
```

**Usage:**
```bash
tl docker                          # Quick docker examples
tlup                               # Update the cache
tll                                # See all available commands
```

### Markdown & Help

```bash
aliases='glow -p ~/Documents/GitHub/idea2job/zsh_aliases_cheatsheet.md'
cheat='glow -p ~/Documents/GitHub/idea2job/zsh_aliases_cheatsheet.md'
md='glow -p'                       # View any markdown file with formatting
cheatsh='curl cheat.sh'            # Online cheatsheets
howto='curl cheat.sh'              # Same as cheatsh
```

**Usage:**
```bash
aliases                            # View your complete alias cheatsheet
cheat                              # Same as aliases
md README.md                       # Render markdown beautifully
cheatsh tar                        # Get tar examples from web
```

---

## JSON Processing (jq)

```bash
jqp='jq -C | less -R'              # Pretty-print JSON with color and paging
jqr='jq -r'                        # Raw output (no quotes)
jqc='jq -c'                        # Compact output (one line)
jqs='jq -S'                        # Sort keys
jqk='jq "keys"'                    # Show only keys
jqv='jq "values"'                  # Show only values
jql='jq "length"'                  # Get length of array/object
```

**Usage:**
```bash
cat data.json | jqp                # Pretty-print with paging
curl api.com/data | jqr '.name'    # Extract field as raw text
jqk config.json                    # Show all keys
jqs messy.json                     # Sort and format JSON
jql array.json                     # Count items
```

---

## AI/LLM (ollama)

```bash
ol='ollama'                        # Short alias
olls='ollama list'                 # List installed models
olrun='ollama run'                 # Run a model
olpull='ollama pull'               # Pull a model
olrm='ollama rm'                   # Remove a model
olps='ollama ps'                   # List running models
olserve='ollama serve'             # Start ollama service
```

**Usage:**
```bash
olls                               # See installed models
olpull llama2                      # Download llama2
olrun llama2                       # Start chat with llama2
olps                               # See what's running
olrm modelname                     # Remove a model
```

---

## System Tools

```bash
reload='source ~/.zshrc'           # Reload shell configuration
zshconfig='${EDITOR:-code} ~/.zshrc'  # Edit zsh config
zshrc='${EDITOR:-code} ~/.zshrc'   # Edit this file (duplicate)
path='echo $PATH | tr ":" "\n"'    # Show PATH entries on separate lines
ports='lsof -i -P -n | rg LISTEN'  # Show listening ports
```

**Usage:**
```bash
reload                             # Apply .zshrc changes
zshconfig                          # Edit your .zshrc
path                               # See PATH in readable format
ports                              # See what's listening on network
```

---

## Quick Tools & Utilities

```bash
# File Management
rm='echo "Use trash instead! (or \\rm to override)"'  # Prevent accidental rm
trash='trash-put'                  # Safe delete (if trash-cli installed)

# Productivity
h='history | rg'                   # Search history with ripgrep
myip='curl -s ifconfig.me'         # Get public IP
sizeof='du -sh'                    # Quick size of directory
weather='curl wttr.in'             # Quick weather
qr='qrencode -t ansiutf8'          # Generate QR code in terminal

# Python/Development
py='python'                        # Quick python
ipy='ipython'                      # IPython if installed
jn='jupyter notebook'              # Jupyter notebook
serve='python -m http.server'      # Quick HTTP server

# fzf Integration
preview="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
```

**Usage:**
```bash
h "docker"                         # Search command history for docker
myip                               # What's my public IP?
sizeof ~/Downloads                 # How big is Downloads?
weather                            # Get weather forecast
serve                              # Start web server in current dir
preview                            # Fuzzy find files with preview
```

---

## System Monitoring (Optional Tools)

These aliases use tools that may not be installed:

```bash
top='btm'                          # Use bottom instead of top
ps='procs'                         # Use procs instead of ps
du='dust'                          # Use dust instead of du
```

---

## Tips

### View All Aliases
```bash
alias                              # See all defined aliases
alias | grep git                   # Find git-related aliases
type ls                            # See what ls actually runs
```

### Bypass an Alias
```bash
\cat file.txt                      # Use original cat, not bat
\rm file.txt                       # Use original rm (dangerous!)
command ls                         # Use original ls
```

### Create Your Own Aliases

Add to `~/.zshrc` in the SECTION 8: ALIASES area:

```bash
# My custom aliases
alias myalias='command'
```

Then reload:
```bash
reload
```

---

## See Also

- [FUNCTIONS.md](FUNCTIONS.md) - Utility shell functions
- [TOOLS.md](TOOLS.md) - Detailed tool descriptions
- [CONFIGURATION.md](CONFIGURATION.md) - Complete .zshrc setup

---

**Last Updated**: 2025-10-23
