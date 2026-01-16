# Ralph Loop: Autonomous AI Development

This guide covers the Ralph Loop methodology for iterative, AI-assisted development.

## What is Ralph?

Ralph is **two complementary concepts**:

1. **Ralph Loop (TDD Workflow)** - A test-driven development cycle: Red → Green → Refactor → Verify
2. **Ralph Orchestrator** - An autonomous looping mechanism that runs an AI agent until completion

### Philosophy

> "Deterministically bad in an undeterministic world"

Instead of expecting perfection from AI, Ralph embraces iteration:

- Failures become calibration opportunities
- Each misstep tunes the prompt for better results
- Persistence wins over perfection

**Real-world results**:

- $50k contract completed for ~$297 in API costs
- 6 repositories generated overnight at Y Combinator hackathon
- Entire programming language created over 3 months

## Two Modes of Operation

| Mode | Tool | Best For |
| ---- | ---- | -------- |
| **Interactive** | ralph-wiggum plugin | Active development with TDD discipline |
| **Unattended** | frankbria/ralph CLI | Overnight/autonomous greenfield work |

---

## Mode 1: Interactive (ralph-wiggum Plugin)

The ralph-wiggum plugin provides `/ralph-loop` command for interactive TDD sessions.

### Setup

The plugin is enabled in `.claude/config.json`:

```json
{
  "enabledPlugins": {
    "ralph-wiggum@claude-plugins-official": true
  }
}
```

### Usage

```bash
/ralph-loop "<prompt>" --max-iterations <n> --completion-promise "<text>"
```

**Example:**

```bash
/ralph-loop "Build a REST API for todos. Requirements:
- CRUD operations
- Input validation
- Tests with 80%+ coverage

Output LOOP_COMPLETE when done." --max-iterations 30 --completion-promise "LOOP_COMPLETE"
```

### Options

| Option | Description | Default |
| ------ | ----------- | ------- |
| `--max-iterations <n>` | Stop after N iterations | unlimited |
| `--completion-promise <text>` | Phrase that signals completion | none |

### How It Works

1. Claude receives your prompt
2. Works on the task iteratively
3. Runs tests, sees failures, fixes bugs
4. When complete, outputs the completion promise
5. Loop exits when promise detected

### Cancel a Loop

```bash
/cancel-ralph
```

---

## Mode 2: Unattended (frankbria/ralph CLI)

For overnight or autonomous operation, use the frankbria/ralph-claude-code CLI.

### Installation

```bash
# Clone and install
git clone https://github.com/frankbria/ralph-claude-code.git
cd ralph-claude-code
./install.sh

# Or use the setup script in this repo
./scripts/setup-ralph.sh
```

This creates global commands: `ralph`, `ralph-monitor`, `ralph-setup`.

### Project Setup

#### Option A: New Project

```bash
ralph-setup my-feature
cd my-feature
# Edit PROMPT.md with your requirements
ralph --monitor
```

#### Option B: Import from PRD

```bash
ralph-import requirements.md my-feature
cd my-feature
ralph --monitor
```

### Running

```bash
# With integrated monitoring (recommended)
ralph --monitor

# Without monitoring
ralph

# With options
ralph --calls 50 --timeout 30 --verbose
```

### CLI Options

| Option | Description | Default |
| ------ | ----------- | ------- |
| `--calls NUM` | API calls per hour | 100 |
| `--timeout MIN` | Execution timeout (1-120) | 15 |
| `--monitor` | Launch tmux dashboard | off |
| `--verbose` | Detailed progress | off |
| `--reset-circuit` | Reset circuit breaker | - |
| `--reset-session` | Clear session state | - |

### Safety Features

**Circuit Breaker** - Stops automatically after:

- 3 loops with no progress
- 5 loops with same repeated error

**Rate Limiting** - Default 100 calls/hour (configurable)

**5-Hour API Limit Handling** - Prompts to wait when Claude's usage window closes

**Session Persistence** - Context preserved across iterations

### Project Structure

```text
my-feature/
├── PROMPT.md           # Main instructions (required)
├── @fix_plan.md        # Prioritized task list
├── @AGENT.md           # Build/run commands
├── specs/              # Requirements & specs
├── src/                # Implementation code
└── logs/               # Execution logs
```

