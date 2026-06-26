# Plugins

## Philosophy

Every plugin answers "yes" to at least two of:
1. Does it solve a real friction point?
2. Can I not get this from built-in Neovim?
3. Is it well-maintained and minimal?

## By Category

### core.lua

| Plugin | Why |
|--------|-----|
| `nvim-treesitter` | Syntax highlighting, folds, text objects — the standard |
| `nvim-ufo` | Better folds than built-in `foldmethod=expr` alone |

### lsp.lua

| Plugin | Why |
|--------|-----|
| `mason.nvim` | LSP/formatter installer UI — `:Mason` |
| `tiny-inline-diagnostic` | Inline diagnostics at end of line (replaces virtual_text) |
| `lspsaga.nvim` | Hover doc (`K`), code action UI — clean and fast |
| `nvim-lint` | Async linter via `:lua require('lint').try_lint()` |
| `fidget.nvim` | LSP progress spinner in statusline |
| `symbol-usage.nvim` | Shows reference/definition counts inline |

### editor.lua

| Plugin | Why |
|--------|-----|
| `blink.cmp` | Completion — fast, native-feeling, Neovim 0.11 compatible |
| `conform.nvim` | Format on demand (`<leader>f`) — per-filetype config |
| `nvim-autopairs` | Auto-close brackets |
| `mini.align` | Align assignments/tables (`ga`/`gA`) |
| `mini.ai` | Better text objects (`ia`, `aa`, `il`, `al`, etc.) |
| `mini.surround` | Add/delete/replace surrounds (`sa`, `sd`, `sr`) — default `s` prefix |
| `grug-far.nvim` | Search & replace across files (`:GrugFar`) |
| `trouble.nvim` | Diagnostic/symbol/reference list in a quickfix-like window |
| `Comment.nvim` | Toggle comments (`gc`) |
| `vim-repeat` | Make `.` repeat plugin actions (surround, etc.) |
| `dial.nvim` | Increment/decrement numbers, dates, hex colors (`<C-a>`/`<C-x>`) |

### nav.lua

| Plugin | Why |
|--------|-----|
| `nvim-spider` | Smarter `w`/`e`/`b` — respects camelCase and snake_case |
| `nvim-maximizer` | Toggle current window to full screen (`<C-m>`) |
| `flash.nvim` | Jump anywhere visible (`gs`/`gS`) — replaces leap |
| `snacks.picker` | Fuzzy finder (`ff`, `fg`, `fb`, `fh`, `fr`) — replaces Telescope |
| `glance.nvim` | LSP references/definitions in a peek window (`gD`, `gR`, etc.) |
| `oil.nvim` | File explorer as a buffer (`-`) — edit paths directly |
| `oil-lsp-diagnostics` | Show diags in Oil |
| `oil-git` | Show git status in Oil |
| `harpoon` | Quick file marks (`<leader>a`, `<leader>1-4`) |
| `marks.nvim` | Visual indicators for `'a-'z` marks |
| `satellite.nvim` | Scrollbar with diagnostics, marks, search highlights |

### git.lua

| Plugin | Why |
|--------|-----|
| `gitsigns.nvim` | Git signs in signcolumn, hunk staging, blame |
| `gitgraph.nvim` | Git log as an interactive graph (`<leader>gl`) |
| `fugit2.nvim` | Lazygit-like TUI inside Neovim (`<leader>F`) |

### dap.lua

| Plugin | Why |
|--------|-----|
| `nvim-dap` | Debug adapter protocol — Python, Go, etc. |
| `nvim-dap-ui` | UI for DAP (scopes, watches, stack, breakpoints, REPL) |
| `nvim-dap-python` | Python debugger (debugpy) — pytest integration |
| `nvim-dap-go` | Go debugger (delve) |

### ui.lua

| Plugin | Why |
|--------|-----|
| `smart-splits.nvim` | `C-h/j/k/l` window navigation — works across tmux+Neovim |
| `gruvbox-material` | Colorscheme — soft dark, easy on the eyes |
| `slimline.nvim` | Statusline — minimal, theme-aware, no dependencies |
| `snacks.nvim` | Statuscolumn, picker, dashboard, terminal, indent guides, animations |
| `noice.nvim` | Cmdline UI — replaces the default cmdline with a popup |
| `yanky.nvim` | Yank history ring |
| `toggleterm.nvim` | Terminal — vertical/horizontal/float, persistent |
| `virt-column.nvim` | Soft colorcolumn at `NonText` highlight |
| `quicker.nvim` | Better quickfix window UX |
| `todo-comments.nvim` | Highlight `TODO`, `FIXME`, etc. |
| `csvview.nvim` | CSV viewer with column alignment and navigation |

### misc.lua

| Plugin | Why |
|--------|-----|
| `99` | AI chat in Neovim (`<leader>9v`/`9s`) |
| `haunt.nvim` | Bookmark/annotate lines (`<leader>ha` etc.) |
| `hardtime.nvim` | Discourage bad movement habits (hjkl overuse) |
| `mini.hipatterns` | Highlight hex colors in code |
| `render-markdown.nvim` | WYSIWYG markdown preview |
| `nerdy.nvim` | Nerd Font icon browser (`<leader>in`) |
| `undotree.nvim` | Visual undo tree (`<leader>u`) |
| `persistence.nvim` | Auto-save/restore sessions |
| `calcium.nvim` | In-buffer calculator |
| `leetcode.nvim` | LeetCode in Neovim |
| `presenting.nvim` | Presentation mode |

## What Was Removed / Rejected

| Plugin | Reason |
|--------|--------|
| `nvim-lspconfig` | Neovim 0.11 has `vim.lsp.enable()` built-in |
| `goto-preview` | Replaced by glance.nvim (cleaner UX) |
| `vim-tmux-navigator` | Replaced by smart-splits.nvim (works without tmux) |
| `alpha-nvim` | Replaced by dashboard-nvim (lighter) |
| `leap.nvim` | Replaced by flash.nvim (more features, same speed) |
| `colorizer.nvim` | Replaced by mini.hipatterns (lighter) |
| `obsidian.nvim`, `neorg` | Not in active use — removed |
| `tabby.nvim` | Not needed — statusline is enough |
| `vim-startuptime` | Debug-only, removed from active config |
| `dictionary.nvim` | Redundant — `blink-cmp-words` handles thesaurus/dictionary |
| `atone.nvim` | Redundant — `<leader>st` scratch helper covers the use case |
| `telescope.nvim` | Replaced by snacks.picker (built-in, one less plugin) |
