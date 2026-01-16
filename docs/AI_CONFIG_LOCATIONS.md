# AI Coding Assistant Configuration File Locations

A comprehensive reference for configuration file locations across AI coding assistants on Windows, macOS, and Linux.

## Quick Reference Table

| Tool | Global Config | Project Config |
| ---- | ------------- | -------------- |
| Claude Code | `~/.claude/settings.json` | `.claude/settings.json` |
| Claude Desktop | See platform paths below | N/A |
| Cursor | Settings UI | `.cursor/rules/*.mdc` |
| GitHub Copilot | `~/.copilot/` | `.github/copilot-instructions.md` |
| Windsurf | `~/.codeium/` | `.windsurf/rules/` |
| Continue | `~/.continue/config.json` | `.continuerc.json` |
| Aider | `~/.aider.conf.yml` | `.aider.conf.yml` |
| OpenAI Codex | `~/.codex/config.toml` | N/A |
| Gemini CLI | `~/.gemini/settings.json` | `.gemini/settings.json` |
| Amazon Q | `~/.aws/amazonq/` | `.amazonq/` |
| Zed Editor | `~/.config/zed/settings.json` | `.zed/settings.json` |
| Cody | VS Code settings | Sourcegraph site config |

---

## Claude Code (CLI)

Claude Code uses a hierarchical configuration system with multiple file types.

### Settings Files

| Scope | Location | Purpose |
| ----- | -------- | ------- |
| User (Global) | `~/.claude/settings.json` | User-wide settings for all projects |
| Project (Shared) | `.claude/settings.json` | Project settings, version-controlled |
| Project (Local) | `.claude/settings.local.json` | Personal project settings, git-ignored |
| Legacy | `~/.claude.json` | Preferences, OAuth, caches |

### Memory Files (CLAUDE.md)

| Scope | Location |
| ----- | -------- |
| Global | `~/.claude/CLAUDE.md` |
| Project | `./CLAUDE.md` (project root) |
| Nested | Any subdirectory `CLAUDE.md` |

### MCP Configuration

| Scope | Location |
| ----- | -------- |
| Project (Shared) | `.mcp.json` |
| Project (Local) | `.claude/settings.local.json` |
| User | `~/.claude/settings.local.json` |

### Platform Paths

- **macOS/Linux**: `~/.claude/`
- **Windows**: `%USERPROFILE%\.claude\`

---

## Claude Desktop

Configuration for Claude Desktop app, primarily for MCP server setup.

### Desktop Platform Paths

| Platform | Config File Location |
| -------- | -------------------- |
| macOS | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Windows | `%APPDATA%\Claude\claude_desktop_config.json` |
| Linux | `~/.config/Claude/claude_desktop_config.json` |

### Access via UI

Open: Claude > Settings > Developers > Edit Config

### Example MCP Configuration

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/dir"]
    }
  }
}
```

---

## Cursor

Cursor uses MDC (Markdown Component) files for AI rules and VS Code-compatible settings.

### Cursor Rules Configuration

| Type | Location | Description |
| ---- | -------- | ----------- |
| User Rules | Settings UI | Global rules via Cursor Settings > Rules |
| Project Rules | `.cursor/rules/*.mdc` | Version-controlled, per-project |
| Legacy | `.cursorrules` | Deprecated, still supported |

### MDC File Format

```yaml
---
description: Rule description
globs: ["src/**/*.ts"]
alwaysApply: true
---
# Rule content in markdown
```

### Cursor Settings Location

Cursor extends VS Code, so settings are in the same locations:

| Platform | Path |
| -------- | ---- |
| macOS | `~/Library/Application Support/Cursor/User/settings.json` |
| Windows | `%APPDATA%\Cursor\User\settings.json` |
| Linux | `~/.config/Cursor/User/settings.json` |

---

## GitHub Copilot

### Repository Instructions

| File | Purpose |
| ---- | ------- |
| `.github/copilot-instructions.md` | Repository-wide custom instructions |
| `.github/agents/` | Custom Copilot agents |
| `.github/git-commit-instructions.md` | Commit message instructions |

