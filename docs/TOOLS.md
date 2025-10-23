# Modern CLI Tools Reference

Complete descriptions of all tools included in simpleminded-shell.

## Table of Contents

- [Core CLI Tools](#core-cli-tools) (Rust-based)
- [TUI Applications](#tui-applications)
- [Version Management](#version-management)
- [Documentation & Learning](#documentation--learning)
- [Search & Navigation](#search--navigation)
- [Data Processing](#data-processing)
- [AI & LLMs](#ai--llms)

---

## Core CLI Tools

### bat - Better `cat`

**Install:** `brew install bat`

A `cat` clone with syntax highlighting and Git integration.

**What it does:**
- Syntax highlighting for 200+ languages
- Git integration shows additions/deletions in files
- Automatic paging for long files
- Line numbers and grid display
- Multiple file concatenation
- Theme support for different color schemes
- Works as MANPAGER for beautiful man pages

**Why it's better:**
- Instant syntax highlighting without opening an editor
- See Git changes inline while viewing files
- Easier to read code in terminal
- Automatic paging when output is long
- Beautiful themes (Monokai, Dracula, etc.)

**Common usage:**
```bash
bat file.py                    # View with syntax highlighting
bat file1.js file2.js          # View multiple files
bat --style=plain file.txt     # Plain output (no decorations)
bat --diff file.py             # Show git diff
bat -A file.sh                 # Show all characters (tabs, line endings)
```

---

### fd - Better `find`

**Install:** `brew install fd`

A simple, fast alternative to `find` with intuitive syntax.

**What it does:**
- Intuitive syntax (no `-name` flags needed)
- Fast parallel directory traversal
- Smart defaults (respects `.gitignore` by default)
- Colored output for better visibility
- Regular expression and glob pattern search
- Hidden file support with `-H` flag
- Execute commands on results

**Why it's better:**
- `fd pattern` vs `find . -name '*pattern*'`  
- 10x faster than `find` on large directories
- Sensible defaults (automatically skips `.git`, `node_modules`)
- Better error messages and user-friendly
- Faster regex matching

**Common usage:**
```bash
fd pattern                     # Find files matching pattern
fd -e py                       # Find all Python files
fd -H config                   # Include hidden files
fd -t d project                # Find directories only (-t f for files)
fd -e js --exec wc -l          # Execute command on results
fd . /path/to/search           # Search in specific directory
```

---

### ripgrep (rg) - Better `grep`

**Install:** `brew install ripgrep`

Recursively search directories for regex patterns - lightning fast.

**What it does:**
- Lightning-fast code search (faster than grep, ag, ack)
- Respects `.gitignore` by default
- Multiline search support
- Full Unicode support
- Search inside compressed files (zip, gz)
- Automatic smart case (lowercase = case-insensitive)
- File type filtering
- Replace mode (with `--replace`)

**Why it's better:**
- 10-100x faster than `grep -r` on large codebases
- Colored output with context lines
- Ignores binary files automatically
- Search inside archives without extracting
- Better regex support (Rust regex engine)
- Shows file types with `--type-list`

**Common usage:**
```bash
rg "pattern"                   # Basic search
rg -i "pattern"                # Case-insensitive
rg "pattern" --type py         # Search only Python files
rg "pattern" -g "*.md"         # Search only markdown files
rg -l "pattern"                # Only list filenames with matches
rg -c "pattern"                # Count matches per file
rg -v "pattern"                # Invert match (show non-matching lines)
rg -w "word"                   # Match whole words only
rg -A 3 -B 3 "pattern"         # Show 3 lines context before/after
```

---

### eza - Better `ls`

**Install:** `brew install eza`

A modern replacement for `ls` with beautiful output and Git integration.

**What it does:**
- Beautiful icons for file types (requires Nerd Font)
- Git integration (shows modified/staged status)
- Tree view built-in (`--tree`)
- Colored output by file type
- Extended attributes display
- Octal permissions display
- Multiple sort options (name, size, modified, etc.)
- Grid, long, and tree layouts

**Why it's better:**
- Visual file type recognition with icons
- See Git status without running `git status`
- Better default color schemes
- More readable permissions display
- Tree view without installing separate `tree` command
- Shows file metadata in human-readable format

**Common usage:**
```bash
eza                            # Basic listing with icons
eza -l                         # Long format
eza -la                        # Long format with hidden files
eza --tree                     # Tree view
eza --tree --level=3           # Tree with depth limit
eza -la --git                  # Show git status
eza -lbGd --git --sort=modified  # Sort by modified time
eza -D                         # List only directories
```

---

## TUI Applications

### lazygit - Visual Git Interface

**Install:** `brew install lazygit`

A simple terminal UI for git commands - no more memorizing git syntax.

**What it does:**
- Visual representation of branches and commits
- Stage/unstage files with arrow keys and spacebar
- Commit, push, pull with simple keybindings
- Resolve merge conflicts visually
- Interactive rebase made easy
- Stash management
- Branch switching and creation
- Diff viewer built-in
- Cherry-pick commits
- Amend commits easily

**Why it's better:**
- No memorizing complex git commands
- See your repo state at a glance
- Faster workflow than typing commands
- Safe (shows what will happen before doing it)
- Visual conflict resolution
- Learning tool (shows git commands it runs)

**Key commands:**
- `Enter` - View details/diffs
- `Space` - Stage/unstage
- `c` - Commit
- `P` - Push
- `p` - Pull
- `n` - New branch
- `m` - Merge
- `r` - Rebase
- `?` - Help

---

### lazydocker - Visual Docker Interface

**Install:** `brew install lazydocker`

A simple terminal UI for docker and docker-compose.

**What it does:**
- Dashboard view of containers, images, volumes, networks
- Real-time container stats (CPU, memory, network usage)
- View logs with live updates and search
- Start/stop/restart/remove containers
- Exec into containers with shell access
- Inspect container/image details
- Remove containers/images/volumes with bulk operations
- Docker Compose support (up/down/restart services)
- Prune unused resources
- View environment variables

**Why it's better:**
- See all containers/images at a glance
- Live log viewing without memorizing `docker logs -f`
- Resource monitoring built-in
- Faster than typing docker commands
- Visual representation of container relationships
- No need to remember container IDs

**Key commands:**
- `Tab` - Switch between sections
- `Enter` - View details/logs
- `d` - Remove
- `r` - Restart
- `e` - Exec into container
- `s` - Stop/start
- `?` - Help

---

### zellij - Terminal Multiplexer

**Install:** `brew install zellij`

A modern alternative to tmux with better discoverability.

**What it does:**
- Split terminal into multiple panes
- Create multiple tabs
- Session management (detach/reattach)
- Layout system for organizing panes
- Plugin support
- Mouse support out of the box
- Status bar with keybinding hints
- Floating panes
- Copy mode with vim keybindings

**Why it's better than tmux:**
- Discoverability (shows keybindings on screen)
- Modern UI with sensible defaults
- Easier configuration (YAML/KDL)
- Better mouse support
- No prefix key needed for basic operations
- Floating panes for temporary windows

**Common usage:**
```bash
zellij                         # Start new session
zellij -s name                 # Start named session
zellij attach                  # Attach to most recent session
zellij list-sessions           # List all sessions
zellij kill-session name       # Kill a session
```

**Key commands:**
- `Ctrl+p` then `n` - New pane
- `Ctrl+p` then `x` - Close pane
- `Ctrl+p` then arrows - Navigate panes
- `Ctrl+t` then `n` - New tab
- `Ctrl+o` then `w` - Floating pane
- `Alt+n` - Next tab
- `Alt+h/j/k/l` - Resize panes

---

## Version Management

### mise - Universal Version Manager

**Install:** `brew install mise`

Replace `pyenv`, `nvm`, `rbenv`, and more with one unified tool.

**What it does:**
- Manage multiple language versions (Python, Node.js, Ruby, Go, Java, etc.)
- Per-project version specification (`.python-version`, `.tool-versions`)
- Global version defaults
- Parallel installation of tools
- Fast (written in Rust)
- Environment variable management
- Tool installation (not just language runtimes)
- Backwards compatible with existing version files

**Why it's better:**
- One tool instead of 5+ version managers
- Faster than pyenv/nvm
- Unified interface for all languages
- Better error messages
- Active development and modern codebase
- Can sync with existing pyenv installations

**Common usage:**
```bash
mise install python@3.12       # Install Python 3.12
mise use --global python@3.12  # Set global Python version
mise use python@3.11           # Set local version (creates .tool-versions)
mise list                      # List installed tools
mise ls-remote python          # List available Python versions
mise upgrade                   # Upgrade mise itself
mise doctor                    # Check for issues
```

**Migration from pyenv:**
```bash
# mise will automatically sync with existing pyenv installations
mise use --global python@3.12.11
# Keep pyenv installed - mise uses symlinks to pyenv's Python builds
```

---

## Documentation & Learning

### tealdeer (tldr) - Simplified Man Pages

**Install:** `brew install tealdeer`

Community-driven man pages focused on practical examples.

**What it does:**
- Quick command examples instead of full documentation
- Focused on common use cases
- Fast (Rust implementation of tldr client)
- Offline cache for instant access
- Custom page support for your own commands
- Automatic updates from tldr-pages repo
- Colorized output

**Why it's better than man pages:**
- Get straight to practical examples
- No reading walls of technical text
- Common use cases highlighted first
- Custom pages for your own workflows
- Fast search and display

**Common usage:**
```bash
tldr tar                       # Quick tar examples
tldr docker                    # Common docker commands
tldr git-rebase                # Git rebase examples
tldr --update                  # Update cache
tldr --list                    # List all available pages
tldr --clear-cache             # Clear cache
```

**Custom pages:** Create `.page.md` files in `~/Library/Application Support/tealdeer/pages/`

---

### glow - Terminal Markdown Renderer

**Install:** `brew install glow`

Render markdown files beautifully in the terminal.

**What it does:**
- Render markdown with proper formatting (not just syntax highlighting)
- Paging support for long documents
- Syntax highlighting for code blocks
- Local file and directory rendering
- Fetch and render markdown from URLs
- Multiple themes (dark, light, custom)
- Stash/find markdown files

**Why it's better than cat/bat for markdown:**
- Actually renders markdown (headers, lists, bold, italics formatted properly)
- See formatted documentation as intended
- Code blocks with proper syntax highlighting
- Makes README files readable in terminal
- No need to open browser/editor to read docs

**Common usage:**
```bash
glow README.md                 # Render markdown file
glow -p file.md                # Render with paging
glow -s dark file.md           # Use dark theme
glow https://example.com/doc.md  # Render from URL
glow .                         # Browse markdown in directory
```

---

## Search & Navigation

### fzf - Fuzzy Finder

**Install:** `brew install fzf`

A command-line fuzzy finder - essential for modern shell workflows.

**What it does:**
- Fuzzy search through any list (files, command history, processes)
- Preview window support
- Multi-select mode
- Highly customizable
- Integrates with other tools (bat, ripgrep, fd)
- Enhanced command history search (Ctrl+R)
- File/directory search with preview
- Built-in keybindings for common tasks

**Why it's essential:**
- Find files fast with fuzzy matching (no need to type exact names)
- Search command history efficiently
- Build powerful custom workflows
- Works as a pipe filter for any command output
- Foundation for many shell functions

**Common usage:**
```bash
fzf                            # Fuzzy find files
ls | fzf                       # Fuzzy filter any output
Ctrl+R                         # Search command history (with fzf)
Ctrl+T                         # Find files and paste to command line
Alt+C                          # cd into fuzzy-found directory
command | fzf -m              # Multi-select mode
fzf --preview 'bat {}'         # Preview with bat
```

---

### zoxide - Smart `cd`

**Install:** `brew install zoxide`

A smarter cd command that learns your navigation habits.

**What it does:**
- Tracks directories you visit frequently
- Jump to directories by partial match (frecency algorithm)
- Combines frequency and recency for smart ranking
- Fast directory switching with minimal typing
- Interactive selection with fzf integration
- Works across terminal sessions
- Import history from `z` or `autojump`

**Why it's better than cd:**
- `z proj` instead of `cd ~/Documents/Projects/current-project`
- Learns your patterns over time
- Saves massive amounts of typing
- Smart ranking (prioritizes frequently AND recently used)
- No need to remember full paths

**Common usage:**
```bash
z project                      # Jump to directory matching "project"
z doc python                   # Jump to directory matching both terms
zi                             # Interactive selection with fzf
z -                            # Go back to previous directory
zoxide query project           # Show matching directories
zoxide remove /path            # Remove directory from database
```

---

## Data Processing

### jq - JSON Processor

**Install:** `brew install jq`

Command-line JSON processor - the `sed` for JSON data.

**What it does:**
- Parse, filter, and transform JSON data
- Pretty-print JSON with syntax highlighting
- Extract specific fields from JSON
- Filter arrays and objects
- Perform computations on JSON data
- Combine multiple JSON files
- Stream processing for large files
- Output in various formats (JSON, CSV, text)

**Why it's essential:**
- Work with APIs and JSON responses in terminal
- Debug JSON configuration files
- Extract data from complex JSON structures
- Transform JSON between different formats
- Filter log files in JSON format

**Common usage:**
```bash
cat data.json | jq '.'         # Pretty-print JSON
jq '.field' data.json          # Extract field
jq '.[] | .name' data.json     # Get all names from array
jq 'keys' data.json            # Show all keys
jq 'length' data.json          # Count array/object length
jq -r '.field' data.json       # Raw output (no quotes)
jq -c '.' data.json            # Compact output (one line)
jq -S '.' data.json            # Sort keys
curl api.com/data | jq '.results'  # Filter API response
```

**Advanced examples:**
```bash
# Select specific fields
jq '{name: .name, age: .age}' data.json

# Filter arrays
jq '.[] | select(.age > 30)' data.json

# Map over arrays
jq 'map(.name)' data.json

# Combine multiple filters
jq '.users[] | select(.active == true) | .email' data.json
```

---

## AI & LLMs

### ollama - Run LLMs Locally

**Install:** `brew install ollama`

Run open-source large language models locally on your machine.

**What it does:**
- Run LLMs completely offline (Llama, Mistral, CodeLlama, etc.)
- Simple CLI and REST API
- Model library with one-command installation
- GPU acceleration support
- Concurrent model loading
- Customizable system prompts and parameters
- Chat and completion modes
- Import custom models (GGUF format)

**Why it's useful:**
- Privacy (everything runs locally)
- No API costs
- Work offline
- Fast inference on local hardware
- Experiment with different models
- Integrate LLMs into shell scripts

**Common usage:**
```bash
ollama serve                   # Start ollama service
ollama list                    # List installed models
ollama pull llama2             # Download a model
ollama run llama2              # Start interactive chat
ollama run codellama "write python function"  # One-off completion
ollama ps                      # List running models
ollama rm modelname            # Remove a model
ollama show llama2             # Show model details
```

**Popular models:**
- `llama2` - Meta's Llama 2 (general purpose)
- `codellama` - Code-focused model
- `mistral` - Mistral AI model
- `phi` - Microsoft's small but capable model
- `vicuna` - Chat-optimized model
- `orca-mini` - Smaller, faster model

**Example workflows:**
```bash
# Interactive chat
ollama run llama2

# One-shot completion
echo "Explain Docker in one sentence" | ollama run llama2

# Code generation
ollama run codellama "write a Python script to parse JSON"

# Integrate with shell
ask() {
    echo "$*" | ollama run llama2
}
ask "What is the difference between sort and uniq?"
```

---

## Summary Table

| Tool | Replaces | Language | Speed | Primary Use |
|------|----------|----------|-------|-------------|
| bat | cat, less | Rust | Fast | File viewing |
| fd | find | Rust | Very Fast | File search |
| ripgrep | grep | Rust | Extremely Fast | Code search |
| eza | ls, tree | Rust | Fast | Directory listing |
| lazygit | git CLI | Go | Fast | Git workflows |
| lazydocker | docker CLI | Go | Fast | Docker management |
| zellij | tmux | Rust | Fast | Terminal multiplexing |
| mise | pyenv, nvm, rbenv | Rust | Very Fast | Version management |
| tealdeer | man, tldr | Rust | Extremely Fast | Quick documentation |
| glow | - | Go | Fast | Markdown rendering |
| fzf | - | Go | Very Fast | Fuzzy finding |
| zoxide | cd, autojump | Rust | Extremely Fast | Smart navigation |
| jq | - | C | Fast | JSON processing |
| ollama | - | Go | Varies | Local LLMs |

---

**See [INSTALLATION.md](INSTALLATION.md) for detailed installation instructions.**
