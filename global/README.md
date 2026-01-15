# Global Configuration Reference

This directory contains an example of the minimal global Claude Code configuration that should be kept in `~/.claude/settings.json`.

## Philosophy

**Global configuration should contain ONLY:**
- Universal permissions (Bash, Read, Write, Edit, MultiEdit, Find)
- Universal hooks (session hooks, validation, linting)
- Core plugins that ALL projects benefit from
- Output style preferences
- Model preferences

**Global configuration should NOT contain:**
- Project-specific plugins (n8n, AWS, etc.)
- Project-specific MCP servers
- Project-specific skills or instructions

## The 7 Universal Plugins

These 7 plugins are enabled globally across all projects:

1. **github@claude-plugins-official** - GitHub integration (universal dev tool)
2. **code-review@claude-plugins-official** - Code review helpers (useful everywhere)
3. **commit-commands@claude-plugins-official** - Git commit helpers (useful everywhere)
4. **typescript-lsp@claude-plugins-official** - TypeScript support (common language)
5. **explanatory-output-style@claude-plugins-official** - Output formatting
6. **learning-output-style@claude-plugins-official** - Output formatting
7. **hookify@claude-plugins-official** - Custom hooks system (infrastructure)

## What NOT to Add Globally

These should be project-specific (in `.claude/config.json`):

**Project-Specific Plugins:**
- AWS tools (aws-cdk, aws-cost-ops, aws-agentic-ai, serverless-eda)
- n8n plugins (n8n-node-configuration, n8n-code-javascript, etc.)
- Testing tools (playwright, pr-review-toolkit)
- LSP servers (pyright-lsp, lua-lsp)
- Documentation tools (context7, greptile)
- Frontend tools (frontend-design)
- Data tools (pinecone)
- Analysis tools (repomix-explorer, repomix-mcp)
- Feature development (feature-dev, code-simplifier, ralph-loop)

**Project-Specific MCP Servers:**
- n8n-mcp
- n8n-mcp-management
- Any other project-specific MCP servers

## How to Use This

1. Copy key sections of `settings.json` to `~/.claude/settings.json`
2. Keep the permissions and hooks as reference
3. Use the minimal `enabledPlugins` list as a starting point
4. Add only universal plugins to global config
5. Use project-specific `.claude/config.json` for all other plugins

## Notes

- Permissions shown here are examples - adjust to your security requirements
- Hooks shown here are examples - customize as needed
- The `model` field can be "haiku", "sonnet", or "opus"
- `alwaysThinkingEnabled` is optional (extends thinking time for complex tasks)

See the main [README.md](../README.md) for the complete configuration system.
