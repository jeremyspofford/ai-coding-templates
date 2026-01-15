# AI Coding Templates

Unified configuration templates for AI coding assistants: **Claude Code**, **Cursor**, and **Antigravity**.

This repository provides ready-to-use project templates with best practices, coding standards, and tool-specific configurations.

## Quick Start

### Option 1: Clone & Customize (Recommended)

```bash
# Clone the template
git clone https://github.com/your-org/ai-coding-templates.git my-new-project
cd my-new-project

# Remove template git history and start fresh
rm -rf .git
git init
git add .
git commit -m "Initial commit with AI coding templates"

# Customize for your project
# Edit .claude/config.json (add plugins)
# Edit .claude/instructions.md (project guidelines)
```

### Option 2: Automated Setup

```bash
# From ai-coding-templates directory
./scripts/setup-project.sh --name my-project --tools all

# Or interactive mode
./scripts/setup-project.sh
```

### Option 3: Copy into Existing Project

```bash
cp -r ai-coding-templates/claude/project-config/.claude MY_PROJECT/
cp -r ai-coding-templates/cursor/project-config/.cursor MY_PROJECT/
cp -r ai-coding-templates/antigravity/project-config/.agent MY_PROJECT/
```

## Repository Structure

```
ai-coding-templates/
├── claude/                   # Claude Code templates
│   ├── global-config/        # Reference global config
│   └── project-config/       # Copy to projects → .claude/
├── cursor/                   # Cursor templates
│   ├── global-config/        # Reference global config
│   └── project-config/       # Copy to projects → .cursor/
├── antigravity/              # Antigravity templates
│   ├── global-config/        # Reference global config
│   └── project-config/       # Copy to projects → .agent/
├── shared/                   # Shared across all tools
│   ├── .gitignore
│   └── rules/                # Multi-format rules
├── docs/                     # Documentation
├── scripts/                  # setup-project.sh automation
└── README.md
```

## Tools Supported

### Claude Code
- Configuration: `.claude/`
- Plugins management, rules, skills
- See: `claude/project-config/`

### Cursor
- Configuration: `.cursor/`
- Rules (`.mdc` format), commands
- See: `cursor/project-config/`

### Antigravity
- Configuration: `.agent/`
- Rules, workflows
- See: `antigravity/project-config/`

## Usage

### 1. Clone & Customize
Best for starting a brand new project from templates.

```bash
git clone <repo> my-project
cd my-project
rm -rf .git && git init
# Customize .claude/, .cursor/, .agent/ as needed
git add . && git commit -m "Initial commit"
```

### 2. Automated Setup
Quick bootstrap with tool selection.

```bash
./scripts/setup-project.sh --name my-project --tools claude,cursor,antigravity
cd my-project
```

### 3. Copy to Existing Project
Add AI configurations to existing projects.

```bash
cp -r claude/project-config/.claude my-existing-project/
cp -r cursor/project-config/.cursor my-existing-project/
```

## Setup Script

Fast project creation with `./scripts/setup-project.sh`:

```bash
# Non-interactive with all tools
./scripts/setup-project.sh --name my-project --tools all --git

# Claude only
./scripts/setup-project.sh --name my-project --tools claude

# Interactive (prompts for options)
./scripts/setup-project.sh
```

## Documentation

- **[PROJECT_DESCRIPTION.md](./PROJECT_DESCRIPTION.md)** - What this is
- **[docs/QUICK_START.md](./docs/QUICK_START.md)** - Getting started
- **[docs/SETUP_GUIDE.md](./docs/SETUP_GUIDE.md)** - Per-tool setup
- **[docs/TOOL_REFERENCE.md](./docs/TOOL_REFERENCE.md)** - Tool comparison
- **[docs/WORKFLOWS.md](./docs/WORKFLOWS.md)** - Best practices
- **[docs/FAQ.md](./docs/FAQ.md)** - Common questions

## Shared Configuration

Rules available in both `.md` (Claude) and `.mdc` (Cursor) formats:

- **markdown-linting** - MD040, MD060 standards
- **coding-practices** - Type safety, no `any`
- **tdd-workflow** - Ralph Loop testing process

Located in: `shared/rules/`

## Global Configuration Reference

Per-tool global settings examples:

- `claude/global-config/` - Claude global config reference
- `cursor/global-config/` - Cursor global rules reference
- `antigravity/global-config/` - Antigravity setup reference

These are **references only**, customize to your needs.

## Customization

After setup, edit these files per project:

**Claude:**
- `.claude/config.json` - Plugins
- `.claude/instructions.md` - Project guidelines
- `.claude/settings.local.json` - Local overrides

**Cursor:**
- `.cursor/rules/` - Custom rules

**Antigravity:**
- `.agent/rules/` - Custom rules
- `.agent/workflows/` - Workflows

## Contributing

Improve these templates:
1. Clone & modify
2. Test with projects
3. Submit improvements

## License

[Add your license]

---

**For:** Claude Code, Cursor, Antigravity  
**Updated:** 2026-01-15
