# AI Assistant Setup for Simpleminded Shell

How to configure AI assistants to work seamlessly with your simpleminded-shell environment.

## Why AI Assistants Need to Know Your Aliases

Your simpleminded-shell setup **replaces traditional commands with modern tools**. Without knowing this:

- AI suggests `grep` → but you're actually running `ripgrep`
- AI suggests `find` → but you're actually running `fd`
- AI suggests `cat` → but you're actually running `bat`

**The solution**: Make sure your AI assistant reads the `aliases` command output to understand your actual environment.

---

## Quick Reference: `aliases` Command

Your shell has a custom `aliases` command that displays all configured aliases and functions:

```bash
aliases
```

This shows:
- All command replacements (cat → bat, find → fd, etc.)
- Helper aliases (rgi, fda, batdiff, etc.)
- Shell functions (search, ff, gcb, etc.)
- Usage examples and tips

**Every AI assistant should read this first!**

---

## Setup by AI Tool

### Claude Code (Anthropic CLI)

Claude Code can read your shell environment directly.

**Method 1: Ask Claude to read your aliases**
```
Before we start, run the 'aliases' command and read all the output
```

**Method 2: Add to CLAUDE.md (Recommended)**

Create or append to `~/.claude/CLAUDE.md` (global instructions):

```markdown
## Shell Environment

Before suggesting shell commands, run:
```bash
aliases
```

Read all pages of output. This shows:
- Modern replacements (cat=bat, find=fd, grep=rg, ls=eza)
- All helper aliases and functions
- Usage examples

When suggesting commands:
- Use the actual tools (bat, fd, rg, eza) with their full options
- Leverage helper aliases (rgi, fda, batdiff, etc.)
- Use shell functions when appropriate (search, ff, gcb)
```

**Method 3: Project-specific CLAUDE.md**

For individual projects, add to the project's `CLAUDE.md`:

```markdown
## Development Environment

This project uses simpleminded-shell. Read the aliases:
```bash
aliases
```

Prefer modern tool syntax over traditional Unix commands.
```

---

### Amazon Q (AWS CLI Assistant)

Amazon Q can be configured to understand your environment.

**In your shell session:**
```bash
# Before using Q, show it your environment
q chat

# In the chat, paste:
"First, here are my configured aliases and functions:"

# Then run and copy output:
aliases | cat

# Paste the output into Q
```

**Add to ~/.bashrc or ~/.zshrc:**
```bash
# Function to start Q with environment context
qstart() {
    echo "My shell environment:" > /tmp/q_context.txt
    aliases >> /tmp/q_context.txt
    echo ""
    echo "Context saved. In Amazon Q, reference: $(cat /tmp/q_context.txt | head -20)..."
    q chat
}
```

---

### GitHub Copilot CLI

**Method 1: Set context in session**
```bash
# Copilot reads shell context automatically, but you can reinforce:
gh copilot explain "I use bat instead of cat, fd instead of find, rg instead of grep"
```

**Method 2: Use comments in scripts**
```bash
#!/bin/bash
# This environment uses simpleminded-shell:
# - cat = bat (syntax highlighting)
# - find = fd (faster find)
# - grep = rg (ripgrep)
# - ls = eza (modern ls)

# Now Copilot suggestions will use the right tools
```

---

### ChatGPT with Terminal Access (via plugins)

If using ChatGPT plugins or Code Interpreter with shell access:

**1. Initialize the session:**
```
Read my shell environment by running: aliases
Then remember these aliases for all future command suggestions.
```

**2. Save as a custom instruction:**

Go to ChatGPT Settings → Custom Instructions → "How would you like ChatGPT to respond?"

```
When suggesting shell commands, remember that I use:
- bat instead of cat (use bat syntax)
- fd instead of find (use fd syntax)
- ripgrep (rg) instead of grep (use rg syntax)
- eza instead of ls (use eza syntax)
- Modern helper aliases: rgi, fda, batdiff, catp, etc.
- Shell functions: search, ff, gcb, cdf

Always suggest commands using these modern tools and their actual syntax.
```

