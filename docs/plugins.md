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
| `nvim-treesitter` | Syntax highlighting and parser-backed folds |
| `nvim-ufo` | Better folds than built-in `foldmethod=expr` alone |

### treesitter.lua

| Plugin | Why |
|--------|-----|
| `nvim-treesitter-textobjects` | Structural selections, movements, and argument swaps |

### mini.lua

| Module | Why |
|--------|-----|
| `mini.ai` | Better text objects (`ia`, `aa`, `il`, `al`, etc.) |
| `mini.align` | Align assignments and tables (`ga`/`gA`) |
| `mini.surround` | Add, delete, and replace surrounds (`sa`, `sd`, `sr`) |
| `mini.clue` | Discoverable leader-key groups |
| `mini.hipatterns` | Highlight hex colors in code |
| `mini.starter` | Lightweight recent-file start screen |

### lsp.lua

| Plugin | Why |
|--------|-----|
| `mason.nvim` | LSP/formatter installer UI — `:Mason` |
| `tiny-inline-diagnostic` | Inline diagnostics at end of line (replaces virtual_text) |
| `nvim-lint` | Async linter via `:lua require('lint').try_lint()` |
| `fidget.nvim` | LSP progress spinner in statusline |
| `symbol-usage.nvim` | Shows reference/definition counts inline |

### completion.lua

| Plugin | Why |
|--------|-----|
| `blink.cmp` | Completion — fast, native-feeling, Neovim 0.11 compatible |

### editor.lua

| Plugin | Why |
|--------|-----|
| `conform.nvim` | Format on demand (`<leader>cf`) — per-filetype config |
| `nvim-autopairs` | Auto-close brackets |
| `grug-far.nvim` | Search & replace across files (`:GrugFar`) |
| `trouble.nvim` | Diagnostic/symbol/reference list in a quickfix-like window |
| `vim-repeat` | Make `.` repeat plugin actions (surround, etc.) |
| `treesj` | Split/join blocks — function args, if/else, tables (`<leader>sj`) |
| `dial.nvim` | Increment/decrement numbers, dates, hex colors (`<C-a>`/`<C-x>`) |
| `smart-paste.nvim` | Smart indent-aware pasting |

### navigation.lua

| Plugin | Why |
|--------|-----|
| `nvim-spider` | Smarter `w`/`e`/`b` — respects camelCase and snake_case |
| `maximize.nvim` | Toggle current window to full screen (`<leader>z`) |
| `flash.nvim` | Jump anywhere visible (`gs`/`gS`) — replaces leap |
| `snacks.picker` | Fuzzy finder (`<leader>ff`, `fg`, `fw`, etc.) — replaces Telescope |
| `glance.nvim` | LSP references/definitions in a peek window (`gD`, `gR`, etc.) |
| `oil.nvim` | File explorer as a buffer (`-`) — edit paths directly |
| `oil-lsp-diagnostics` | Show diags in Oil |
| `oil-git` | Show git status in Oil |
| `harpoon` | Quick file marks (`<leader>a`, `<leader>1-4`) |
| `marks.nvim` | Visual indicators for `'a-'z` marks |
| `smart-splits.nvim` | Window navigation (`<C-h/j/k/l>`) and resize (`<A-h/j/k/l>`) |

### git.lua

| Plugin | Why |
|--------|-----|
| `gitsigns.nvim` | Git signs in signcolumn, hunk staging, blame |
| `gitgraph.nvim` | Git log as an interactive graph (`<leader>Gl`) |

### debug.lua

| Plugin | Why |
|--------|-----|
| `nvim-dap` | Debug adapter protocol — Python, Go, etc. |
| `nvim-dap-ui` | UI for DAP (scopes, watches, stack, breakpoints, REPL) |
| `nvim-dap-python` | Python debugger (debugpy) — pytest integration |
| `nvim-dap-go` | Go debugger (delve) |

### themes.lua

| Plugin | Why |
|--------|-----|
| `limei.nvim` and alternatives | Colorschemes selected by `theme` in `themes.lua` |

### ui.lua

| Plugin | Why |
|--------|-----|
| `slimline.nvim` | Statusline — minimal, theme-aware, no dependencies |
| `snacks.nvim` | Picker, terminal, statuscolumn, indent guides, and animations |
| `noice.nvim` | Cmdline UI — replaces the default cmdline with a popup |
| `yanky.nvim` | Yank history ring |
| `virt-column.nvim` | Soft structural column using the theme's `VirtColumn` highlight |
| `quicker.nvim` | Quickfix window improvements |
| `todo-comments.nvim` | Highlight and search TODO/FIXME/HACK comments |
| `nvim-web-devicons` | File type icons |
| `csvview.nvim` | CSV viewer with field navigation |

### terminal.lua

| Plugin | Why |
|--------|-----|
| `snacks.terminal` | One toggleable terminal with mappings beside its integration |

### extras.lua

| Plugin | Why |
|--------|-----|
| `overseer.nvim` | Task runner — make, scripts, build tasks |
| `haunt.nvim` | Bookmark/annotate lines (`<leader>ha` etc.) |
| `hardtime.nvim` | Discourage bad movement habits (hjkl overuse) |
| `nerdy.nvim` | Nerd Font icon browser (`<leader>in`) |
| `undotree.nvim` | Visual undo tree (`<leader>u`) |
| `leetcode.nvim` | LeetCode in Neovim |
| `persistence.nvim` | Auto-save/restore sessions |

### ai.lua

| Plugin | Why |
|--------|-----|
| `99` | AI chat in Neovim (`<leader>9v`/`9s`) |

### languages.lua

| Plugin | Why |
|--------|-----|
| `render-markdown.nvim` | WYSIWYG markdown preview |
| `uv.nvim` | Python uv integration |

### 42.lua

| Plugin | Why |
|--------|-----|
| `42-header.nvim` | Insert and maintain 42 School headers |
| `norminette42.nvim` | Run Norminette diagnostics for C/C++ |

## What Was Removed / Rejected

| Plugin | Reason |
|--------|--------|
| `nvim-lspconfig` | Neovim 0.11 has `vim.lsp.enable()` built-in |
| `goto-preview` | Replaced by glance.nvim (cleaner UX) |
| `vim-tmux-navigator` | Replaced by smart-splits.nvim (works without tmux) |
| `alpha-nvim` | Replaced by mini.starter (lighter) |
| `leap.nvim` | Replaced by flash.nvim (more features, same speed) |
| `colorizer.nvim` | Replaced by mini.hipatterns (lighter) |
| `obsidian.nvim`, `neorg` | Not in active use — removed |
| `tabby.nvim` | Not needed — statusline is enough |
| `vim-startuptime` | Debug-only, removed from active config |
| `dictionary.nvim` | Redundant — `blink-cmp-words` handles thesaurus/dictionary |
| `atone.nvim` | Redundant — undotree covers undo visualization |
| `telescope.nvim` | Replaced by snacks.picker (built-in, one less plugin) |
| `presenting.nvim` | Presentation mode — niche, removed to trim |
| `calcium.nvim` | In-buffer calculator — redundant with built-in `=` |
| `typr.nvim` | Typing tutor — fun but unused |
