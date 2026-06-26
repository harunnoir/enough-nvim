# enough-nvim docs

## Contents

| File | What it covers |
|------|----------------|
| [plugins.md](plugins.md) | Why each plugin is here (and what was rejected) |
| [lsp.md](lsp.md) | LSP setup — native `vim.lsp.enable()` approach |
| [workflows.md](workflows.md) | Day-to-day editing, search, git, and refactor loops |
| [languages.md](languages.md) | Adding a new language — LSP, formatter, linter, treesitter |

## Principles

- **Flat is better than nested** — every plugin file lives directly in `lua/plugins/`
- **No frameworks** — no `nvim-lspconfig`, no `alpha-nvim`, no `telescope-ui-select`
- **Minimal keybindings** — every binding earns its place; no redundancy
- **Composability** — prefer actions that chain (e.g. Trouble from a snacks picker)
