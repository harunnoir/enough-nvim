<pre align="center">
<a href="#">
  <img src="https://github.com/user-attachments/assets/850fced3-7841-482b-8381-ca9097781b60" width="88%" />
</a>
</pre>

# enough-nvim

Neovim config that's just enough. No bloat, no framework — flat plugin files, native LSP, deliberate keybindings.

## Install

```bash
git clone git@github.com:harunnoir/enough-nvim.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

Or run the bootstrap script for a full system setup (Neovim + LSPs + formatters + deps):

```bash
./bin/install.sh          # Arch / Debian / Fedora / Void
```

## Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
├── lazy-lock.json            # Locked plugin versions
├── bin/install.sh            # Bootstrap installer
├── lua/
│   ├── config/
│   │   ├── opts.lua          # Editor options
│   │   ├── maps.lua          # Core keymaps
│   │   ├── lsp.lua           # LSP server config
│   │   ├── hl.lua            # Highlight overrides
│   │   ├── cmd.lua           # Autocommands / filetype settings
│   │   └── neovide.lua       # Neovide-specific config
│   └── plugins/
│       ├── init.lua          # Plugin import list
│       ├── core.lua          # lazy.nvim, ufo
│       ├── lsp.lua           # mason, lspsaga, nvim-lint, dap
│       ├── editor.lua        # blink.cmp, conform, mini.*, dial, trouble
│       ├── nav.lua           # flash, telescope, harpoon, oil, glance
│       ├── git.lua           # gitsigns, gitgraph, fugit2
│       ├── ui.lua            # gruvbox-material, lualine, noice, which-key
│       ├── misc.lua          # 99, haunt, undotree, nerdy, render-markdown
│       └── lang.lua          # Language-specific plugins
```

## Keybindings

### Core / Window Management

| Key | Mode | Action |
|-----|------|--------|
| `<C-s>` | n | Save |
| `<leader>q` | n | Quit |
| `<leader>f` | n,v | Format buffer |
| `<leader>sv` | n | Vertical split |
| `<leader>sh` | n | Horizontal split |
| `<leader>sx` | n | Close split |
| `<leader>se` | n | Equalize splits |
| `<C-h/j/k/l>` | n | Move to split |
| `<leader><leader>h/j/k/l>` | n | Swap buffer with split |
| `<M-,/.>` | n | Shrink/expand width |
| `<M,-/=>` | n | Shrink/expand height |
| `<C-m>` | n | Toggle maximize |

### Search / Navigation

| Key | Mode | Action |
|-----|------|--------|
| `gs` | n,x,o | Flash jump |
| `gS` | n,x,o | Flash treesitter |
| `w`/`e`/`b`/`ge` | n,o,x | Spider word motions |
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep |
| `<leader>fb` | n | Buffers |
| `<leader>fh` | n | Help tags |
| `<leader>fr` | n | Resume picker |
| `<leader>a` | n | Harpoon add file |
| `<leader>e` | n | Harpoon menu |
| `<leader>1-4` | n | Harpoon jump 1-4 |
| `-` | n | Oil file explorer |

### LSP / Code

| Key | Mode | Action |
|-----|------|--------|
| `K` | n | Hover documentation |
| `gd` | n | Go to definition |
| `gD`/`gR`/`gY`/`gM` | n | Glance defs/refs/type/impl |
| `<leader>ca` | n,v | Code actions |
| `[d` / `]d` | n | Prev/next diagnostic |
| `<leader>xx` | n | Trouble diagnostics |
| `<leader>xs` | n | Trouble symbols |
| `<leader>xl` | n | Trouble LSP refs |

### Debug (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Continue |
| `<F1>` | Step into |
| `<F2>` | Step over |
| `<F3>` | Step out |
| `<F6>` | Toggle DAP UI |
| `<leader>db` | Toggle breakpoint |

### Git

| Key | Action |
|-----|--------|
| `<leader>gl` | Git graph |
| `<leader>F` | Fugit2 |

### Editing

| Key | Mode | Action |
|-----|------|--------|
| `sa` + m + c | n | Add surround |
| `sd` + t | n | Delete surround |
| `sr` + t + c | n | Replace surround |
| `ga` / `gA` | n,x | Align / align preview |
| `<C-a>` / `<C-x>` | n | Increment / decrement |
| `gc` / `gcis` | n,v | Comment / uncomment |
| `<A-j/k>` | n,v | Move line down/up |
| `<Tab>` / `<S-Tab>` | v | Indent / outdent |

### Clipboard

| Key | Mode | Action |
|-----|------|--------|
| `<leader>y` | n,v | Yank to system clipboard |
| `<leader>Y` | n | Yank line to system |
| `<leader>p` | n,v | Paste from system |
| `<leader>P` | n,v | Paste before from system |

### Misc

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal |
| `<leader>u` | Toggle undo tree |
| `<leader>?` | Buffer local keymaps |
| `<leader>in` | Browse nerd icons |
| `<leader>ha` | Annotate (haunt) |
| `<leader>9v/s` | AI visual/search prompt |
| `<leader>st` | Create scratch file |
| `zR` / `zM` | Open / close all folds |
| `<BS>` | Alternate buffer |

## Colorscheme

[gruvbox-material](https://github.com/sainnhe/gruvbox-material) — soft background, dark mode.

## Plugins

Grouped into flat files under `lua/plugins/` — no nested subdirectories. Each file covers one concern: editor, navigation, LSP, git, UI, misc, and language-specific extras. See `lua/plugins/init.lua` for the import order.

## TODO

- [x] Organize modules
- [x] Bootstrap installer
- [x] Keybinding reference

## Credits

Heavily inspired by the Unix philosophy: do one thing well. Built with [lazy.nvim](https://github.com/folke/lazy.nvim).
