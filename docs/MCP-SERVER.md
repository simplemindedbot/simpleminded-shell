# MCP Server User Guide

Complete guide to using the Simpleminded Shell MCP Server with AI assistants.

## What is the MCP Server?

The Simpleminded Shell MCP Server is a bridge between your shell environment and AI coding assistants. Instead of manually running the `aliases` command and copying output, the AI can automatically query your environment through the MCP protocol.

## Prerequisites

Before setting up the MCP server, you should have simpleminded-shell configured in your terminal:

```bash
# Clone the repository
git clone https://github.com/yourusername/simpleminded-shell.git
cd simpleminded-shell

# Run the interactive installer
bash install.sh
```

The installer will set up your shell with modern tools and aliases that the MCP server will expose to AI assistants.

## Benefits

### Automatic Environment Understanding
- AI knows that `cat` runs `bat`, `grep` runs `rg`, etc.
- No need to manually show aliases
- Always up-to-date with your configuration

### Intelligent Features
- **Command Translation**: "What's the modern equivalent of `grep -r pattern`?" → "rg pattern"
- **Tool Checking**: "Is fd installed?" → Instant verification with version
- **Smart Examples**: "Show me how to find Python files" → Relevant fd examples
- **Recommendations**: "I want to search text" → Suggests rg with usage examples

### Better AI Suggestions
- AI suggests commands using YOUR actual tools
- Recommendations match your installed software
- Examples tailored to simpleminded-shell workflow

## Installation

### Option 1: uvx (Easiest)

No installation needed! Just configure and run:

```bash
# Test it works
uvx --from simpleminded-shell-mcp simpleminded-mcp
```

### Option 2: pip

```bash
# From PyPI
pip install simpleminded-shell-mcp

# Or from source
cd simpleminded-shell/mcp-server
pip install -e .
```

## Configuration

### Claude Code

Add to your Claude Code MCP settings (usually in `~/.claude/config.json` or via UI):

```json
{
  "mcpServers": {
    "simpleminded-shell": {
      "command": "uvx",
      "args": [
        "--from",
        "simpleminded-shell-mcp",
        "simpleminded-mcp"
      ]
    }
  }
}
```

**With local pip installation:**
```json
{
  "mcpServers": {
    "simpleminded-shell": {
      "command": "python",
      "args": ["-m", "src.server"],
      "cwd": "/path/to/simpleminded-shell/mcp-server"
    }
  }
}
```

### Other MCP-Compatible Tools

The server works with any MCP-compatible AI tool. Configuration format is similar - specify the command and args to run the server.

## Usage Examples

### Example 1: Command Translation

**You:** "How do I search for 'TODO' recursively?"

**Claude (with MCP):**
```
I'll check the modern equivalent...

Using the MCP server, I can see you should use:
rg "TODO"

Instead of: grep -r "TODO" .

This is faster and respects .gitignore by default.
```

### Example 2: Tool Verification

**You:** "Can I use fd to find Python files?"

**Claude (with MCP):**
```
Checking if fd is installed...

Yes! fd version 9.0.0 is installed at /opt/homebrew/bin/fd

Here's how to find Python files:
fd -e py
```

### Example 3: Discovering Aliases

**You:** "What aliases do I have for git?"

**Claude (with MCP):**
```
You have these git aliases:
- g → git
- gs → git status
- ga → git add
- gc → git commit
- gp → git push
- gl → git pull
- lg → lazygit (visual interface)
- gcb → checkout branch with fzf picker
- gd → git diff
- glog → pretty git log graph
```

### Example 4: Smart Recommendations

**You:** "I need to process some JSON data"

**Claude (with MCP):**
```
For JSON processing, I recommend jq:

Examples:
- Pretty print: cat data.json | jq
- Extract field: jq '.users[].name' data.json
- Show keys: jq 'keys' data.json

jq is installed (version 1.7) so you're ready to go!
```

## Available Resources

### Configuration Info
```
simpleminded://config/info
```
Shows where your shell config is located and if simpleminded-shell is detected.

### All Aliases
```
simpleminded://aliases/all
```
Complete list of your aliases and functions in JSON format.

### Aliases by Category
```
simpleminded://aliases/category/git
simpleminded://aliases/category/file
simpleminded://aliases/category/docker
```
Filtered aliases for specific categories.

### Tool Status
```
simpleminded://tools/status
```
Installation status and versions of all simpleminded-shell tools.

### Examples
```
simpleminded://examples/all
```
Usage examples for all tools.

### Workflows
```
simpleminded://workflows/all
```
Common multi-step workflows.

## Available Tools

### translate_command
Translate traditional commands to modern equivalents.

**Example:**
```
Input: "grep -ri 'error' --include='*.log'"
Output: "rg -i --type log 'error'"
```

### check_tool
Verify tool installation and get version.

**Example:**
```
Input: "bat"
Output: {
  "installed": true,
  "version": "0.24.0",
  "path": "/opt/homebrew/bin/bat",
  "install_command": "brew install bat"
}
```

### get_examples
Get usage examples for any tool.

**Example:**
```
Input: tool="fd", use_case="find_by_extension"
Output: [{
  "command": "fd -e py",
  "description": "Find all Python files"
}]
```

