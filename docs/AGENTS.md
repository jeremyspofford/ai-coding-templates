# AI Agents Guide

This guide explains how to use the AI agents included in this template across Claude Code, Cursor, and Antigravity.

## Table of Contents

- [TL;DR - Which Agent Should I Use?](#tldr---which-agent-should-i-use)
- [Quick Reference](#quick-reference)
- [The Easy Way: Use @lead](#the-easy-way-use-lead)
- [Tool Capabilities Comparison](#tool-capabilities-comparison)
- [Getting Started: Quick Examples](#getting-started-quick-examples)
- [Orchestrated Workflows (Claude Code Only)](#orchestrated-workflows-claude-code-only)
- [How to Invoke Agents](#how-to-invoke-agents)
- [The Core Triad](#the-core-triad)
  - [1. The Architect](#1-the-architect)
  - [2. The Builder](#2-the-builder)
  - [3. The QA/Reviewer](#3-the-qareviewer)
- [Specialized Agents](#specialized-agents)
  - [4. The Test Writer](#4-the-test-writer)
  - [5. The Security Auditor](#5-the-security-auditor)
  - [6. The Docs Writer](#6-the-docs-writer)
  - [7. The Performance Optimizer](#7-the-performance-optimizer)
  - [8. The Refactoring Specialist](#8-the-refactoring-specialist)
- [Typical Workflows](#typical-workflows)
- [Agent Interaction Diagram](#agent-interaction-diagram)
- [Tips for Best Results](#tips-for-best-results)
- [File Locations](#file-locations)
- [Customizing Agents](#customizing-agents)

---

## TL;DR - Which Agent Should I Use?

| Your Situation | Use This | Why |
| -------------- | -------- | --- |
| **"Just build this feature"** | `@lead` | Single agent handles everything end-to-end |
| **"Complex multi-phase project"** | Orchestrator + agents | Full control with automatic delegation |
| **"Specific task"** | Individual agent | Targeted expertise |

---

## Quick Reference

| Agent | What It Does | When to Use |
| ----- | ------------ | ----------- |
| **Lead** ⭐ | Full workflow (plan → build → review) | **Recommended starting point** |
| **Architect** | Creates implementation plans | Complex system design |
| **Builder** | Writes code following plans | After Architect creates a plan |
| **QA/Reviewer** | Reviews code for issues | After Builder completes code |
| **Test Writer** | Writes comprehensive tests | When you need test coverage |
| **Security Auditor** | Finds vulnerabilities | Before deployment |
| **Docs Writer** | Creates documentation | When code needs docs |
| **Perf Optimizer** | Finds performance issues | When code is slow |
| **Refactoring** | Plans code cleanup | When code is messy |

---

## The Easy Way: Use @lead

**For most tasks, just use `@lead` and describe what you want.**

The Lead agent combines Architect + Builder + QA into one workflow:

```text
@lead Add a user registration feature with email verification
```

The Lead will:

1. Design the solution and ask for approval
2. Implement with TDD
3. Self-review for issues
4. Report completion

**When to use specialized agents instead:**

- You want more control over each phase
- You need deep expertise (security audit, performance analysis)
- You're working on a large project with multiple contributors

---

## Tool Capabilities Comparison

| Capability | Claude Code | Cursor | Antigravity |
| ---------- | ----------- | ------ | ----------- |
| Spawn sub-agents | ✅ Yes | ❌ No | ❌ No |
| Orchestration | ✅ Full | ❌ Manual | ❌ Manual |
| Best approach | Orchestrator + agents | `/lead` command | `lead` workflow |

**What this means:**

- **Claude Code**: Can automatically delegate to specialized agents (e.g., spawn `@architect`, then `@builder`, then `@qa-reviewer`)
- **Cursor/Antigravity**: Use the `lead` command/workflow which combines all capabilities into one

---

## Getting Started: Quick Examples

### Claude Code (Full Orchestration)

Just describe what you want, and Claude will automatically delegate to specialized agents:

```text
User: Build a payment processing system with Stripe integration

Claude (using orchestrator skill):
→ Spawns @architect to create PLAN.md
→ Shows plan for approval
→ Spawns @builder to implement Phase 1
→ Spawns @qa-reviewer to review
→ Spawns @security-auditor for payment security
→ Reports completion
```

For simpler tasks, use `@lead` directly:

```text
@lead Add a CSV export feature to the user service
```

### Cursor Example

Use the `/lead` command for end-to-end development:

```text
/lead Add user authentication with password reset
```

The Lead handles planning → implementation → review in one flow.

### Antigravity Example

Use the `lead` workflow:

```text
lead Add a notification system for order updates
```

---

## Orchestrated Workflows (Claude Code Only)

For complex projects, the **Orchestrator skill** tells Claude how to automatically delegate to specialized agents.

**How it works**: The main Claude conversation can spawn sub-agents. The orchestrator skill provides patterns for when to use each agent.

**Example**: You say "Build a payment system" and Claude:

1. Spawns `@architect` to create the plan
2. Shows you the plan for approval
3. Spawns `@builder` to implement
4. Spawns `@qa-reviewer` to check
5. Spawns `@security-auditor` for payment security
6. Reports completion

The orchestrator skill is at `.claude/skills/orchestrator/SKILL.md`.

**Note**: This orchestration only works in Claude Code. For Cursor and Antigravity, use `/lead` or the `lead` workflow instead.

---

## How to Invoke Agents

### Claude Code

Use `@agent-name` to invoke a sub-agent:

```text
@lead Build a user authentication system (recommended for most tasks)
@architect Design a user authentication system
@builder Execute Phase 1 of the plan
@qa-reviewer Review the authentication implementation
@test-writer Write tests for UserService
@security-auditor Audit the auth module
@docs-writer Document the API endpoints
@perf-optimizer Analyze the database queries
@refactoring Plan cleanup of UserService
```

### Cursor Commands

Use the command palette or type the command name:

```text
/lead - Full workflow: plan → build → review (RECOMMENDED)
/architect - Design systems and create plans
/builder - Execute implementation plans
/qa-review - Review code for issues
/test-writer - Write comprehensive tests
/security-audit - Find security vulnerabilities
/docs-writer - Create documentation
/perf-optimize - Find performance bottlenecks
/refactor - Plan code improvements
```

### Antigravity Workflows

Workflows are invoked by name or trigger:

```text
lead - Full workflow: plan → build → review (RECOMMENDED)
architect - Create implementation plans
builder - Execute plans with TDD
qa-review - Review implementations
test-writer - Write test suites
security-audit - Security assessment
docs-writer - Generate documentation
perf-optimize - Performance analysis
refactor - Plan refactoring
```

---

## The Core Triad

These three agents work together as a development workflow.

### 1. The Architect

**Purpose**: Creates high-level designs and implementation plans. Never writes code.

**Output**: `PLAN.md` file with phases, steps, and acceptance criteria.

**Example Usage**:

```text
Claude Code:  @architect Design a payment processing system
Cursor:       /architect payment processing
Antigravity:  Use the architect workflow
```

**What You Get**:

```markdown
# Implementation Plan: Payment Processing

## Phase 1: Setup
- [ ] Step 1.1: Create PaymentService interface
- [ ] Step 1.2: Add Stripe dependency

## Phase 2: Core Logic
- [ ] Step 2.1: Implement charge method
...
```

**Next Step**: Hand the plan to the Builder.

---

### 2. The Builder

**Purpose**: Executes plans using Test-Driven Development (TDD).

**Process**: Red → Green → Refactor → Verify (Ralph Loop)

**Example Usage**:

```text
Claude Code:  @builder Execute Phase 1 from PLAN.md
Cursor:       /builder Phase 1
Antigravity:  Use the builder workflow with PLAN.md
```

**What You Get**:

- Working code that follows the plan exactly
- Tests written before implementation (TDD)
- Progress updates after each step

**Next Step**: Send completed code to QA/Reviewer.

---

### 3. The QA/Reviewer

**Purpose**: Reviews code against plans and standards. Finds bugs but doesn't fix them.

**Output**: `REVIEW.md` with findings categorized by severity.

**Example Usage**:

```text
Claude Code:  @qa-reviewer Review the PaymentService implementation
Cursor:       /qa-review PaymentService
Antigravity:  Use the qa-review workflow
```

**What You Get**:

```markdown
# Code Review Report

## Summary
| Severity | Count |
| -------- | ----- |
| HIGH | 2 |
| MEDIUM | 3 |

## Findings
### [HIGH] Missing null check
File: src/services/PaymentService.ts:42
...
```

**Next Step**: Builder fixes the issues, then re-review.

---

## Specialized Agents

### 4. The Test Writer

**Purpose**: Creates comprehensive test suites with edge case coverage.

**Focus**: Happy paths, edge cases, error handling, security scenarios.

**Example Usage**:

```text
Claude Code:  @test-writer Write tests for UserService
Cursor:       /test-writer UserService
Antigravity:  Use the test-writer workflow
```

**What You Get**:

- Test files following AAA pattern (Arrange-Act-Assert)
- Edge case coverage (empty, null, boundaries)
- Error path testing

**Best For**: Starting TDD, improving coverage, adding edge cases.

---

### 5. The Security Auditor

**Purpose**: Identifies security vulnerabilities using OWASP Top 10.

**Output**: `SECURITY_AUDIT.md` with findings and remediation steps.

**Example Usage**:

```text
Claude Code:  @security-auditor Audit the authentication module
Cursor:       /security-audit auth
Antigravity:  Use the security-audit workflow
```

**What You Get**:

```markdown
# Security Audit Report

## Findings
### [HIGH] SQL Injection
File: src/repositories/UserRepository.ts:67
OWASP: A03:2021 - Injection

Vulnerable:
const query = `SELECT * WHERE id = ${id}`;

Fix:
db.query('SELECT * WHERE id = ?', [id]);
```

**Best For**: Pre-deployment review, auth/payment code, user input handling.

---

### 6. The Docs Writer

**Purpose**: Creates clear, accurate documentation.

**Types**: API docs, README files, inline comments, architecture docs.

**Example Usage**:

```text
Claude Code:  @docs-writer Document the PaymentService API
Cursor:       /docs-writer PaymentService
Antigravity:  Use the docs-writer workflow
```

**What You Get**:

- API documentation with examples
- README files for modules
- Properly formatted markdown (MD040/MD060 compliant)

**Best For**: New modules, public APIs, onboarding docs.

---

### 7. The Performance Optimizer

**Purpose**: Identifies performance bottlenecks and recommends fixes.

**Output**: `PERFORMANCE_REPORT.md` with analysis and recommendations.

**Example Usage**:

```text
Claude Code:  @perf-optimizer Analyze the user listing endpoint
Cursor:       /perf-optimize user listing
Antigravity:  Use the perf-optimize workflow
```

**What You Get**:

```markdown
# Performance Analysis

## Hotspots
### N+1 Query Problem
File: src/services/UserService.ts:89
Impact: 78% of response time

Current: 101 queries for 100 users
Fix: Eager loading
Expected: 97% improvement
```

**Best For**: Slow endpoints, high memory usage, database issues.

---

### 8. The Refactoring Specialist

**Purpose**: Identifies code smells and plans safe refactoring.

**Output**: `REFACTORING_PLAN.md` with incremental transformation steps.

**Example Usage**:

```text
Claude Code:  @refactoring Plan cleanup of UserService
Cursor:       /refactor UserService
Antigravity:  Use the refactor workflow
```

**What You Get**:

```markdown
# Refactoring Plan

## Code Smells Found
| Location | Smell | Pattern to Apply |
| -------- | ----- | ---------------- |
| UserService | God Class | Extract Class |
| processOrder() | Long Method | Extract Method |

## Safe Transformation Steps
1. Add missing tests (prerequisite)
2. Extract EmailValidator class
3. Extract NotificationService
...
```

**Best For**: Technical debt, messy code, before major changes.

---

## Typical Workflows

### New Feature Development

```text
1. @architect Design the feature
2. Review PLAN.md, approve or refine
3. @builder Execute Phase 1
4. @qa-reviewer Review Phase 1
5. Fix any issues
6. Repeat for remaining phases
7. @docs-writer Document the feature
8. @security-auditor Final security check
```

### Bug Fix with TDD

```text
1. @test-writer Write a failing test for the bug
2. @builder Fix the bug (make test pass)
3. @qa-reviewer Review the fix
```

### Performance Investigation

```text
1. @perf-optimizer Analyze the slow endpoint
2. Review PERFORMANCE_REPORT.md
3. @architect Plan the optimization
4. @builder Implement the fix
5. @perf-optimizer Verify improvement
```

### Code Cleanup

```text
1. @refactoring Analyze UserService
2. Review REFACTORING_PLAN.md
3. @test-writer Add missing test coverage
4. @builder Execute refactoring steps
5. @qa-reviewer Verify behavior unchanged
```

---

## Agent Interaction Diagram

```text
                    ┌─────────────┐
                    │   Architect │
                    │  (Planning) │
                    └──────┬──────┘
                           │ PLAN.md
                           ▼
                    ┌─────────────┐
                    │   Builder   │
                    │   (Code)    │
                    └──────┬──────┘
                           │ Implementation
           ┌───────────────┼───────────────┐
           ▼               ▼               ▼
    ┌────────────┐  ┌────────────┐  ┌────────────┐
    │    QA      │  │  Security  │  │   Perf     │
    │  Reviewer  │  │  Auditor   │  │ Optimizer  │
    └─────┬──────┘  └────────────┘  └────────────┘
          │
          │ Issues found?
          ▼
    ┌─────────────┐
    │   Builder   │ (Fix issues)
    └─────────────┘
```

---

## Tips for Best Results

### Be Specific

```text
❌ @architect Make a user system
✅ @architect Design a user authentication system with email/password login,
   password reset, and session management
```

### Provide Context

```text
❌ @qa-reviewer Review the code
✅ @qa-reviewer Review the PaymentService implementation against PLAN.md,
   focusing on error handling and edge cases
```

### Use the Right Agent

| Task | Agent |
| ---- | ----- |
| "Build X for me" | **Lead** (recommended default) |
| "How should we build X?" | Architect |
| "Build X following the plan" | Builder |
| "Is this code good?" | QA/Reviewer |
| "Write tests for X" | Test Writer |
| "Is this secure?" | Security Auditor |
| "Document X" | Docs Writer |
| "Why is X slow?" | Perf Optimizer |
| "Clean up X" | Refactoring |

---

## File Locations

| Tool | Location | Format |
| ---- | -------- | ------ |
| Claude Code | `.claude/agents/*.md` | YAML frontmatter + Markdown |
| Cursor | `.cursor/commands/*.md` | Markdown |
| Antigravity | `.agent/workflows/*.md` | YAML frontmatter + Markdown |

---

## Customizing Agents

Each agent can be customized by editing its definition file:

1. **Change constraints** - Modify the "YOU MUST / YOU MUST NOT" table
2. **Adjust output format** - Change the template sections
3. **Add domain knowledge** - Include project-specific patterns
4. **Modify triggers** - Update activation patterns

Example: Adding a project-specific pattern to the Builder:

```markdown
## Project Patterns

When creating services, always:
- Use dependency injection via constructor
- Extend BaseService class
- Add to the service registry in `src/registry.ts`
```

---

*For more details, see the individual agent files in `.claude/agents/`, `.cursor/commands/`, or `.agent/workflows/`.*
