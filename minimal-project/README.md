# minimal-project Template

Use this template for projects that only need the 7 global plugins (no project-specific tools needed).

## What's Included

### Plugins
Empty `enabledPlugins` object - inherits from global only

### Global Plugins (7)
- `github@claude-plugins-official` - GitHub integration
- `code-review@claude-plugins-official` - Code review tools
- `commit-commands@claude-plugins-official` - Git commit helpers
- `typescript-lsp@claude-plugins-official` - TypeScript support
- `explanatory-output-style@claude-plugins-official` - Output formatting
- `learning-output-style@claude-plugins-official` - Output formatting
- `hookify@claude-plugins-official` - Custom hooks

## Setup

1. Copy config to your project:
```bash
cp ~/workspace/claude-config-templates/minimal-project/.claude/config.json YOUR_PROJECT/.claude/
```

2. Restart Claude Code

That's it! You'll use only the 7 universal plugins.

## Use Cases

Perfect for:
- Generic utility projects
- Simple scripts
- Configuration/documentation-heavy projects
- Testing other template types
- Projects that don't need specialized tools

## Adding Plugins

If you later need additional plugins for this project, edit `.claude/config.json`:

```json
{
  "enabledPlugins": {
    "new-plugin@source": true
  }
}
```

## Documentation

See the main [README.md](../README.md) for general template usage.
