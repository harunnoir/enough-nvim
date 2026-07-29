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
│   │   ├── lazy.lua          lazy.nvim bootstrap
│   │   ├── opts.lua          editor options
│   │   ├── maps.lua          core keymaps
│   │   ├── lsp.lua           LSP server config (vim.lsp.enable)
│   │   ├── cmd.lua           autocommands / filetype settings
│   │   └── neovide.lua       Neovide GUI config
│   └── plugins/              one file per concern
│       ├── core.lua          treesitter, ufo
│       ├── ts.lua            treesitter text objects
│       ├── mini.lua          mini.nvim modules
│       ├── lsp.lua           mason, tiny-inline-diagnostic, nvim-lint, fidget, symbol-usage
│       ├── editor.lua        blink.cmp, conform, treesj, trouble, dial
│       ├── nav.lua           flash, harpoon, oil, glance, smart-splits, marks
│       ├── git.lua           gitsigns, gitgraph
│       ├── dap.lua           nvim-dap, dap-ui, python/go debugger
│       ├── ai.lua            99 AI chat
│       ├── ui.lua            colorschemes, snacks, noice, slimline
│       ├── misc.lua          haunt, undotree, nerdy, overseer
│       ├── lang.lua          language-specific extras
│       └── 42.lua            42 School tooling
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
| `<leader>z` | n | Toggle maximize |
| `<BS>` | n | Alternate buffer |

### Search & Navigate

| Key | Mode | Action |
|-----|------|--------|
| `gs` / `gS` | n,x,o | Flash jump / Flash treesitter |
| `w`/`e`/`b`/`ge` | n,o,x | Spider word motions |
| `<leader>ff` / `fg` / `fw` | n | Files / Grep / Grep word |
| `<leader>fr` / `f.` / `fh` | n | Recent / Resume / Help |
| `<leader>fk` / `fl` / `fp` | n | Keymaps / Buffer lines / Projects |
| `<leader>bb` / `bd` | n | List buffers / Delete buffer |
| `<leader>a` / `<leader>e` | n | Harpoon add / menu |
| `<leader>1-4` | n | Harpoon jump 1–4 |
| `-` | n | Oil file explorer |

### LSP & Code

| Key | Mode | Action |
|-----|------|--------|
| `K` | n | Hover documentation |
| `gD`/`gR`/`gY`/`gM` | n | Glance defs/refs/type/impl |
| `<leader>ca` | n,v | Code actions |
| `<leader>cr` | n | Rename symbol |
| `<leader>cs` / `cS` | n | Symbols / Workspace symbols |
| `[d` / `]d` | n | Prev / next diagnostic |
| `<leader>xx` / `<leader>xX` | n | Trouble diagnostics (all / buffer) |
| `<leader>xs` / `<leader>xl` | n | Trouble symbols / LSP refs |

### Debug (DAP)

| Key | Action |
|-----|--------|
| `<leader>dc` / `di` / `do` / `dO` | Continue / Into / Over / Out |
| `<leader>dr` | Run to cursor |
| `<leader>db` / `dB` | Toggle / conditional breakpoint |
| `<leader>du` | Toggle DAP UI |
| `<leader>dti` / `dtc` | Test method / class (Python) |

### Git

| Key | Action |
|-----|--------|
| `<leader>Gg` | Lazygit |
| `<leader>Gb` | Blame line |
| `<leader>Gh` | Preview hunk |
| `<leader>Gs` | Stage hunk |
| `<leader>Gu` | Unstage hunk |
| `<leader>Gl` | Git graph |
| `<leader>GB` | Git browse |

### Editing

| Key | Mode | Action |
|-----|------|--------|
| `sa` + m + c | n | Add surround |
| `sd` + t | n | Delete surround |
| `sr` + t + c | n | Replace surround |
| `ga` / `gA` | n,x | Align / align preview |
| `<C-a>` / `<C-x>` | n | Increment / decrement |
| `gc` | n,v | Toggle comment |
| `<A-S-j/k>` | n,v | Move line down/up |
| `<Tab>` / `<S-Tab>` | v | Indent / outdent |
| `<leader>sj` | n | Toggle split/join (treesj) |

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
| `<leader>or/t/oo/ox/os/oa` | Overseer task runner |
| `zR` / `zM` | Open / close all folds |

## Colorscheme

Switch via the `theme` variable at the top of `lua/plugins/ui.lua`.

Available: `limei` (default), `solarized`, `gruvbox-material`, `gruvbox`,
`gruvbox-new`, `zen`, `vague`, `miasma`, `kanagawa`, and `farout`.

## Docs

- [Plugin rationale](docs/plugins.md) — why each plugin is here and what was removed
- [LSP setup](docs/lsp.md) — native `vim.lsp.enable()` without lspconfig
- [Workflows](docs/workflows.md) — day-to-day editing, search, git, debug loops
- [Adding a language](docs/languages.md) — step-by-step for LSP, formatter, linter, treesitter

## Validation

```bash
make format   # format Lua
make check    # verify formatting and Lua syntax
make test     # load the complete config headlessly
```

## Credits

Built with [lazy.nvim](https://github.com/folke/lazy.nvim). Unix philosophy-inspired.
