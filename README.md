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
nvim --headless "+Lazy! sync" +qa     # Install plugins + Mason packages
```

For a full automated setup (prereqs + plugins + Mason + optional extras):

```bash
./bin/install.sh                       # Full install
./bin/install.sh --minimal             # Plugins only, skip Mason
./bin/lang/python.sh                   # Python extras (pynvim, pytest)
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
│       ├── lsp.lua           # mason, lspsaga, nvim-lint, fidget
│       ├── editor.lua        # blink.cmp, conform, mini.*, dial, trouble
│       ├── nav.lua           # flash, harpoon, oil, glance
│       ├── git.lua           # gitsigns, gitgraph, fugit2
│       ├── dap.lua           # nvim-dap, dap-ui, python/go debugger
│       ├── ai.lua            # 99 AI chat prompts
│       ├── ui.lua            # gruvbox-material, lualine, noice, snacks, which-key
│       ├── misc.lua          # haunt, undotree, nerdy, render-markdown
│       └── lang.lua          # Language-specific plugins
```

## Keybindings

### Core / Window Management

| Key | Mode | Action |
|-----|------|--------|
| `<leader>w` | n | Save |
| `<leader>q` | n | Quit |
| `<leader>Q` | n | Quit all |
| `<leader>cf` | n,v | Format buffer |
| `<leader>sv` | n | Vertical split |
| `<leader>sh` | n | Horizontal split |
| `<leader>sx` | n | Close split |
| `<leader>se` | n | Equalize splits |
| `<C-h/j/k/l>` | n | Move to split |
| `<A-h/j/k/l>` | n | Resize split |
| `<leader><leader>h/j/k/l>` | n | Swap buffer with split |
| `<C-m>` | n | Toggle maximize |

### Search / Navigation

| Key | Mode | Action |
|-----|------|--------|
| `gs` | n,x,o | Flash jump |
| `gS` | n,x,o | Flash treesitter |
| `w`/`e`/`b`/`ge` | n,o,x | Spider word motions |
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep |
| `<leader>fw` | n | Grep word |
| `<leader>fb` | n | Buffers |
| `<leader>f.` | n | Recent files |
| `<leader>fh` | n | Help tags |
| `<leader>fk` | n | Keymaps |
| `<leader>fl` | n | Buffer lines |
| `<leader>fs` | n | LSP symbols |
| `<leader>fS` | n | Workspace symbols |
| `<leader>fr` | n | Resume picker |
| `<leader>a` | n | Harpoon add file |
| `<leader>e` | n | Harpoon menu |
| `<leader>1-4` | n | Harpoon jump 1-4 |
| `-` | n | Oil file explorer |

### LSP / Code

| Key | Mode | Action |
|-----|------|--------|
| `K` | n | Hover documentation |
| `gD`/`gR`/`gY`/`gM` | n | Glance defs/refs/type/impl |
| `<leader>ca` | n,v | Code actions |
| `<leader>cr` | n | Rename symbol |
| `[d` / `]d` | n | Prev/next diagnostic |
| `<leader>xx` | n | Trouble diagnostics (all) |
| `<leader>xX` | n | Trouble diagnostics (buffer) |
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
| `<leader>dB` | Conditional breakpoint |
| `<leader>dpr` | Run to cursor |
| `<leader>dti` | DAP test method (Python) |
| `<leader>dtc` | DAP test class (Python) |

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

### Misc

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal |
| `<leader>p` | Yank history |
| `<leader>u` | Toggle undo tree |
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

## Docs

See [docs/](docs/README.md) for in-depth documentation:

- [Plugin rationale](docs/plugins.md) — why each plugin is here
- [LSP setup](docs/lsp.md) — native `vim.lsp.enable()` approach
- [Workflows](docs/workflows.md) — day-to-day editing loops
- [Adding a language](docs/languages.md) — step-by-step guide

## Credits

Built with [lazy.nvim](https://github.com/folke/lazy.nvim). Unix philosophy-inspired.