### CLI Configuration

| Platform | Path |
| -------- | ---- |
| All | `~/.copilot/mcp-config.json` |

Override with `XDG_CONFIG_HOME` environment variable.

### JetBrains Global Instructions

| Platform | Path |
| -------- | ---- |
| Windows | `C:\Users\<user>\AppData\Local\github-copilot\intellij\global-git-commit-instructions.md` |
| macOS | `~/Library/Application Support/github-copilot/intellij/global-git-commit-instructions.md` |

---

## Windsurf (Codeium)

### Windsurf Rules Configuration

| Type | Location | Description |
| ---- | -------- | ----------- |
| Project Rules | `.windsurf/rules/*.md` | Current format |
| Legacy | `.windsurfrules` | Deprecated |
| Global Ignore | `~/.codeium/.codeiumignore` | Enterprise cross-repo rules |

### Example Rule File

Create `.windsurf/rules/rules.md`:

```markdown
1. My build system is Bazel
2. My testing framework is pytest
3. Don't modify files in /vendor
```

---

## Continue

### Continue Configuration Files

| Scope | Location (macOS/Linux) | Location (Windows) |
| ----- | ---------------------- | ------------------ |
| User | `~/.continue/config.json` | `%USERPROFILE%\.continue\config.json` |
| User (YAML) | `~/.continue/config.yaml` | `%USERPROFILE%\.continue\config.yaml` |
| Project | `.continuerc.json` | `.continuerc.json` |
| Advanced | `~/.continue/config.ts` | `%USERPROFILE%\.continue\config.ts` |

### Project Override Example

```json
{
  "mergeBehavior": "merge",
  "models": [...]
}
```

---

## Aider

### Aider Configuration Files

Aider loads config files in order (later files override earlier):

| Priority | Location |
| -------- | -------- |
| 1 | `~/.aider.conf.yml` |
| 2 | Git repo root `.aider.conf.yml` |
| 3 | Current directory `.aider.conf.yml` |
| Custom | `--config <filename>` |

### Additional Files

| File | Purpose |
| ---- | ------- |
| `.aider.model.settings.yml` | Model-specific overrides |
| `.env` | Environment variables (`AIDER_xxx`) |

### Example Aider Configuration

```yaml
model: claude-sonnet-4-20250514
read: CONVENTIONS.md
auto-commits: false
```

---

## OpenAI Codex CLI

### Configuration Location

| Platform | Path |
| -------- | ---- |
| macOS/Linux | `~/.codex/config.toml` |
| Windows | `%USERPROFILE%\.codex\config.toml` |

The `CODEX_HOME` environment variable can override the default `~/.codex` location.

### Access via IDE

Open: Gear icon > Codex Settings > Open config.toml

### CLI Overrides

```bash
codex -c key=value  # Override for single invocation
```

---

## Gemini CLI

### Configuration Hierarchy

| Priority | Location | Description |
| -------- | -------- | ----------- |
| Lowest | System defaults | See platform paths below |
| Medium | `~/.gemini/settings.json` | User settings |
| Highest | `.gemini/settings.json` | Project settings |

### System Defaults Path

| Platform | Path |
| -------- | ---- |
| macOS | `/Library/Application Support/GeminiCli/system-defaults.json` |
| Windows | `C:\ProgramData\gemini-cli\system-defaults.json` |
| Linux | `/etc/gemini-cli/system-defaults.json` |

Override with `GEMINI_CLI_SYSTEM_DEFAULTS_PATH` environment variable.

---

## Amazon Q Developer

### Configuration Locations

| Scope | Location |
| ----- | -------- |
| Global MCP | `~/.aws/amazonq/default.json` |
| Global MCP (Legacy) | `~/.aws/amazonq/mcp.json` |
| Local/Project | `.amazonq/default.json` |

### CLI Settings Commands

```bash
q settings list --all          # View all settings
q settings open                 # Open settings file
q settings --delete setting.name  # Delete a setting
```

### Platform Notes

- **Windows**: Not directly supported; use WSL2
- **macOS/Linux**: Native support

