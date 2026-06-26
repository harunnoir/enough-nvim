# enough-nvim — Agent Guide

## Config Philosophy
- Flat plugin files under `lua/plugins/` — no nested subdirectories
- Each file covers one concern (editor, nav, lsp, git, ui, misc, lang)
- Minimal keybindings: deliberate, composable, no redundancy
- Native LSP config, no `nvim-lspconfig` — uses `vim.lsp.enable()` (Neovim 0.11+)

## Key Conventions
- `lua/config/maps.lua`: all core keymaps using `vim.keymap.set` aliased as `map`
- Picker (snacks.picker): 11 bindings (`ff`, `fg`, `fb`, `fh`, `f.`, `fl`, `fs`, `fS`, `fw`, `fk`, `fr`)
- Flash: `gs`/`gS` not `f`/`s` (avoids conflict with built-in `f` and mini.surround `s`)
- Smart-splits for `<C-h/j/k/l>` window nav (not tmux-navigator)
- mini.surround uses default `s` prefix (`sa`, `sd`, `sr`)
- Formatting: `stylua` for Lua (4-space indent, single quotes)
- Highlight tweaks centralized in `lua/config/hl.lua` for easy bulk disable

## Plugin Categories
- `core.lua`: lazy.nvim, ufo
- `lsp.lua`: mason, lspsaga, tiny-inline-diagnostic, nvim-lint, fidget
- `editor.lua`: blink.cmp, conform, mini.align/surround/ai, autopairs, grug-far, trouble, dial
- `nav.lua`: spider, maximizer, flash, glance, oil, harpoon, marks, satellite
- `git.lua`: gitsigns, gitgraph, fugit2
- `dap.lua`: nvim-dap, dap-ui, dap-python, dap-go
- `ui.lua`: gruvbox-material, lualine, snacks, noice, dashboard, toggleterm, which-key, yanky
- `misc.lua`: 99, haunt, hardtime, mini.hipatterns, render-markdown, undotree, persistence, nerdy
- `lang.lua`: language-specific plugins

## Testing / Validation
```bash
nvim --headless -c 'lua print("OK")' -c 'qa!'
```

## Bootstrap
- `bin/install.sh` — user-level, no sudo. Installs plugins + Mason packages (LSPs, formatters, linters).
- Prereqs: neovim, git, gcc, ripgrep, fd (must be on system).
- `bin/lang/python.sh` — extra Python tools Mason can't handle (pynvim, pytest, uv).
- Mason replaces pipx/npm for LSPs, formatters, and linters.
