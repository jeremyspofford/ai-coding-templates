#!/bin/bash

###############################################################################
# setup-git-hooks.sh - Configure git pre-commit hooks for project standards
#
# Usage:
#   ./scripts/setup-git-hooks.sh
#   ./scripts/setup-git-hooks.sh --skip-markdown
#
# This script sets up pre-commit hooks to enforce:
# - Markdown linting (MD040, MD060)
# - TypeScript/JavaScript linting
# - Code quality checks
#
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Defaults
SKIP_MARKDOWN=0
HOOKS_DIR=".git/hooks"

print_header() {
  echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
  echo -e "${BLUE}$1${NC}"
  echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
}

print_success() {
  echo -e "${GREEN}✓${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1"
}

print_info() {
  echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}⚠${NC} $1"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --skip-markdown)
      SKIP_MARKDOWN=1
      shift
      ;;
    *)
      print_error "Unknown option: $1"
      exit 1
      ;;
  esac
done

print_header "Setting Up Git Pre-Commit Hooks"

# Check if .git directory exists
if [[ ! -d ".git" ]]; then
  print_error "Not a git repository. Run 'git init' first."
  exit 1
fi

# Create hooks directory if it doesn't exist
mkdir -p "$HOOKS_DIR"

###############################################################################
# Pre-commit hook for markdown linting
###############################################################################

PRE_COMMIT_HOOK="$HOOKS_DIR/pre-commit"

create_pre_commit_hook() {
  cat > "$PRE_COMMIT_HOOK" << 'HOOK_EOF'
#!/bin/bash

# Pre-commit hook: Enforce project standards
# Checks: Markdown linting (MD040, MD060), TypeScript/JavaScript

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_error() {
  echo -e "${RED}✗${NC} $1"
}

print_success() {
  echo -e "${GREEN}✓${NC} $1"
}

print_info() {
  echo -e "${BLUE}ℹ${NC} $1"
}

# Get list of staged files
STAGED_FILES=$(git diff --cached --name-only)

# Markdown files to check
MARKDOWN_FILES=$(echo "$STAGED_FILES" | grep -E '\.(md|mdc)$' || true)

# Check if markdownlint is available
MARKDOWNLINT_AVAILABLE=0
if command -v markdownlint &> /dev/null; then
  MARKDOWNLINT_AVAILABLE=1
elif npm list -g markdownlint-cli &> /dev/null 2>&1; then
  MARKDOWNLINT_AVAILABLE=1
fi

###############################################################################
# Markdown Linting
###############################################################################

if [[ -n "$MARKDOWN_FILES" ]]; then
  print_info "Checking markdown files..."

  if [[ $MARKDOWNLINT_AVAILABLE -eq 1 ]]; then
    # Run markdownlint
    if markdownlint -c .markdownlint.json $MARKDOWN_FILES 2>&1; then
      print_success "Markdown linting passed"
    else
      print_error "Markdown linting failed. Fix issues and try again."
      echo ""
      echo "Common fixes:"
      echo "  • Add language tags to code blocks: \`\`\`javascript"
      echo "  • Add spaces in table separators: | ----- | ----- |"
      echo "  • Run: markdownlint --fix <file>"
      exit 1
    fi
  else
    # Fallback: Basic checks without markdownlint
    print_info "markdownlint not installed. Running basic checks..."

    HAS_ERRORS=0

    for file in $MARKDOWN_FILES; do
      # Check for MD040 - Missing language tag in code blocks
      # Note: Regex check is limited - install markdownlint for accurate detection
      # Look for code blocks that might be missing language tags
      if grep -q '^```' "$file"; then
        # File has code blocks - check if any are missing language tags
        # Simple heuristic: if file has any ``` followed by code, it might lack tags
        if ! grep -E '^```[a-z]' "$file" > /dev/null 2>&1; then
          print_info "$file: Has code blocks. Install markdownlint to verify language tags (MD040)"
        fi
      fi

      # Check for MD060 - Table formatting issues
      if grep -q '^|' "$file"; then
        # Check if table separator has proper spacing
        if grep -E '^\|[\s]*-+' "$file" | grep -v '^\| *-' > /dev/null; then
          print_error "$file: Table formatting may have spacing issues (MD060)"
          print_info "Ensure table separators use: | ------- | ------- |"
          HAS_ERRORS=1
        fi
      fi
    done

    if [[ $HAS_ERRORS -eq 1 ]]; then
      echo ""
      echo "Install markdownlint for detailed checking:"
      echo "  npm install -g markdownlint-cli"
      exit 1
    fi

    print_success "Basic markdown checks passed"
  fi
fi

###############################################################################
# TypeScript/JavaScript Linting (optional)
###############################################################################

# Check for linting scripts in package.json
if [[ -f "package.json" ]]; then
  JS_FILES=$(echo "$STAGED_FILES" | grep -E '\.(js|ts|jsx|tsx)$' || true)

  if [[ -n "$JS_FILES" ]]; then
    print_info "Found TypeScript/JavaScript files"

    if grep -q '"lint"' package.json; then
      print_info "Running npm lint..."
      if npm run lint 2>&1 | head -20; then
        print_success "Linting passed"
      else
        print_error "Linting failed. Fix issues and try again."
        exit 1
      fi
    fi
  fi
fi

print_success "Pre-commit checks passed"
exit 0
HOOK_EOF

  chmod +x "$PRE_COMMIT_HOOK"
}