---

## Zed Editor

### Zed Settings Location

| Platform | Path |
| -------- | ---- |
| macOS | `~/.config/zed/settings.json` |
| Linux | `~/.config/zed/settings.json` or `$XDG_CONFIG_HOME/zed/settings.json` |
| Windows | `%APPDATA%\Zed\settings.json` |

### Project Settings

Create `.zed/settings.json` in project root.

### Keyboard Shortcuts

- **macOS**: `Cmd+Alt+,` to open settings
- **Linux/Windows**: `Ctrl+Alt+,` to open settings

### AI Configuration Example

```json
{
  "agent": {
    "default_model": {
      "provider": "anthropic",
      "model": "claude-sonnet-4"
    }
  },
  "language_models": {
    "anthropic": {
      "api_key": "..."
    }
  }
}
```

---

## Sourcegraph Cody

### VS Code Extension

Configuration through VS Code settings:

| Platform | Path |
| -------- | ---- |
| macOS | `~/Library/Application Support/Code/User/settings.json` |
| Windows | `%APPDATA%\Code\User\settings.json` |
| Linux | `~/.config/Code/User/settings.json` |

### Enterprise Configuration

Managed through Sourcegraph site configuration (`modelConfiguration` field).

---

## Environment Variables

Many tools support environment variable overrides:

| Tool | Variable Pattern | Example |
| ---- | ---------------- | ------- |
| Aider | `AIDER_*` | `AIDER_MODEL=claude-sonnet-4` |
| OpenAI Codex | `CODEX_HOME` | `CODEX_HOME=/custom/path` |
| Gemini CLI | `GEMINI_CLI_*` | `GEMINI_CLI_SYSTEM_DEFAULTS_PATH=/path` |
| GitHub Copilot | `XDG_CONFIG_HOME` | Affects `~/.copilot` location |

---

## Common Patterns

### Project-Level Config (Version Controlled)

Most tools support a project-level config that should be committed:

```text
.claude/settings.json
.cursor/rules/*.mdc
.github/copilot-instructions.md
.windsurf/rules/*.md
.gemini/settings.json
.continuerc.json
.aider.conf.yml
```

### Local/Personal Config (Git Ignored)

Files for personal preferences that shouldn't be shared:

```text
.claude/settings.local.json
.env
```

### Memory/Instructions Files

Natural language instructions for AI context:

```text
CLAUDE.md
.github/copilot-instructions.md
.cursor/rules/*.mdc
.windsurf/rules/*.md
```

---

## Platform Path Expansions

| Symbol | macOS | Windows | Linux |
| ------ | ----- | ------- | ----- |
| `~` | `/Users/<user>` | `C:\Users\<user>` | `/home/<user>` |
| `%APPDATA%` | N/A | `C:\Users\<user>\AppData\Roaming` | N/A |
| `%USERPROFILE%` | N/A | `C:\Users\<user>` | N/A |
| `$XDG_CONFIG_HOME` | `~/.config` (default) | N/A | `~/.config` (default) |

---

## Sources

- [Claude Code Settings Documentation](https://code.claude.com/docs/en/settings)
- [Claude Desktop MCP Setup](https://support.claude.com/en/articles/10949351-getting-started-with-local-mcp-servers-on-claude-desktop)
- [Cursor Rules Documentation](https://docs.cursor.com/context/rules)
- [GitHub Copilot Custom Instructions](https://docs.github.com/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)
- [Windsurf Documentation](https://docs.windsurf.com/windsurf/getting-started)
- [Continue Configuration](https://docs.continue.dev/customize/deep-dives/configuration)
- [Aider Configuration](https://aider.chat/docs/config/aider_conf.html)
- [OpenAI Codex Configuration](https://developers.openai.com/codex/config-reference/)
- [Gemini CLI Configuration](https://geminicli.com/docs/get-started/configuration/)
- [Amazon Q Developer Settings](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line-settings.html)
- [Zed Editor Configuration](https://zed.dev/docs/configuring-zed)
- [Sourcegraph Cody Documentation](https://sourcegraph.com/docs/cody)
