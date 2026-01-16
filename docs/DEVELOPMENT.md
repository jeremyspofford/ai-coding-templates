# Developing AI Coding Templates

## Repository Structure

This repository contains templates for three AI coding assistants:

```text
ai-coding-templates/
├── .claude/          # Claude Code templates
│   ├── config.json   # Plugins
│   ├── CLAUDE.md     # Project guidelines template
│   ├── rules/        # Shared coding standards (actual files)
│   └── skills/       # n8n workflow skills
├── .cursor/          # Cursor templates
│   ├── rules/        # Shared coding standards (actual files)
│   └── commands/     # Custom commands
├── .agent/           # Antigravity templates
│   ├── rules/        # Shared coding standards (actual files)
│   └── workflows/    # Automated workflows
└── shared/rules/     # Source of truth for editing
```

## Workflow for Maintaining Shared Rules

1. **Edit rules** in `shared/rules/`
   - Edit both `.md` (Claude/Antigravity) and `.mdc` (Cursor) versions
   - Keep content semantically equivalent across formats

2. **Sync to tool directories**

   ```bash
   ./scripts/sync-shared-rules.sh
   ```

   This copies shared rules to all three tool directories

3. **Verify changes**

   ```bash
   # Check that files were copied
   ls -la .claude/rules/
   ls -la .cursor/rules/
   ls -la .agent/rules/
   ```

4. **Test with setup script**

   ```bash
   ./scripts/setup-project.sh --name test-project --tools all
   cd test-project
   # Verify the configs work
   cd ..
   rm -rf test-project
   ```

5. **Commit changes**

   ```bash
   git add shared/rules/ .claude/rules/ .cursor/rules/ .agent/rules/
   git commit -m "Update shared rules"
   ```

## Common Development Tasks

### Adding a New Shared Rule

1. Create both format versions:

   ```bash
   vim shared/rules/my-new-rule.md
   vim shared/rules/my-new-rule.mdc
   ```

2. Sync to all tools:

   ```bash
   ./scripts/sync-shared-rules.sh
   ```

3. Test and commit:

   ```bash
   ./scripts/setup-project.sh --name test --tools all
   cd test && ls -la .claude/rules/ && cd ..
   git add shared/rules/ .claude/rules/ .cursor/rules/ .agent/rules/
   git commit -m "Add new-rule"
   ```

### Updating Tool-Specific Configuration

Edit directly in root directories:

- **Claude**: `.claude/config.json`, `.claude/CLAUDE.md`, `.claude/skills/`
- **Cursor**: `.cursor/rules/`, `.cursor/commands/`
- **Antigravity**: `.agent/rules/`, `.agent/workflows/`

Commit these changes alongside any related shared rule changes.

### Testing Changes

```bash
# Test that setup script works
./scripts/setup-project.sh --name verify-test --tools all

cd verify-test

# Check all configs are present
ls -la .claude/rules/
ls -la .cursor/rules/
ls -la .agent/rules/

# Verify files are actual files, not symlinks
file .claude/rules/markdown-linting.md  # Should say "ASCII text"

cd ..
rm -rf verify-test
```

## Key Principles

1. **Shared rules are the source of truth** - Edit in `shared/rules/`
2. **Sync after editing** - Run `scripts/sync-shared-rules.sh` after changes
3. **Maintain dual formats** - Keep `.md` and `.mdc` in sync
4. **Test before committing** - Verify with `setup-project.sh`
5. **Actual files, no symlinks** - Tool directories contain real files for project independence

## Documentation References

- [README.md](../README.md) - Quick start and project overview
- [GLOBAL_CONFIG.md](./GLOBAL_CONFIG.md) - Global AI tool settings reference