###############################################################################
# Create prepare-commit-msg hook (optional, for commit messages)
###############################################################################

create_prepare_commit_msg_hook() {
  PREPARE_HOOK="$HOOKS_DIR/prepare-commit-msg"

  cat > "$PREPARE_HOOK" << 'HOOK_EOF'
#!/bin/bash

# Prepare commit message hook
# Reminds user about commit message standards

COMMIT_MSG_FILE=$1
COMMIT_SOURCE=$2

# Only show message for normal commits (not merge, squash, etc.)
if [[ "$COMMIT_SOURCE" != "" ]]; then
  exit 0
fi

# Check if commit message exists and is not empty
if [[ ! -s "$COMMIT_MSG_FILE" ]]; then
  exit 0
fi

# Could add auto-formatting or reminders here
exit 0
HOOK_EOF

  chmod +x "$PREPARE_HOOK"
}

###############################################################################
# Create .markdownlint.json configuration
###############################################################################

create_markdownlint_config() {
  if [[ ! -f ".markdownlint.json" ]]; then
    cat > ".markdownlint.json" << 'CONFIG_EOF'
{
  "extends": "markdownlint/style/prettier",
  "MD040": {
    "allowed_languages": [
      "bash",
      "sh",
      "javascript",
      "js",
      "typescript",
      "ts",
      "json",
      "yaml",
      "yml",
      "markdown",
      "md",
      "python",
      "py",
      "sql",
      "html",
      "css",
      "dockerfile",
      "diff",
      "go",
      "rust",
      "java",
      "c",
      "cpp",
      "csharp",
      "ruby",
      "php",
      "swift",
      "kotlin"
    ]
  },
  "MD013": false,
  "MD033": false
}
CONFIG_EOF
    print_success "Created .markdownlint.json configuration"
  else
    print_info ".markdownlint.json already exists"
  fi
}

###############################################################################
# Main execution
###############################################################################

# Create pre-commit hook
if [[ $SKIP_MARKDOWN -eq 0 ]]; then
  print_info "Creating pre-commit hook..."
  create_pre_commit_hook
  print_success "Pre-commit hook installed"

  # Create markdownlint configuration
  print_info "Creating markdownlint configuration..."
  create_markdownlint_config
else
  print_warning "Skipping markdown-related hooks"
fi

# Create prepare-commit-msg hook
print_info "Creating prepare-commit-msg hook..."
create_prepare_commit_msg_hook
print_success "Prepare-commit-msg hook installed"

echo ""
print_header "Git Hooks Setup Complete"

echo ""
echo "Installed hooks:"
if [[ $SKIP_MARKDOWN -eq 0 ]]; then
  echo "  ✓ pre-commit hook (markdown + linting checks)"
fi
echo "  ✓ prepare-commit-msg hook"
echo ""

echo "To test:"
echo "  1. Make a change to a markdown file"
echo "  2. Stage it with: git add <file>.md"
echo "  3. Try to commit: git commit -m 'test'"
echo "  4. Pre-commit checks will run automatically"
echo ""

echo "To install markdownlint for detailed checking:"
echo "  npm install -g markdownlint-cli"
echo ""

echo "To bypass hooks (not recommended):"
echo "  git commit --no-verify"
echo ""

print_success "Setup complete. Hooks are now active."
