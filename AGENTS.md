# enough-nvim — Agent Guide

## Config Philosophy
- Flat plugin files under `lua/plugins/` — no nested subdirectories
- Each file covers one concern (editor, nav, lsp, git, ui, misc, lang)
- Minimal keybindings: deliberate, composable, no redundancy
- Native LSP config, no `nvim-lspconfig` — uses `vim.lsp.enable()` (Neovim 0.11+)

## Key Conventions
- `lua/config/maps.lua`: all core keymaps using `vim.keymap.set` aliased as `map`
- Telescope: only 5 bindings (`ff`, `fg`, `fb`, `fh`, `fr`)
- Flash: `gs`/`gS` not `f`/`s` (avoids conflict with built-in `f` and mini.surround `s`)
- Smart-splits for `<C-h/j/k/l>` window nav (not tmux-navigator)
- mini.surround uses default `s` prefix (`sa`, `sd`, `sr`)
- Formatting: `stylua` for Lua (4-space indent, single quotes)
- Highlight tweaks live inside individual plugin configs, NOT in `hl.lua`

## Plugin Categories
- `core.lua`: lazy.nvim, ufo
- `lsp.lua`: mason, lspsaga, tiny-inline-diagnostic, nvim-lint, fidget, dap
- `editor.lua`: blink.cmp, conform, mini.align/surround/ai, autopairs, grug-far, trouble, dial
- `nav.lua`: spider, maximizer, flash, telescope, glance, oil, harpoon, marks, satellite
- `git.lua`: gitsigns, gitgraph, fugit2
- `ui.lua`: gruvbox-material, lualine, snacks, noice, dashboard, toggleterm, which-key, yanky
- `misc.lua`: 99, haunt, hardtime, mini.hipatterns, render-markdown, undotree, persistence, nerdy
- `lang.lua`: language-specific plugins

## Testing / Validation
```bash
nvim --headless -c 'lua print("OK")' -c 'qa!'
```

## Bootstrap
- `bin/install.sh` for Arch/Debian/Fedora/Void
- Installs neovim, git, gcc, ripgrep, fd, LSPs, formatters, pynvim
