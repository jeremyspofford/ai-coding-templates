# Project Guidelines for Claude Code

This file contains project-specific guidelines for Claude Code AI assistant.

## Project Overview

- **Name:** [Your Project Name]
- **Purpose:** [What this project does]
- **Tech Stack:** [Languages, frameworks, tools]

## Repository Structure

[Describe your project structure]

## Development Setup

- **Dependencies:** [How to install]
- **Environment:** [Local dev setup]
- **Testing:** [How to run tests]

## Coding Standards

- Follow the rules in `.claude/rules/`
- Follow TDD workflow from `.claude/rules/tdd-workflow.md`
- TypeScript: No `any`, prefer `interface`
- Markdown: All code blocks must have language tags (MD040)

## Project-Specific Plugins

Configure in `.claude/config.json`:

```json
{
  "enabledPlugins": {
    // Add project-specific plugins here
  }
}
```

## Common Commands

- Tests: `npm run test`
- Build: `npm run build`
- Lint: `npm run lint`

## Getting Help

Refer to `.claude/rules/` for coding standards and workflows.
