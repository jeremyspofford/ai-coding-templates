# AI Coding Templates - Project Context

## Project Overview

This repository (`ai-coding-templates`) is the **Source of Truth** for standardized AI coding assistant configurations. It provides unified templates for **Claude Code**, **Cursor**, and **Antigravity (Gemini)**.

Its primary purpose is to allow developers to bootstrap new projects with consistent, high-quality AI agent instructions, rules, and workflows.

## Directory Structure

* **`.agent/`**: **Antigravity / Gemini Configuration**. This is the specific configuration for Gemini agents.
  * `AGENT.md`: The primary system prompt and project guidelines.
  * `rules/`: Markdown files defining coding standards (e.g., Markdown linting, TDD).
  * `workflows/`: Detailed step-by-step guides for complex tasks (e.g., TDD loop, security audit).
* **`.claude/`**: Configuration for **Claude Code** (config, rules, skills).
* **`.cursor/`**: Configuration for **Cursor** (rules in `.mdc` format, commands).
* **`scripts/`**: Automation tools for setting up projects.
  * `setup-project.sh`: The main bootstrapping script.
  * `setup-ralph.sh`: Installer for the "Ralph" autonomous loop CLI.
* **`docs/`**: Detailed documentation for the entire ecosystem.

## Key Workflows & Concepts

### 1. Bootstrapping New Projects

To create a new project using these templates, use the setup script:

```bash
./scripts/setup-project.sh --name <project-name> --tools all
```

This script copies the relevant configuration directories (`.agent`, `.claude`, etc.) to the new project location and initializes git.

### 2. The Ralph Loop (TDD)

This project enforces a strict **Red-Green-Refactor-Verify** loop for development, often referred to as the "Ralph Loop".

* **Red**: Write a failing test.
* **Green**: Write minimal code to pass the test.
* **Refactor**: Clean up the code.
* **Verify**: Visually verify (screenshot) or run integration tests.

See `.agent/workflows/tdd-workflow.md` for the specific instructions Gemini should follow when executing this workflow.

### 3. Rules & Standards

Rules are defined in `rules/` directories.

* **Markdown Linting**: Strict adherence to MD040 (language tags on code blocks).
* **Coding Practices**: TypeScript preference (interfaces over types, no `any`), secure coding patterns.

## Instructions for Gemini

When working within this specific repository:

1. **Maintain Consistency**: If you update a rule in `.agent/rules/`, check if a corresponding rule needs to be updated in `.claude/rules/` or `.cursor/rules/`.
2. **Respect Conventions**: Follow the existing Markdown formatting (headers, table spacing) exactly.
3. **Use Scripts**: Prefer using `scripts/setup-project.sh` for creating test cases or examples of new project structures rather than doing it manually.

When *using* a project generated from this template:

1. Read `.agent/AGENT.md` first to understand project-specific overrides.
2. Follow the workflows defined in `.agent/workflows/`.
