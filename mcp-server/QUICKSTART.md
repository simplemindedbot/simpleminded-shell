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

### Option 1: Local Development

```bash
cd mcp-server
pip install -e .
```

### Option 2: Direct from uvx (once published)

```bash
uvx simplemindedshellmcp
```

## Test It Works

```bash
# Test the server
cd mcp-server
python -m src.server
# Press Ctrl+C to stop

# Run tests
pytest
```

## Configure Claude Code

Add to your MCP configuration:

**macOS/Linux:** `~/.claude/config.json`

```json
{
  "mcpServers": {
    "simpleminded-shell": {
      "command": "python",
      "args": ["-m", "src.server"],
      "cwd": "/Users/YOUR_USERNAME/Documents/GitHub/simpleminded-shell/mcp-server"
    }
  }
}
```

Replace `/Users/YOUR_USERNAME/...` with your actual path.

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

### For Local Use

You're done! The MCP server is running and Claude Code can use it.

### For Publishing to PyPI

1. **Update package info** in `pyproject.toml`:
   - Change URLs to your actual repository
   - Update author info if needed

2. **Test locally** first:
   ```bash
   python -m build
   pip install dist/*.whl
   ```

3. **Publish to TestPyPI**:
   ```bash
   python -m twine upload --repository testpypi dist/*
   ```

4. **Publish to PyPI**:
   ```bash
   python -m twine upload dist/*
   ```

See [PUBLISHING.md](PUBLISHING.md) for detailed instructions.

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
