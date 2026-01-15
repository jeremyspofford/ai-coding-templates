# Git Hooks Setup & Configuration

Enforce project standards automatically with git pre-commit hooks.

---

## Overview

This template includes git hooks that automatically enforce:

- **Markdown Linting** (MD040, MD060) - Language tags, table formatting
- **Code Linting** - TypeScript/JavaScript standards (if configured)
- **Commit Message Standards** - (optional, extensible)

The hooks run before each commit, catching issues early without manual checks.

---

## Quick Start

### 1. Create a New Project

```bash
./scripts/setup-project.sh --name my-project --tools claude --git
cd my-project
```

The `--git` flag initializes git, but hooks aren't set up yet.

### 2. Setup Git Hooks

```bash
./scripts/setup-git-hooks.sh
```

This creates:

- `.git/hooks/pre-commit` - Runs linting checks
- `.git/hooks/prepare-commit-msg` - (Optional) Message preparation
- `.markdownlint.json` - Linting configuration

### 3. Test the Hooks

Create or modify a markdown file:

```bash
echo "# Test

\`\`\`
code without language tag
\`\`\`
" > test.md

git add test.md
git commit -m "Test markdown"
```

**Result**: Commit will be rejected with MD040 error (missing language tag).

### 4. Fix and Retry

Fix the markdown:

```bash
echo "# Test

\`\`\`javascript
const x = 1;
\`\`\`
" > test.md

git add test.md
git commit -m "Fix markdown"
```

**Result**: Commit succeeds!

---

## What Gets Checked

### MD040 - Fenced Code Language

**What it checks**:

- Every code block must have a language tag
- `\`\`\`javascript` ✅ (good)
- `\`\`\`` ❌ (fails)

**Common tags**:

| Language | Tags |
| -------- | ---- |
| Shell scripts | `bash`, `sh` |
| JavaScript | `javascript`, `js` |
| TypeScript | `typescript`, `ts` |
| Python | `python`, `py` |
| JSON | `json` |
| YAML | `yaml`, `yml` |
| SQL | `sql` |
| Web | `html`, `css` |
| Markdown | `markdown`, `md` |
| Default (unsure) | `markdown` |

### MD060 - Table Formatting

**What it checks**:

- Table separators need proper spacing
- `| ------- | ------- |` ✅ (good)
- `|--------|--------|` ❌ (fails)

### Code Linting (Optional)

If your project has a `package.json` with a `lint` script:

- TypeScript/JavaScript files are checked
- Must pass linting before commit

---

## Installation & Requirements

### Basic Setup (No markdownlint)

The pre-commit hook works with basic regex checks, no dependencies needed.

**Pros**:

- No installation required
- Works on any machine
- Fast
- Informational warnings for potential issues

**Cons**:

