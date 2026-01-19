# Tool Comparison Reference

Quick comparison of Claude Code, Cursor, and Antigravity.

## Feature Matrix

| Feature | Claude | Cursor | Antigravity |
| --- | --- | --- | --- |
| **Config Format** | JSON | .mdc files | Markdown files |
| **Config Location** | `.claude/` | `.cursor/` | `.agent/` |
| **Plugin System** | Yes | Rules-based | Rules + Workflows |
| **Custom Skills** | Yes | Custom commands | Workflows |
| **Editor Integration** | IDE plugin | Built-in editor | Command line |
| **Global Config** | `~/.claude/` | `~/.cursor/` | `~/.agent/` |
| **Git Integration** | Via plugins | Commands | Workflows |
| **Memory System** | Beads (`bd`) | Beads (`bd`) | Beads (`bd`) |
| **Best For** | Flexible coding | Fast iteration | Automation |

## Configuration Differences

### Claude Code Config

- **Plugin-based** - Enable/disable plugins in JSON
- **Granular control** - Plugin per project
- **Custom instructions** - Project guidelines in markdown
- **Skills** - Optional project-specific skills

```json
{
  "enabledPlugins": { ... },
  "customInstructions": "file://./instructions.md"
}
```

### Cursor Config

- **Rule-based** - Define rules for behavior
- **Command-driven** - Custom commands in markdown
- **Declarative** - Rules describe what should happen
- **Format** - Uses `.mdc` (Cursor markdown extended)

```mdc
# Rule Name
Description and guidelines
```

### Antigravity Config

- **Workflow-based** - Automate complex tasks
- **Trigger-driven** - Workflows fire on conditions
- **Procedural** - Step-by-step automation
- **Format** - Markdown with YAML front matter

```markdown
# Workflow Name
- Step 1
- Step 2
- Step 3
```

## Use Cases

### When to Use Claude Code

- Need flexible plugin ecosystem
- Want custom skills for domain-specific tasks
- Prefer JSON-based configuration
- Building complex workflows manually
- Rapid experimentation with different plugins

### When to Use Cursor

- Want built-in AI features (no plugins)
- Prefer rules-based declarative configuration
- Need fast iteration in editor
- Want custom commands for repetitive tasks
- Working with smaller teams

### When to Use Antigravity

- Need workflow automation
- Want to automate git operations
- Need scheduled tasks
- Building CI/CD-like pipelines
- Automating routine development tasks

## Integration Strategy

### For Individual Use

Choose one tool based on workflow:

- **Claude** for experimentation and flexible development
- **Cursor** for fast editing with integrated AI
- **Antigravity** for automation and workflows

### For Team Projects

Use all three:

1. **Claude** for exploratory coding
2. **Cursor** for primary editing
3. **Antigravity** for automation and CI/CD

Configure consistent rules across all three to maintain team standards.

### Rule Consistency

All three tools use shared rules:

- `shared/rules/markdown-linting.md` → `.md` (Claude)
- `shared/rules/markdown-linting.mdc` → `.mdc` (Cursor)
- `shared/rules/markdown-linting.md` → `.md` (Antigravity)

Update one format, adapt to others for consistency.

## Configuration Priority

When using multiple tools, apply rules in this order:

1. **Shared rules** - Common standards
2. **Tool-specific rules** - Tool-optimized versions
3. **Project overrides** - Project-specific customizations

## Strengths

### Claude Code Strengths

✅ Extensive plugin ecosystem
✅ Flexible per-project configuration
✅ Custom skills support
✅ Rich plugin marketplace

### Cursor Strengths

✅ Built-in without setup
✅ Fast iteration
✅ Native editor integration
✅ Low cognitive overhead

### Antigravity Strengths

✅ Powerful automation
✅ Workflow composability
✅ Scheduled execution
✅ Complex task orchestration

## Weaknesses

### Claude Code Weaknesses

⚠️ More configuration needed
⚠️ Plugin management overhead
⚠️ Requires IDE plugin installation

### Cursor Weaknesses

⚠️ Less customizable
⚠️ Fewer automation options
⚠️ Limited extensibility

### Antigravity Weaknesses

⚠️ Steeper learning curve
⚠️ Requires workflow design
⚠️ Not ideal for real-time coding  

## Quick Decision Tree

```text
Need automated workflows?
  YES → Use Antigravity
  NO → Continue

Need flexible plugins?
  YES → Use Claude
  NO → Use Cursor

Prefer editor integration?
  YES → Use Cursor
  NO → Use Claude
```

## Migration Between Tools

### Claude → Cursor

- Rewrite `config.json` as `.cursor/rules/*.mdc`
- Convert plugin logic to Cursor rules
- Create custom commands for workflows

### Cursor → Claude

- Create `.claude/config.json` with plugins
- Convert Cursor rules to Claude instructions
- Build skills if needed

### → Antigravity

- Convert rules to `.agent/rules/`
- Create `.agent/workflows/` for automation
- Define triggers and conditions

## Future-Proofing

To avoid lock-in:

1. Keep rules in shared formats (`.md` files)
2. Duplicate rules in tool-specific formats
3. Document migration paths
4. Test with multiple tools
5. Version control all configurations

## Recommendations

### Solo Development

Start with **Cursor** (built-in, fast)
→ Add **Claude** for experimentation
→ Add **Antigravity** when needed

### Team Development

Start with **shared rules** in `shared/rules/`
→ Implement in **Claude** first
→ Adapt to **Cursor** for consistency
→ Add **Antigravity** workflows for CI/CD

### Large Projects

Use all three:

- **Claude** for coding assistance
- **Cursor** for primary editor
- **Antigravity** for automation

Maintain consistency through shared rules.