---

## The TDD Workflow (Ralph Loop Phases)

Both modes should follow the TDD workflow defined in `.claude/rules/tdd-workflow.md`:

### Phase 1: Red (Test First)

```bash
# Write a failing test
npm run test -- path/to/file.test.ts
# Expected: Test FAILS
```

### Phase 2: Green (Minimal Implementation)

```bash
# Write minimum code to pass
npm run test
# Expected: Test PASSES
```

### Phase 3: Refactor

```bash
# Clean up without breaking tests
npm run test && npm run typecheck
# Expected: Still GREEN
```

### Phase 4: Verify

```bash
# Full verification
npm run test
npm run typecheck
npm run lint
# For frontend: browser verification via MCP tools
```

### Phase 5: Complete or Loop

If requirements met:

```markdown
RALPH_STATUS:
  COMPLETION_INDICATORS: ["All tests passing", "Requirements met"]
  EXIT_SIGNAL: true

LOOP_COMPLETE
```

If more work needed: Return to Phase 1.

---

## Writing Effective Prompts

### Good Prompt Structure

```markdown
## Objective
Build [specific feature/fix] following TDD.

## Requirements
1. [Specific, testable requirement]
2. [Another requirement]
3. [Edge cases to handle]

## Constraints
- Follow existing code patterns
- Maintain 80%+ test coverage
- No breaking changes

## Completion Criteria
When ALL of the following are true:
- [ ] All requirements implemented
- [ ] All tests passing
- [ ] Type check clean
- [ ] Lint clean

Output:
RALPH_STATUS:
  COMPLETION_INDICATORS: ["All requirements implemented", "All tests passing"]
  EXIT_SIGNAL: true

LOOP_COMPLETE
```

### Prompt Best Practices

**DO:**

- Be specific about success criteria
- Include testable requirements
- Specify completion signal format
- Set reasonable iteration limits

**DON'T:**

- Leave requirements vague
- Skip completion criteria
- Run without `--max-iterations` safety
- Use for tasks requiring human judgment

---

## When to Use Each Mode

### Use Interactive (ralph-wiggum) When

- Actively developing and can monitor
- Task might need human decisions mid-way
- Working on existing codebase with context
- Debugging or investigating issues

### Use Unattended (frankbria CLI) When

- Task is well-defined with clear success criteria
- Can verify completion automatically (tests)
- Want to run overnight
- Greenfield development

### Don't Use Autonomous Mode For

- Tasks requiring human judgment
- Security-sensitive decisions
- Production debugging
- Unclear or evolving requirements

---

## Integration with Agents

### Builder Agent

The builder agent (`.claude/agents/builder.md`) uses Ralph Loop TDD:

```bash
# Spawn builder with Ralph workflow
@builder "Implement user authentication per PLAN.md"
```

Builder outputs `BUILDER_COMPLETE` when done.

### Test Writer Agent

The test-writer agent creates comprehensive test suites:

```bash
@test-writer "Add edge case tests for payment processing"
```

Outputs `TEST_WRITER_COMPLETE` when done.

---

## Troubleshooting

### Loop Won't Exit

**Cause**: Completion signal not detected

**Fix**: Ensure exact match:

```markdown
LOOP_COMPLETE
```

Not:

```markdown
LOOP COMPLETE    # Missing underscore
loop_complete    # Wrong case
```

### Circuit Breaker Opens

**Cause**: No progress or repeated errors

**Fix**:

```bash
ralph --reset-circuit
# Review and fix the issue in PROMPT.md
ralph --monitor
```

### Session Expires

**Cause**: Default 24-hour timeout

**Fix**:

```bash
ralph --reset-session
ralph --monitor
```

### Rate Limited

**Cause**: Exceeding API call limits

**Fix**: Reduce call rate:

```bash
ralph --calls 50
```

---

## Learn More

- [Original Ralph technique](https://ghuntley.com/ralph/)
- [frankbria/ralph-claude-code](https://github.com/frankbria/ralph-claude-code)
- [ralph-wiggum plugin](https://github.com/anthropics/claude-code/blob/main/plugins/ralph-wiggum/README.md)
- [TDD Workflow](./.claude/rules/tdd-workflow.md)