### explain_alias
Understand what an alias actually runs.

**Example:**
```
Input: "cat"
Output: "Runs 'bat --paging=never' - provides syntax highlighting and Git integration"
```

### search_examples
Search examples by keyword.

**Example:**
```
Input: "case insensitive"
Output: [
  {tool: "rg", command: "rg -i pattern", description: "Case-insensitive search"},
  {tool: "fd", command: "fd -i config", description: "Case-insensitive find"}
]
```

### get_tool_benefits
Learn why modern tools are better.

**Example:**
```
Input: "rg"
Output: [
  "Blazingly fast - faster than grep, ag, ack",
  "Respects .gitignore by default",
  "Full Unicode support",
  "Smart case matching",
  ...
]
```

### recommend_tools
Get tool suggestions for tasks.

**Example:**
```
Input: "I want to view a file with colors"
Output: {
  "tool": "bat",
  "reason": "View files with syntax highlighting",
  "examples": [...]
}
```

## Troubleshooting

### Server Won't Start

**Check Python version:**
```bash
python --version  # Need 3.10+
```

**Check mcp package:**
```bash
pip install mcp
```

**Test server directly:**
```bash
python -m src.server
# Should start without errors
```

### Configuration Not Detected

The server looks for simpleminded-shell in these locations:
1. `~/.zshrc`
2. `~/.bashrc`
3. `~/.config/zsh/.zshrc`

**Verify your config has:**
- The marker: `# SIMPLEMINDED-SHELL-CONFIG`
- OR characteristic aliases like: `alias cat='bat'`

**Manual path:**
Set `SIMPLEMINDED_CONFIG` environment variable:
```bash
export SIMPLEMINDED_CONFIG="$HOME/.config/custom-zshrc"
```

### Tools Not Detected

**Check if tools are in PATH:**
```bash
which bat fd rg eza
```

**Verify installation:**
```bash
bat --version
fd --version
rg --version
```

### MCP Connection Issues

**Check Claude Code logs:**
Look for errors in Claude Code console/logs mentioning the MCP server.

**Verify MCP config format:**
Ensure JSON is valid and paths are correct.

**Test with different command:**
Try absolute path to Python or use virtual environment Python.

## Advanced Usage

### Custom Config Path

Set environment variable before running:
```bash
export SIMPLEMINDED_CONFIG="/path/to/my/.zshrc"
python -m src.server
```

### Multiple Profiles

Run multiple servers for different shell profiles:
```json
{
  "mcpServers": {
    "simpleminded-work": {
      "command": "python",
      "args": ["-m", "src.server"],
      "env": {"SIMPLEMINDED_CONFIG": "~/.zshrc-work"}
    },
    "simpleminded-personal": {
      "command": "python",
      "args": ["-m", "src.server"],
      "env": {"SIMPLEMINDED_CONFIG": "~/.zshrc-personal"}
    }
  }
}
```

### Debugging

Enable debug logging:
```bash
export LOG_LEVEL=DEBUG
python -m src.server
```

## Comparison: With vs Without MCP

### Without MCP Server
```
You: "How do I search for text in files?"
Claude: "Use grep -r 'pattern' ."
You: "Actually I use ripgrep"
Claude: "Oh, then use rg 'pattern'"
You: "What flags are available?"
*You run `aliases` and copy output*
*Paste into chat*
Claude: "Based on your aliases, use rgi for case-insensitive..."
```

### With MCP Server
```
You: "How do I search for text in files?"
Claude: "I can see you use ripgrep. Use: rg 'pattern'
For case-insensitive: rgi 'pattern' (that's your alias)
Your ripgrep version 14.0.0 is installed and ready to use."
```

## Best Practices

1. **Keep shell config current** - MCP reads your actual .zshrc
2. **Update tools regularly** - MCP shows installed versions
3. **Trust AI suggestions** - They're based on your actual setup
4. **Ask about workflows** - "Show me git workflows" uses your aliases
5. **Request examples** - "How do I..." will show simpleminded-shell examples

## FAQ

**Q: Does this work with other AI tools besides Claude Code?**
A: Yes, any MCP-compatible AI tool can use this server.

**Q: Do I still need the aliases command?**
A: No! The MCP server provides the same info automatically.

**Q: What if I update my .zshrc?**
A: MCP reads your config each time, so changes are reflected immediately.

**Q: Can I use this without simpleminded-shell?**
A: It's designed for simpleminded-shell, but will work with any shell config containing aliases.

**Q: Is my shell config sent to the cloud?**
A: No. MCP runs locally. AI assistants query YOUR local server.

**Q: Does this slow down the AI?**
A: No, MCP queries are very fast (milliseconds).

## Next Steps

1. Install the MCP server (uvx or pip)
2. Configure your AI tool (Claude Code, etc.)
3. Test with: "What aliases do I have?"
4. Enjoy seamless AI integration!

## Support

- Issues: [GitHub Issues](https://github.com/yourusername/simpleminded-shell/issues)
- Docs: [Main Documentation](../README.md)
- MCP Spec: [Model Context Protocol](https://modelcontextprotocol.io)

---

**Last Updated:** 2025-10-23