---

### Google Gemini / Bard

**In your conversation:**
```
Before we write any shell commands, I need you to understand my environment.
Run this command and read the full output:

aliases

This shows all my command replacements and helper functions.
When suggesting commands, use these modern tools instead of traditional ones.
```

**For Gemini API/SDK:**

If integrating Gemini into scripts:
```python
import google.generativeai as genai

# Get aliases output
aliases_output = subprocess.check_output("aliases", shell=True).decode()

# Include in system prompt
system_context = f"""
This user's shell environment uses modern CLI tools:

{aliases_output}

When suggesting shell commands, use these tools and their syntax.
"""

response = genai.generate_text(
    prompt=user_query,
    context=system_context
)
```

---

### Cursor AI Editor

Cursor can read your local environment.

**Method 1: Add to .cursorrules**

Create `.cursorrules` in your home directory or project:

```
When suggesting shell commands, use these modern CLI tools:
- bat (not cat) - for viewing files with syntax highlighting
- fd (not find) - for finding files
- ripgrep/rg (not grep) - for searching text
- eza (not ls) - for listing files
- lazygit (not git commands) - for visual git interface

Available helper aliases:
- rgi: case-insensitive ripgrep
- fda: fd including hidden files
- batdiff: git diff with syntax highlighting
- catp: bat with paging
- search: interactive search with preview
- ff: fuzzy find and edit files

Check available functions: aliases
```

**Method 2: Use Cursor's terminal context**

Cursor automatically sees terminal output. Just run:
```bash
aliases
```

in Cursor's integrated terminal, and it will use that context.

---

### Codeium / Tabnine / Other IDE Assistants

Most IDE-based AI assistants read your local files.

**Create a reference file:**

```bash
# Save aliases to a file the AI can reference
aliases > ~/.config/shell-aliases-reference.md
```

**Then create `.ai-context.md` in your project or home directory:**

```markdown
# Shell Environment Context

My terminal uses modern CLI tools via transparent aliases.

Full reference: ~/.config/shell-aliases-reference.md

Key replacements:
- cat → bat (syntax highlighting)
- find → fd (faster, smarter defaults)
- grep → rg (ripgrep)
- ls → eza (icons, git integration)

Helper aliases: rgi, fda, fdall, batdiff, catp, etc.
Shell functions: search, ff, gcb, cdf, extract, backup
```

---

## General Best Practices

### 1. Always Start with Context

When beginning a new chat/session:
```
Before we start, run: aliases

Read all the output (there are multiple pages). This shows my shell environment.
```

### 2. Correct the AI When Needed

If the AI suggests `grep`, respond:
```
Remember, I use ripgrep (rg). Please use rg syntax instead.
Check the 'aliases' output for the correct syntax.
```

### 3. Use AI-Friendly Function Descriptions

Your `aliases` command output is already AI-friendly with:
- Clear descriptions
- Usage examples
- Before/after comparisons
- Organized categories

### 4. Keep Aliases Current

After updating your shell config:
```bash
# Refresh the context
source ~/.zshrc
aliases

# Tell your AI: "I've updated my environment. Here's the new aliases output:"
```

### 5. Use Project-Specific Context

For projects with unique requirements:

**Create `project/.ai-context`:**
```
This project uses:
- Python 3.11 (via mise)
- Poetry for dependency management
- Simpleminded-shell environment (run: aliases)
```

---

## Command Translation Guide for AI

Help your AI translate traditional → modern commands:

| Traditional | Modern (Simpleminded Shell) | Why Better |
|------------|---------------------------|-----------|
| `cat file.py` | `bat file.py` (aliased) | Syntax highlighting |
| `find . -name "*.js"` | `fd *.js` | Simpler, faster |
| `grep -r "pattern"` | `rg pattern` | Much faster |
| `ls -la` | `ll` | Icons, git status |
| `git status && git add .` | `lg` | Visual interface |
| `cd frequently-used-dir` | `z dir` (via zoxide) | Smart jump |