- Regex checks are limited
- May not catch all issues
- Informational only (won't block commits)

**Recommendation**:
Install markdownlint for production-quality enforcement. Basic checks work well
for development.

### With markdownlint (Recommended)

For detailed markdown checking, install markdownlint:

```bash
# Option 1: Global installation
npm install -g markdownlint-cli

# Option 2: Project installation
npm install --save-dev markdownlint-cli

# Option 3: Homebrew (macOS)
brew install markdownlint-cli
```

**After installation**:

```bash
# Verify it works
markdownlint --version

# Test on a file
markdownlint test.md

# Fix issues automatically
markdownlint --fix test.md
```

---

## Configuration Files

### `.markdownlint.json`

Created automatically by `setup-git-hooks.sh`. Configures markdown linting rules:

```json
{
  "extends": "markdownlint/style/prettier",
  "MD040": {
    "allowed_languages": [
      "bash", "javascript", "typescript", "json", "yaml",
      "markdown", "python", "sql", "html", "css", "dockerfile",
      "diff", "go", "rust", "java", "c", "cpp", "csharp",
      "ruby", "php", "swift", "kotlin"
    ]
  },
  "MD013": false,
  "MD033": false
}
```

**Key settings**:

- `MD040`: List of allowed language tags
- `MD013`: Disabled (line length)
- `MD033`: Disabled (inline HTML)

### `.git/hooks/pre-commit`

Bash script that runs before each commit. You can:

- Edit directly to customize checks
- Add new linting rules
- Add project-specific validation

---

## Common Tasks

### Bypass Hooks (Emergency Only)

```bash
# Skip all hooks
git commit --no-verify

# Or use -n flag
git commit -n -m "Emergency fix"
```

⚠️ Use sparingly - defeats the purpose of enforcement!

### Fix Markdown Automatically

```bash
# Fix all markdown files
markdownlint --fix *.md
markdownlint --fix **/*.md

# Fix specific file
markdownlint --fix docs/README.md
```

**What gets fixed automatically**:

- Missing language tags → adds `markdown` default
- Table spacing → normalizes format
- Line endings → standardizes
- Indentation → fixes lists

### Temporarily Disable Rule

In markdown file, use comments:

```markdown
<!-- markdownlint-disable MD040 -->
```

code without language tag

```
<!-- markdownlint-enable MD040 -->
```

### Add Custom Validation

Edit `.git/hooks/pre-commit` to add checks:

```bash
# Example: Check for console.log in production code
if git diff --cached | grep -q "console\.log"; then
  print_error "Debug console.log detected"
  exit 1
fi
```

---

## Troubleshooting

### Hooks Not Running

**Check if hooks are executable**:

```bash
ls -la .git/hooks/
# Should show: -rwxr-xr-x (with x permission)
```

**Make them executable**:

```bash
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/prepare-commit-msg
```

### "markdownlint not found"

Install markdownlint:

```bash
npm install -g markdownlint-cli
```

Or run hooks without it:

```bash
./scripts/setup-git-hooks.sh
# Hooks will use fallback basic checks
```

### False Positive Errors

**Check configuration**:

```bash
# View current config
cat .markdownlint.json

# Run with verbose output
markdownlint -v file.md
```

**Update rules in `.markdownlint.json`** if needed.

### Hook Blocks Valid Commit

**Check the error message** - it should explain what's wrong.

**Quick fixes**:

```bash
# For markdown issues
markdownlint --fix *.md

# For code issues
npm run lint -- --fix

# Then retry
git add .
git commit -m "Fix linting issues"
```

---

## Advanced Configuration

### Customize Pre-Commit Hook

Edit `.git/hooks/pre-commit` to add more checks:

```bash
# Check for large files
for file in $STAGED_FILES; do
  size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
  if [[ $size -gt 5242880 ]]; then  # 5MB
    print_error "$file is too large ($(($size/1024/1024))MB)"
    exit 1
  fi
done

# Check for secrets
if grep -r "api_key\|password\|secret" $STAGED_FILES; then
  print_error "Secrets detected in code"
  exit 1
fi
```

### Add More Hooks

Create additional hooks in `.git/hooks/`:

```bash
# Commit message validation
touch .git/hooks/commit-msg
chmod +x .git/hooks/commit-msg

# Post-commit actions
touch .git/hooks/post-commit
chmod +x .git/hooks/post-commit

# Push validation
touch .git/hooks/pre-push
chmod +x .git/hooks/pre-push
```

### Project-Specific Configuration

Different teams may want different rules:

```bash
# For strict enforcement (production)
./scripts/setup-git-hooks.sh

# For relaxed rules (development)
./scripts/setup-git-hooks.sh --skip-markdown
```

---

## CI/CD Integration

### GitHub Actions

Check markdown in CI pipeline:

```yaml
name: Markdown Lint

on: [push, pull_request]

jobs:
  markdown-lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: nosborn/github-action-markdown-cli@v3.3.0
        with:
          files: .
          config_file: .markdownlint.json
```

### GitLab CI

```yaml
markdown-lint:
  image: node:18
  script:
    - npm install -g markdownlint-cli
    - markdownlint -c .markdownlint.json **/*.md
  only:
    - merge_requests
```

### Pre-Push Hook

Add to `.git/hooks/pre-push`:

```bash
#!/bin/bash

# Prevent pushing if hooks would fail
if ! ./scripts/validate-all.sh; then
  echo "Push blocked by validation hooks"
  exit 1
fi
```

---

## Best Practices

### 1. Install Early

Run setup immediately after creating a project:

```bash
./scripts/setup-project.sh --name project --tools claude --git
cd project
./scripts/setup-git-hooks.sh
```

### 2. Commit Hook Files

Add hook configuration to version control:

```bash
git add .markdownlint.json
git commit -m "Add linting configuration"
```

### 3. Document Exceptions

If you disable rules, document why:

```markdown
<!-- markdownlint-disable MD033 -->
<!-- Reason: Inline HTML needed for custom styling -->
<div class="custom">Content</div>
<!-- markdownlint-enable MD033 -->
```

### 4. Team Consistency

Ensure all team members have the same configuration:

```bash
# In project README
./scripts/setup-git-hooks.sh
```

### 5. Regular Updates

Update linting rules as project evolves:

```bash
# After updating .markdownlint.json
./scripts/setup-git-hooks.sh
```

---

## Workflow Example

**Scenario**: Developer modifies project documentation

```bash
# 1. Make changes
echo "# New Feature" > docs/feature.md
echo "## Installation
\`\`\`
npm install
\`\`\`" >> docs/feature.md

# 2. Stage changes
git add docs/feature.md

# 3. Attempt commit
git commit -m "Add feature documentation"

# 4. Hook runs automatically
# Output: "✗ Code blocks without language tags detected (MD040)"
# Commit blocked!

# 5. Fix issues
markdownlint --fix docs/feature.md
# Auto-fixes to: \`\`\`bash

# 6. Re-stage and commit
git add docs/feature.md
git commit -m "Add feature documentation"

# 7. Success!
# Output: "✓ Markdown linting passed"
# Output: "[main 1234567] Add feature documentation"
```

---

## Related Documentation

- [Markdown Linting Rule](./../.claude/rules/markdown-linting.md)
- [Markdown Linter Skill](./../.claude/skills/markdown-linter/README.md)
- [Project Setup Guide](./SETUP_GUIDE.md)

---

## Support

For issues with git hooks:

1. Check if hooks are executable: `ls -la .git/hooks/`
2. Run setup script again: `./scripts/setup-git-hooks.sh`
3. Check for syntax errors: `bash -n .git/hooks/pre-commit`
4. Test hook directly: `./.git/hooks/pre-commit`

For markdownlint issues:

1. Check version: `markdownlint --version`
2. Check config: `cat .markdownlint.json`
3. Run verbose: `markdownlint -v file.md`
4. Test file: `markdownlint file.md`

---

**Last Updated**: 2026-01-15
