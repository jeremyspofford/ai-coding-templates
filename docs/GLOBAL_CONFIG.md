# Global Configuration Reference

Global AI tool configurations are stored in your home directory and apply across all projects.

## Claude Global Config

Location: `~/.claude/settings.json`

Recommended global settings:

```json
{
  "enabledPlugins": {
    "github@claude-plugins-official": true,
    "code-review@claude-plugins-official": true,
    "commit-commands@claude-plugins-official": true,
    "typescript-lsp@claude-plugins-official": true,
    "explanatory-output-style@claude-plugins-official": true,
    "learning-output-style@claude-plugins-official": true,
    "hookify@claude-plugins-official": true
  },
  "permissions": {
    "allow": []
  }
}
```

## Cursor Global Config

Global rules and settings for Cursor are typically configured through the Cursor UI or in your global `.cursor` directory.

## Antigravity Global Config

Antigravity configurations are typically project-specific. Refer to project `.agent/` directories for setup.
