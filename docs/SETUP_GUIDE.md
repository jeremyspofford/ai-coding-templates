# Tool-Specific Setup Guide

Detailed setup instructions for each AI coding assistant.

## Claude Code Setup

### 1. Initial Setup

Copy Claude template to your project:

```bash
cp -r ~/workspace/ai-coding-templates/claude/project-config/.claude MY_PROJECT/
```

### 2. Configure Plugins

Edit `.claude/config.json`:

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
  "customInstructions": "file://./instructions.md"
}
```

**Key Fields:**
- `enabledPlugins` - Which plugins Claude can use
- `customInstructions` - Points to `instructions.md`

### 3. Add Project Guidelines

Edit `.claude/instructions.md`:

```markdown
# My Project Guidelines

## Overview
[Project description]

## Tech Stack
- TypeScript, React, Node.js, etc.

## Coding Standards
- Follow .claude/rules/markdown-linting.md
- Follow .claude/rules/coding-practices.md
- Follow .claude/rules/tdd-workflow.md

## Build & Test
```bash
npm run test
npm run build
```

## Key Contacts
[Your team info]
```

### 4. Review Standards

Check these files for project standards:

- `.claude/rules/markdown-linting.md` - MD040, MD060 rules
- `.claude/rules/coding-practices.md` - TypeScript standards
- `.claude/rules/tdd-workflow.md` - Testing process (Ralph Loop)

### 5. Restart Claude

Close and reopen Claude Code to load new configuration.

### Claude Global Config (Optional)

For global Claude settings, see: `~/workspace/ai-coding-templates/claude/global-config/settings.json`

This is a **reference only**. Customize your `~/.claude/settings.json` as needed.

---

## Cursor Setup

### 1. Initial Setup

Copy Cursor template to your project:

```bash
cp -r ~/workspace/ai-coding-templates/cursor/project-config/.cursor MY_PROJECT/
```

### 2. Review Rules

Check `.cursor/rules/`:

- `markdown-linting.mdc` - Markdown standards
- `coding-practices.mdc` - Coding conventions
- `tdd-workflow.mdc` - Testing process
- `repo-overview.mdc` - Repository structure

### 3. Customize Rules

Edit `.cursor/rules/*.mdc` files:

Rules use `.mdc` format (Cursor's markdown extension):

```mdc
# Custom Rule Name

- Point 1
- Point 2
- Point 3
```

### 4. Add Custom Commands

Create new commands in `.cursor/commands/`:

```markdown
# My Custom Command

[Description of what this command does]

[Implementation details]
```

### 5. Restart Cursor

Close and reopen Cursor to load new configuration.

### Cursor Global Config (Optional)

For global Cursor settings, see: `~/workspace/ai-coding-templates/cursor/global-config/`

This is a **reference only** for structure and best practices.

---

## Antigravity Setup

### 1. Initial Setup

Copy Antigravity template to your project:

```bash
cp -r ~/workspace/ai-coding-templates/antigravity/project-config/.agent MY_PROJECT/
```

### 2. Review Rules

Check `.agent/rules/`:

- `markdown-linting.md` - Markdown standards
- `coding-practices.md` - Coding conventions
- `tdd-workflow.md` - Testing process

### 3. Review Workflows

Check `.agent/workflows/`:

- `commit-and-push.md` - Automated commits
- `tdd-workflow.md` - TDD automation
- `feature-flag.md` - Feature flag workflow
- `generate-mr-description.md` - MR description generation

### 4. Customize Workflows

Edit `.agent/workflows/*.md` or create new:

```markdown
# Custom Workflow Name

## Description
What this workflow does.

## Steps
1. Step 1
2. Step 2
3. Step 3

## Triggers
When this workflow runs.
```

### 5. Restart Antigravity

Close and reopen Antigravity to load new configuration.

### Antigravity Global Config (Optional)

For global Antigravity settings, see: `~/workspace/ai-coding-templates/antigravity/global-config/`

This is a **reference only** for structure and best practices.

---

## Multi-Tool Setup

Use all three tools in the same project:

```bash
cp -r ai-coding-templates/claude/project-config/.claude MY_PROJECT/
cp -r ai-coding-templates/cursor/project-config/.cursor MY_PROJECT/
cp -r ai-coding-templates/antigravity/project-config/.agent MY_PROJECT/
```

Now you have consistent:
- **Rules** - Same coding standards across all tools
- **Workflows** - Consistent automation
- **Commands** - Same development experience

### Keeping Consistency

When updating rules:

1. Edit rule in one format (e.g., `.md`)
2. Update corresponding format (e.g., `.mdc`)
3. Commit changes to version control

Examples:
- `shared/rules/markdown-linting.md` - Claude format
- `shared/rules/markdown-linting.mdc` - Cursor format

---

## Global Configuration

### Claude Global Config

Reference: `claude/global-config/settings.json`

This shows a minimal global config with 7 essential plugins:
- github
- code-review
- commit-commands
- typescript-lsp
- explanatory-output-style
- learning-output-style
- hookify

**Use this as a reference**, customize `~/.claude/settings.json` for your environment.

### Cursor Global Config

Reference: `cursor/global-config/`

Cursor stores global settings in `~/.cursor/`. Review the reference for structure.

### Antigravity Global Config

Reference: `antigravity/global-config/`

Antigravity stores global settings in `~/.agent/`. Review the reference for structure.

---

## Troubleshooting

### Claude can't find customInstructions

Check `.claude/config.json`:
```json
{
  "customInstructions": "file://./instructions.md"
}
```

Path must be relative to `.claude/` directory.

### Cursor rules not showing up

Make sure `.cursor/rules/` files end in `.mdc`:
```bash
# These work:
.cursor/rules/my-rule.mdc
.cursor/rules/coding.mdc

# These don't:
.cursor/rules/my-rule.md  # Wrong extension
.cursor/rules/my-rule     # No extension
```

### Antigravity workflows not triggering

Check `.agent/workflows/` files:
1. Ensure YAML/markdown format is correct
2. Check workflow trigger conditions
3. Verify file names match workflow references

---

## Next Steps

1. **Review Rules** - Understand coding standards
2. **Customize** - Adapt to your project needs
3. **Test** - Use each tool and verify configs work
4. **Commit** - Save configurations to git
5. **Share** - Distribute to team members

See [WORKFLOWS.md](./WORKFLOWS.md) for best practices.
