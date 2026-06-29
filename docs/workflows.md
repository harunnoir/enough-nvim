# Workflows

## Edit Loop

1. `<leader>ff` — find file
2. Edit
3. `<leader>cf` — format
4. `[d` / `]d` — jump between diagnostics
5. `<leader>xx` — view all diagnostics in Trouble
6. `<leader>w` — save

## Search & Replace

1. `<leader>fg` — grep across project
2. `<CR>` on a result to open
3. `:GrugFar` — project-wide search & replace
   - Enter pattern, replacement, file filter
   - Review changes, then apply

## Navigation

### Within a file
- `gs` — flash jump to any visible position
- `gS` — flash treesitter (jump to function, class, etc.)
- `w`/`e`/`b` — spider motions (respect camelCase, snake_case)
- `gd` — go to definition
- `gD` — glance at definitions in a peek window

### Between files
- `<leader>ff` — find files by name
- `<leader>fb` — switch buffers
- `<leader>1-4` — harpoon quick jumps
- `-` — Oil file explorer

### Between windows
- `<C-h/j/k/l>` — move cursor between splits
- `<C-m>` — maximize current window
- `<A-h/j/k/l>` — resize splits

## Git Workflow

1. `<leader>Gg` — lazygit
2. `<leader>Gl` — git graph (visual log)
3. Gitsigns gutter shows changed lines at a glance
4. `<leader>Gb` — blame, `<leader>Gs` — stage hunk

## Debugging

1. Set breakpoint: `<leader>db`
2. Start debugger: `<leader>dc`
3. Step: `<leader>di` (into), `<leader>do` (over), `<leader>dO` (out)
4. Toggle UI: `<leader>du`

## Adding Tools (Mason)

- `:Mason` — browse and install LSPs, formatters, linters
- Tools are automatically available to `vim.lsp.enable()`, conform, and nvim-lint
- No need to add Mason's bin dir to your shell PATH — Neovim handles it

## LSP & Code Intelligence

- `K` — hover documentation
- `<leader>ca` — code actions
- `gR` — glance references
- `gY` — glance type definitions
- `gM` — glance implementations
- `<leader>xl` — trouble LSP references list

## Terminal

- `<C-\>` — toggle vertical terminal (toggleterm)
- `<Esc><Esc>` — exit terminal mode to normal
- Runs in the same cwd as Neovim

## AI Assistant

- `<leader>9v` — select code visually, then prompt (visual mode)
- `<leader>9s` — search prompt
- `<leader>9x` — cancel current request
- Uses the `99` plugin with opencode model
