# Quick Start Guide

Get started with AI coding templates in 5 minutes.

## The Fastest Way: Setup Script

```bash
cd ~/workspace/ai-coding-templates
./scripts/setup-project.sh --name my-awesome-project --tools all --git

cd my-awesome-project
# Done! Ready to code
```

That's it. You now have:

- `.claude/` - Claude Code configuration
- `.cursor/` - Cursor configuration
- `.agent/` - Antigravity configuration
- `.gitignore` - Common defaults
- `README.md` - Project setup guide
- `.git/` - Initialized git repository

## Manual: Clone & Customize

```bash
# 1. Clone template
git clone https://github.com/your-org/ai-coding-templates.git my-new-project
cd my-new-project

# 2. Start fresh (remove template history)
rm -rf .git
git init
git add .
git commit -m "Initial commit with AI templates"

# 3. Customize for your project
# Edit .claude/config.json
# Edit .claude/instructions.md
# Edit .cursor/rules/ as needed
# etc.
```

## Copy into Existing Project

```bash
# Add Claude configuration
cp -r ~/workspace/ai-coding-templates/claude/project-config/.claude ./MY_PROJECT/

# Add Cursor configuration
cp -r ~/workspace/ai-coding-templates/cursor/project-config/.cursor ./MY_PROJECT/

# Add Antigravity configuration
cp -r ~/workspace/ai-coding-templates/antigravity/project-config/.agent ./MY_PROJECT/
```

## What You Get

### Claude Code (.claude/)

```text
.claude/
├── config.json              # Plugins configuration
├── instructions.md          # Project guidelines
├── settings.local.json      # Local overrides
├── rules/
│   ├── markdown-linting.md
│   ├── coding-practices.md
│   └── tdd-workflow.md
└── skills/                  # (Optional) Project skills
```

**First Steps:**

1. Edit `config.json` to add project-specific plugins
2. Edit `instructions.md` with your project details
3. Review rules in `rules/` directory

### Cursor (.cursor/)

```text
.cursor/
├── rules/
│   ├── markdown-linting.mdc
│   ├── coding-practices.mdc
│   ├── tdd-workflow.mdc
│   └── repo-overview.mdc
└── commands/
    ├── commit-and-push.md
    └── generate-mr-description.md
```

**First Steps:**

1. Review rules in `rules/`
2. Customize commands in `commands/`

### Antigravity (.agent/)

```text
.agent/
├── rules/
│   ├── markdown-linting.md
│   ├── tdd-workflow.md
│   └── coding-practices.md
└── workflows/
    ├── commit-and-push.md
    ├── tdd-workflow.md
    ├── feature-flag.md
    └── generate-mr-description.md
```

**First Steps:**

1. Review workflows in `workflows/`
2. Customize rules in `rules/`

## Beads Memory System

All templates include [Beads](https://github.com/steveyegge/beads) integration for shared agent memory.

- **Setup**: `scripts/setup-memory.sh` (run automatically)
- **Protocol**: `AGENTS.md` (shared instructions)
- **Usage**:
  - `bd ready` - Find work
  - `bd create` - Track tasks
  - `bd close` - Complete work

## Next Steps

After setup:

```bash
cd my-new-project

# 1. Customize Claude config (if using Claude)
vim .claude/config.json
vim .claude/instructions.md

# 2. Test your setup
claude --version  # Should work
cursor --version  # Should work

# 3. Make initial commit
git add .
git commit -m "Customize AI settings for this project"

# 4. Start developing!
```

## Common Tasks

### Add Claude Plugins

Edit `.claude/config.json`:

```json
{
  "enabledPlugins": {
    "github@claude-plugins-official": true,
    "code-review@claude-plugins-official": true,
    "typescript-lsp@claude-plugins-official": true,
    "YOUR_PLUGIN@source": true
  }
}
```

### Add Custom Claude Rules

Create file in `.claude/rules/your-rule.md`:

```markdown
# Your Custom Rule

Description of the rule...
```

### Customize Cursor Rules

Edit `.cursor/rules/*.mdc` files or create new ones.

### Create Antigravity Workflow

Create file in `.agent/workflows/your-workflow.md`:

```markdown
# Your Workflow Name

Description...
```

## Troubleshooting

### Command not found: setup-project.sh

```bash
chmod +x ~/workspace/ai-coding-templates/scripts/setup-project.sh
```

### Project directory already exists

```bash
# Use different project name or remove existing directory
./scripts/setup-project.sh --name different-name --tools all
```

### Can't find template files

```bash
# Make sure you're in the ai-coding-templates directory
cd ~/workspace/ai-coding-templates
./scripts/setup-project.sh --name my-project --tools all
```

## Interactive Mode

Don't remember the flags? Use interactive mode:

```bash
./scripts/setup-project.sh
# Follow prompts for project name and tool selection
```

## Need Help?

- See [SETUP_GUIDE.md](./SETUP_GUIDE.md) for detailed per-tool setup
- See [TOOL_REFERENCE.md](./TOOL_REFERENCE.md) for tool comparison
- See [FAQ.md](./FAQ.md) for common questions
