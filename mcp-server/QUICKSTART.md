# MCP Server Quick Start

Get up and running with the Simpleminded Shell MCP Server in 5 minutes.

## Prerequisites

First, ensure you have simpleminded-shell configured in your terminal:

```bash
cd ../  # Go to main repository
bash install.sh
```

This sets up the shell environment that the MCP server will expose to AI assistants.

## What You Just Built

A complete MCP server that provides:
- **7 Resources** - Read-only data about your shell environment
- **7 Tools** - Interactive commands AI can invoke
- **Auto-detection** - Finds your shell config automatically
- **Python Package** - Ready for PyPI publication
- **Tests** - Basic test coverage included

## Installation

The package is **now live on PyPI**! Choose the installation method that works best for you.

### Option 1: uvx (Recommended - Zero Install)

The easiest way - no installation needed:

```bash
# Run directly (downloads automatically)
uvx --from simplemindedshellmcp simpleminded-mcp
```

### Option 2: pip (Permanent Installation)

```bash
# Install from PyPI
pip install simplemindedshellmcp

# Run the server
simpleminded-mcp
```

### Option 3: uv (Modern Python)

```bash
# Install with uv
uv pip install simplemindedshellmcp

# Run
uv run simpleminded-mcp
```

### Option 4: From GitHub (Development)

```bash
# Install latest from GitHub
pip install git+https://github.com/simplemindedbot/simpleminded-shell.git#subdirectory=mcp-server

# Or clone and develop
git clone https://github.com/simplemindedbot/simpleminded-shell.git
cd simpleminded-shell/mcp-server
pip install -e .
```

## Test It Works

```bash
# Test the server (any installation method)
uvx --from simplemindedshellmcp simpleminded-mcp
# Should output: INFO:src.server:Simpleminded Shell MCP Server starting...
# Press Ctrl+C to stop
```

## Configure Claude Code

Add to your MCP configuration (`~/.claude/config.json` or via UI):

**Recommended: uvx (zero install)**
```json
{
  "mcpServers": {
    "simpleminded-shell": {
      "command": "uvx",
      "args": [
        "--from",
        "simplemindedshellmcp",
        "simpleminded-mcp"
      ]
    }
  }
}
```

**With pip installation:**
```json
{
  "mcpServers": {
    "simpleminded-shell": {
      "command": "simpleminded-mcp"
    }
  }
}
```

**With uv:**
```json
{
  "mcpServers": {
    "simpleminded-shell": {
      "command": "uv",
      "args": ["run", "simpleminded-mcp"]
    }
  }
}
```

**Development (local source):**
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

## Try It Out

Open Claude Code and ask:

1. **"What aliases do I have?"**
   - Should show your simpleminded-shell aliases

2. **"Translate 'grep -r pattern' to my environment"**
   - Should return: `rg "pattern"`

3. **"Is fd installed?"**
   - Should check and report version

4. **"How do I find Python files?"**
   - Should provide fd examples

## Next Steps

### For Users

You're done! The MCP server is running and Claude Code can use it.

**Quick verification:**
```bash
# Check it's published on PyPI
curl -s https://pypi.org/pypi/simplemindedshellmcp/json | jq '.info.version'

# Try installing it
pip install simplemindedshellmcp

# Test it works
simpleminded-mcp
```

### For Contributors

Want to contribute? See [PUBLISHING.md](PUBLISHING.md) for:
- Setting up development environment
- Running tests
- Publishing new versions
- GitHub Actions workflow

## Troubleshooting

### "No configuration detected"

Make sure your `~/.zshrc` has either:
- The marker: `# SIMPLEMINDED-SHELL-CONFIG`
- Or aliases like: `alias cat='bat'`

### Server won't start

Check requirements:
```bash
pip install mcp
python --version  # Need 3.10+
```

### Claude Code can't connect

1. Check the path in config.json is correct
2. Test server runs manually: `python -m src.server`
3. Check Claude Code logs for errors

## File Structure

```
mcp-server/
├── src/
│   ├── server.py              # Main MCP server ✓
│   ├── config_parser.py       # Auto-detect shell config ✓
│   ├── alias_detector.py      # Parse aliases ✓
│   ├── command_translator.py  # Translate commands ✓
│   ├── tool_checker.py        # Check installations ✓
│   └── example_provider.py    # Provide examples ✓
├── tests/
│   ├── test_translator.py     # Translation tests ✓
│   └── test_alias_detector.py # Parser tests ✓
├── pyproject.toml             # Package config ✓
├── README.md                  # Technical docs ✓
├── PUBLISHING.md              # PyPI guide ✓
├── LICENSE                    # MIT license ✓
└── QUICKSTART.md              # This file ✓
```

## Resources for Learning More

- [MCP Server README](README.md) - Technical documentation
- [User Guide](../docs/MCP-SERVER.md) - Detailed usage guide
- [Publishing Guide](PUBLISHING.md) - How to publish to PyPI
- [MCP Specification](https://modelcontextprotocol.io) - Protocol details

## What's Next?

The server is fully functional! Here are some ideas for enhancements:

- Add more translation patterns
- Support for bash configs better
- Cache tool check results
- Add more example workflows
- Create a web dashboard
- Support for other shells (fish, etc.)

Enjoy your AI-powered shell experience! 🚀
