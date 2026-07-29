# enough-nvim — Agent Guide

## Config Philosophy
- Flat plugin files under `lua/plugins/` — no nested subdirectories
- Each file covers one concern
- Minimal keybindings: deliberate, composable, no redundancy
- Native LSP config, no `nvim-lspconfig` — uses `vim.lsp.enable()` (Neovim 0.11+)

## Key Conventions
- `lua/config/maps.lua`: all core keymaps using `vim.keymap.set` aliased as `map`
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
- `editor.lua`: blink.cmp, conform, autopairs, grug-far, trouble, treesj, dial
- `nav.lua`: spider, maximizer, flash, glance, oil, harpoon, marks, smart-splits
- `git.lua`: gitsigns, gitgraph
- `dap.lua`: nvim-dap, dap-ui, dap-python, dap-go
- `ui.lua`: colorschemes, slimline, snacks, noice, yanky, virt-column
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
