# enough-nvim — Agent Guide

## Config Philosophy
- Flat plugin files under `lua/plugins/` — no nested subdirectories
- Each file covers one concern
- Minimal keybindings: deliberate, composable, no redundancy
- Native LSP config, no `nvim-lspconfig` — uses `vim.lsp.enable()` (Neovim 0.11+)

## Key Conventions
- `lua/config/keymaps.lua`: global keymaps using `vim.keymap.set` aliased as `map`
- Plugin-owned mappings belong in their plugin specs when practical
- Picker (snacks.picker): 9 bindings (`ff`, `fg`, `fw`, `fr`, `f.`, `fh`, `fk`, `fl`, `fp`)
- Flash: `gs`/`gS` not `f`/`s` (avoids conflict with built-in `f` and mini.surround `s`)
- Smart-splits for `<C-h/j/k/l>` window nav (not tmux-navigator)
- mini.surround uses default `s` prefix (`sa`, `sd`, `sr`)
- Formatting: `stylua` for Lua (4-space indent, single quotes)
- Colors and plugin highlights come from the active colorscheme

## Plugin Categories
- `core.lua`: treesitter, ufo
- `ts.lua`: treesitter textobjects
- `mini.lua`: mini.ai, align, surround, clue, hipatterns, starter
- `lsp.lua`: mason, tiny-inline-diagnostic, nvim-lint, fidget, symbol-usage
- `completion.lua`: blink.cmp and completion sources
- `editor.lua`: conform, autopairs, grug-far, trouble, treesj, dial
- `nav.lua`: spider, maximizer, flash, glance, oil, harpoon, marks, smart-splits
- `git.lua`: gitsigns, gitgraph
- `dap.lua`: nvim-dap, dap-ui, dap-python, dap-go
- `themes.lua`: colorscheme selection and setup
- `ui.lua`: slimline, snacks, noice, yanky, virt-column
- `terminal.lua`: Snacks terminal behavior and mappings
- `misc.lua`: overseer, haunt, hardtime, undotree, nerdy, persistence
- `ai.lua`: 99 AI chat
- `lang.lua`: render-markdown, uv.nvim
- `42.lua`: c_formatter_42 (conform), 42-header.nvim

## Testing / Validation
```bash
make check
make test
```

## Bootstrap
- `bin/install.sh` — user-level, no sudo. Installs plugins + Mason packages (LSPs, formatters, linters).
- Prereqs: neovim, git, gcc, ripgrep, fd (must be on system).
- `bin/lang/python.sh` — extra Python tools Mason can't handle (pynvim, pytest, uv).
- Mason replaces pipx/npm for LSPs, formatters, and linters.