---

## Testing AI Understanding

Ask your AI assistant:
```
What command should I use to:
1. View a Python file with syntax highlighting?
2. Find all JavaScript files recursively?
3. Search for "TODO" in all files?
4. See a detailed file listing with icons?
```

**Correct answers:**
1. `cat file.py` (which runs bat)
2. `fd -e js` or `find -e js`
3. `rg TODO` or `grep TODO`
4. `ll`

If the AI doesn't know these, re-run `aliases` and paste the output.

---

## Automation: Pre-loading Context

**Create a helper script: `~/bin/ai-with-context`**

```bash
#!/bin/bash

# ai-with-context - Start AI tool with shell environment loaded

AI_TOOL="$1"
shift

case "$AI_TOOL" in
    "q"|"amazon-q")
        echo "Loading environment for Amazon Q..."
        aliases | head -50
        exec q chat "$@"
        ;;
    "claude")
        echo "Loading environment for Claude Code..."
        echo "Run: aliases | cat"
        exec claude "$@"
        ;;
    *)
        echo "Usage: ai-with-context [q|claude|copilot]"
        echo "Loads your simpleminded-shell environment context for AI tools"
        ;;
esac
```

**Make it executable:**
```bash
chmod +x ~/bin/ai-with-context
```

**Use it:**
```bash
ai-with-context claude
ai-with-context q
```

---

## Troubleshooting

### AI Keeps Suggesting Traditional Commands

**Solution**: Re-run and show the aliases:
```bash
aliases | cat  # Use cat to get plain text
```
Copy the entire output into your AI conversation.

### AI Doesn't Understand Custom Functions

**Solution**: Show specific function source:
```bash
# Show the 'search' function definition
type search

# Or show multiple functions
type search ff gcb cdf
```

### AI Suggestions Don't Use Helper Aliases

**Solution**: Remind the AI of available helpers:
```
I have helper aliases for common patterns:
- rgi: case-insensitive search
- fda: find including hidden files
- batdiff: git diff with highlighting

Please use these instead of long flag chains.
```

---

## Advanced: AI-Readable Config Export

Create a machine-readable format for AI tools:

```bash
# Export aliases in AI-friendly format
cat > ~/.config/ai-shell-context.json << 'EOF'
{
  "shell_type": "zsh",
  "config": "simpleminded-shell",
  "command_replacements": {
    "cat": {"actual": "bat", "flags": "--paging=never"},
    "find": {"actual": "fd", "flags": null},
    "grep": {"actual": "rg", "flags": null},
    "ls": {"actual": "eza", "flags": "--color=always --group-directories-first --icons"}
  },
  "helper_aliases": {
    "ll": "eza -la --icons --octal-permissions",
    "rgi": "rg -i",
    "fda": "fd -H",
    "search": "function: interactive search with fzf+bat",
    "ff": "function: fuzzy find and edit"
  },
  "instructions": "Use modern tool syntax directly. All traditional commands are aliased."
}
EOF
```

**Then tell AI tools to read:**
```
Read my shell configuration: ~/.config/ai-shell-context.json
```

---

## Summary

✅ **Do This:**
1. Run `aliases` at the start of every AI session
2. Show AI the full output (all pages)
3. Add context to global configs (CLAUDE.md, .cursorrules, custom instructions)
4. Correct AI when it suggests traditional commands

❌ **Don't Do This:**
1. Assume AI knows your environment
2. Let AI suggest traditional `grep`, `find`, `cat` without correction
3. Forget to update AI context after changing your shell config

---

**Next Steps:**
1. Pick your primary AI tool from the list above
2. Follow its setup instructions
3. Test with: "What command views a Python file with syntax highlighting?"
4. Correct and iterate until the AI uses your modern tools

**Questions?** Open an issue or check the [main README](../README.md) for more about simpleminded-shell.
