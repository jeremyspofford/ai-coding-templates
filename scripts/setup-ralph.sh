#!/bin/bash
# setup-ralph.sh - Install frankbria/ralph-claude-code CLI
#
# This script installs the Ralph CLI for autonomous AI development loops.
# See docs/RALPH_LOOP.md for usage documentation.

set -e

RALPH_REPO="https://github.com/frankbria/ralph-claude-code.git"
INSTALL_DIR="/tmp/ralph-claude-code"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if ralph is already installed
if command -v ralph &> /dev/null; then
    echo_info "Ralph CLI is already installed."
    ralph --help | head -5
    echo ""
    echo_info "To reinstall, run: rm \$(which ralph) && ./setup-ralph.sh"
    exit 0
fi

# Check dependencies
echo_info "Checking dependencies..."

if ! command -v git &> /dev/null; then
    echo_error "git is required but not installed."
    exit 1
fi

if ! command -v bash &> /dev/null; then
    echo_error "bash is required but not installed."
    exit 1
fi

# Check bash version (need 4.0+)
BASH_VERSION_MAJOR="${BASH_VERSION%%.*}"
if [[ "$BASH_VERSION_MAJOR" -lt 4 ]]; then
    echo_warn "Bash 4.0+ recommended. Current version: $BASH_VERSION"
    echo_warn "Some features may not work correctly."
fi

# Check for Claude Code CLI
if ! command -v claude &> /dev/null; then
    echo_warn "Claude Code CLI not found. Install it with:"
    echo "  npm install -g @anthropic-ai/claude-code"
    echo ""
    echo_warn "Continuing with Ralph installation anyway..."
fi

# Clone repository
echo_info "Cloning ralph-claude-code repository..."
if [[ -d "$INSTALL_DIR" ]]; then
    echo_info "Removing existing installation directory..."
    rm -rf "$INSTALL_DIR"
fi

git clone --depth 1 "$RALPH_REPO" "$INSTALL_DIR"

# Run installer
echo_info "Running Ralph installer..."
cd "$INSTALL_DIR"

if [[ -f "install.sh" ]]; then
    chmod +x install.sh
    ./install.sh
else
    echo_error "install.sh not found in repository"
    exit 1
fi

# Verify installation
echo ""
if command -v ralph &> /dev/null; then
    echo_info "Ralph CLI installed successfully!"
    echo ""
    echo "Available commands:"
    echo "  ralph          - Run the autonomous development loop"
    echo "  ralph-setup    - Create a new Ralph project"
    echo "  ralph-import   - Import a PRD into a Ralph project"
    echo "  ralph-monitor  - Launch the monitoring dashboard"
    echo ""
    echo "Quick start:"
    echo "  ralph-setup my-feature"
    echo "  cd my-feature"
    echo "  # Edit PROMPT.md with your requirements"
    echo "  ralph --monitor"
    echo ""
    echo "See docs/RALPH_LOOP.md for full documentation."
else
    echo_error "Installation may have failed. Check the output above for errors."
    exit 1
fi

# Cleanup
echo_info "Cleaning up..."
rm -rf "$INSTALL_DIR"

echo_info "Done!"
