# n8n-project Template

Use this template for n8n workflow automation projects.

## What's Included

### Plugins (7 n8n-specific)
- `n8n-node-configuration` - Node configuration guidance
- `n8n-code-javascript` - JavaScript code node support
- `n8n-code-python` - Python code node support
- `n8n-expression-syntax` - n8n expression validation and fixing
- `n8n-validation-expert` - Validation error interpretation
- `n8n-workflow-patterns` - Proven workflow architectures
- `n8n-mcp-tools-expert` - MCP tool usage guidance

### MCP Server
- **n8n-mcp** - n8n workflow management API

### Plus (inherited from global)
- `github@claude-plugins-official`
- `code-review@claude-plugins-official`
- `commit-commands@claude-plugins-official`
- `typescript-lsp@claude-plugins-official`
- `explanatory-output-style@claude-plugins-official`
- `learning-output-style@claude-plugins-official`
- `hookify@claude-plugins-official`

## Setup

1. Copy to your n8n project:
```bash
cp -r ~/workspace/claude-config-templates/n8n-project/.claude YOUR_PROJECT/
cp ~/workspace/claude-config-templates/n8n-project/.mcp.json YOUR_PROJECT/
```

2. Update `.mcp.json` with your actual n8n API key:
```json
"N8N_API_KEY": "your-actual-api-key-here"
```

3. Ensure your project has `CLAUDE.md` with n8n instructions

4. Restart Claude Code

## Features

- ✅ Full n8n workflow building support
- ✅ Node configuration helpers
- ✅ Expression validation and fixing
- ✅ Workflow pattern templates
- ✅ JavaScript/Python code node support
- ✅ Validation error interpretation
- ❌ AWS tools (not needed for n8n)
- ❌ Web testing tools (not needed for n8n)

## Documentation

See the main [README.md](../README.md) for general template usage.

For n8n-specific features, check your project's `CLAUDE.md` file which should include:
- Workflow building process
- Available MCP tools
- Node discovery patterns
- Validation strategies
- Best practices
