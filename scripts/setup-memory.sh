#!/bin/bash
# Install Beads if missing
if ! command -v bd &> /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash
fi
# Initialize memory if missing
if [ ! -d ".beads" ]; then
    bd init
fi
echo "Beads memory system ready."
