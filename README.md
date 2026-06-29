<pre align="center">
<a href="#">
  <img width="1322" height="720" alt="output" src="https://github.com/user-attachments/assets/a1cb5b4b-8b43-4412-baee-02e09ba500b3" />
</a>
</pre>

# enough-nvim

Neovim config that's just enough. No bloat, no framework — flat plugin files, native LSP, deliberate keybindings.

## Install

```bash
git clone https://github.com/harunnoir/enough-nvim.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa     # plugins + Mason
```

For a full automated setup:

```bash
./bin/install.sh                       # prereqs, plugins, Mason
./bin/install.sh --minimal             # plugins only
./bin/lang/python.sh                   # pynvim, pytest, uv
```

## Structure

```
~/.config/nvim/
├── init.lua                  entry point
├── lazy-lock.json            locked plugin versions
├── bin/install.sh            bootstrap installer
├── lua/
│   ├── config/
│   │   ├── opts.lua          editor options
│   │   ├── maps.lua          core keymaps
│   │   ├── lsp.lua           LSP server config (vim.lsp.enable)
│   │   ├── hl.lua            highlight overrides
│   │   ├── cmd.lua           autocommands / filetype settings
│   │   └── neovide.lua       Neovide GUI config
│   └── plugins/              one file per concern
│       ├── core.lua          lazy.nvim, treesitter, ufo
│       ├── lsp.lua           mason, lspsaga, nvim-lint, fidget
│       ├── editor.lua        blink.cmp, conform, mini.*, trouble
│       ├── nav.lua           flash, harpoon, oil, glance
│       ├── git.lua           gitsigns, gitgraph, fugit2
│       ├── dap.lua           nvim-dap, dap-ui, python/go debugger
│       ├── ai.lua            99 AI chat
│       ├── ui.lua            slimline, gruvbox-material, snacks, toggleterm, noice
│       ├── misc.lua          haunt, undotree, nerdy, render-markdown
│       └── lang.lua          language-specific extras
```

## Keybindings

### Window & File

| Key | Mode | Action |
|-----|------|--------|
| `<leader>w` | n | Save |
| `<leader>q` / `<leader>Q` | n | Quit / Quit all |
| `<leader>cf` | n,v | Format buffer |
| `<C-h/j/k/l>` | n | Move to split |
| `<A-h/j/k/l>` | n | Resize split |
| `<leader><leader>h/j/k/l>` | n | Swap buffer with split |
| `<leader>sv/sh/sx/se` | n | Split vertical/horizontal/close/equalize |
| `<C-m>` | n | Toggle maximize |
| `<BS>` | n | Alternate buffer |

### Search & Navigate

| Key | Mode | Action |
|-----|------|--------|
| `gs` / `gS` | n,x,o | Flash jump / Flash treesitter |
| `w`/`e`/`b`/`ge` | n,o,x | Spider word motions |
| `<leader>ff` / `fg` / `fw` | n | Files / Grep / Grep word |
| `<leader>fb` / `f.` / `fh` | n | Buffers / Recent / Help |
| `<leader>fk` / `fl` | n | Keymaps / Buffer lines |
| `<leader>fs` / `fS` / `fr` | n | Symbols / Workspace symbols / Resume |
| `<leader>a` / `<leader>e` | n | Harpoon add / menu |
| `<leader>1-4` | n | Harpoon jump 1–4 |
| `-` | n | Oil file explorer |

### LSP & Code

| Key | Mode | Action |
|-----|------|--------|
| `K` | n | Hover documentation |
| `gD`/`gR`/`gY`/`gM` | n | Glance defs/refs/type/impl |
| `<leader>ca` / `<leader>cr` | n,v | Code actions / Rename |
| `[d` / `]d` | n | Prev / next diagnostic |
| `<leader>xx` / `<leader>xX` | n | Trouble diagnostics (all / buffer) |
| `<leader>xs` / `<leader>xl` | n | Trouble symbols / LSP refs |

### Debug (DAP)

| Key | Action |
|-----|--------|
| `<F5>` / `<F1>` / `<F2>` / `<F3>` | Continue / Into / Over / Out |
| `<F6>` | Toggle DAP UI |
| `<leader>db` / `<leader>dB` | Toggle / conditional breakpoint |
| `<leader>dpr` | Run to cursor |
| `<leader>dti` / `<leader>dtc` | DAP test method / class (Python) |

### Git

| Key | Action |
|-----|--------|
| `<leader>gl` | Git graph |
| `<leader>F` | Fugit2 (lazygit-like) |

### Editing

| Key | Mode | Action |
|-----|------|--------|
| `sa` + m + c | n | Add surround |
| `sd` + t | n | Delete surround |
| `sr` + t + c | n | Replace surround |
| `ga` / `gA` | n,x | Align / align preview |
| `<C-a>` / `<C-x>` | n | Increment / decrement |
| `gc` | n,v | Toggle comment |
| `<A-j/k>` | n,v | Move line down/up |
| `<Tab>` / `<S-Tab>` | v | Indent / outdent |

### Misc

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal (vertical) |
| `<Esc><Esc>` | Exit terminal mode |
| `<leader>p` | Yank history |
| `<leader>u` | Toggle undo tree |
| `<leader>in` | Browse nerd icons |
| `<leader>ha` | Annotate (haunt) |
| `<leader>9v` / `<leader>9s` | AI visual / search prompt |
| `<leader>st` | Scratch file |
| `zR` / `zM` | Open / close all folds |

## Colorscheme

[gruvbox-material](https://github.com/sainnhe/gruvbox-material) — soft background, dark mode.

## Docs

- [Plugin rationale](docs/plugins.md) — why each plugin is here and what was removed
- [LSP setup](docs/lsp.md) — native `vim.lsp.enable()` without lspconfig
- [Workflows](docs/workflows.md) — day-to-day editing, search, git, debug loops
- [Adding a language](docs/languages.md) — step-by-step for LSP, formatter, linter, treesitter

## Credits

Built with [lazy.nvim](https://github.com/folke/lazy.nvim). Unix philosophy-inspired.
