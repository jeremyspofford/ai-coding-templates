# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**AI Coding Templates** is a template generator for bootstrapping projects with unified AI coding assistant configurations. It provides standardized rules, workflows, and agent definitions for Claude Code (`.claude/`), Cursor (`.cursor/`), and Antigravity/Gemini (`.agent/`).

## Repository Architecture

```text
ai-coding-templates/
├── .claude/              # Claude Code configuration templates
│   ├── config.json       # Plugin configuration
│   ├── CLAUDE.md         # Template for project guidelines
│   ├── agents/           # Sub-agent definitions (@architect, @builder, etc.)
│   ├── rules/            # Coding standards (always-on)
│   ├── skills/           # Skills (code-analyzer, feature-flag, etc.)
│   └── prompts/          # Reusable prompt templates
├── .cursor/              # Cursor configuration templates
│   ├── rules/            # Rules in .mdc format
│   └── commands/         # Custom slash commands
├── .agent/               # Antigravity configuration templates
│   ├── AGENT.md          # Project guidelines template
│   ├── rules/            # Coding standards
│   └── workflows/        # Automation workflows
├── docs/                 # Documentation
├── scripts/              # Setup and utility scripts
└── lefthook.yml          # Git hooks configuration
```

## Common Commands

### Project Setup

```bash
# Bootstrap a new project with all AI tool configs
./scripts/setup-project.sh --name my-project --tools all

# Claude only
./scripts/setup-project.sh --name my-project --tools claude --git

# Interactive mode
./scripts/setup-project.sh
```

### Git Hooks (Lefthook)

```bash
# Install lefthook (required prerequisite)
brew install lefthook        # macOS
npm install -g @evilmartians/lefthook

# Set up hooks for this repo
lefthook install
```

### Secrets Scanning

```bash
# Install git-secrets (required prerequisite)
brew install git-secrets     # macOS
sudo apt-get install git-secrets  # Linux

# git-secrets auto-initializes on first commit via lefthook
```

## Agent System

This repo includes a multi-agent system for Claude Code. Key agents in `.claude/agents/`:

| Agent | Purpose | Invocation |
| ----- | ------- | ---------- |
| **Lead** | Full workflow (plan → build → review) | `@lead` |
| **Architect** | Creates PLAN.md, never writes code | `@architect` |
| **Builder** | Executes plans using TDD (Ralph Loop) | `@builder` |
| **QA/Reviewer** | Reviews code, outputs REVIEW.md | `@qa-reviewer` |
| **Test Writer** | Comprehensive test coverage | `@test-writer` |
| **Security Auditor** | OWASP-based vulnerability audit | `@security-auditor` |
| **Perf Optimizer** | Performance bottleneck analysis | `@perf-optimizer` |
| **Docs Writer** | API docs, READMEs | `@docs-writer` |
| **Refactoring** | Code smell detection, cleanup plans | `@refactoring` |

For most tasks, use `@lead` as a single point of contact. See `docs/AGENTS.md` for detailed usage.

## TDD Workflow (Ralph Loop)

All development follows Red-Green-Refactor-Verify:

1. **Red**: Write a failing test
2. **Green**: Write minimal code to pass
3. **Refactor**: Clean up without breaking tests
4. **Verify**: Run tests, check types, browser verify if frontend

Completion signal: `RALPH_loop_COMPLETE`

## Coding Standards

Enforced via `.claude/rules/`:

- **TypeScript**: No `any` type (use `unknown`), prefer `interface` over `type`
- **Markdown**: All fenced code blocks require language tags (MD040), proper table spacing (MD060)
- **Secrets**: Never commit secrets; use `.env` files (gitignored), git-secrets scans all commits

## When Modifying This Repo

1. **Cross-tool consistency**: Updates to rules in `.claude/rules/` may need corresponding updates in `.cursor/rules/` and `.agent/rules/`
2. **Format differences**: Claude/Antigravity use `.md`, Cursor uses `.mdc` with YAML frontmatter
3. **Test with setup script**: After changes, verify with `./scripts/setup-project.sh --name test --tools all`
