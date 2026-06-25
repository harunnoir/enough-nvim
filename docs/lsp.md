# LSP Setup

## Approach

This config uses **Neovim 0.11's built-in LSP client** directly — no `nvim-lspconfig`.

- `vim.lsp.enable('server_name')` — registers an LSP server
- `vim.lsp.config('server_name', { ... })` — configures its command, filetypes, settings
- All of this lives in `lua/config/lsp.lua`

## Active Servers

| Server | Filetypes | Notes |
|--------|-----------|-------|
| `pyright` | python | Lightweight Python LSP |
| `clangd` | c, cpp, objc, objcpp | C/C++ with clang-tidy |
| `lua_ls` | lua | Lua with `vim` globals |
| `ts_ls` | typescript, javascript, tsx, jsx | TypeScript/JS |
| `beancount` | beancount | Plain text accounting |

## Mason Integration

`mason.nvim` installs LSP servers (binaries like `pyright-langserver`, `clangd`, etc.).
It does **not** configure them — that's what `lsp.lua` is for.

```lua
-- 1. mason installs the binary
-- 2. lsp.lua finds it on PATH and configures it
vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', '.git' },
})
vim.lsp.enable('pyright')
```

## Adding a New LSP Server

1. Install via Mason: `:Mason` → search → `I`
2. Add to `lua/config/lsp.lua`:

```lua
vim.lsp.config('my_server', {
    cmd = { 'my-language-server', '--stdio' },
    filetypes = { 'my_filetype' },
    root_markers = { '.git' },
})
vim.lsp.enable('my_server')
```

3. Restart Neovim.

## Inlay Hints

Enabled globally:

```lua
vim.lsp.inlay_hint.enable(true)
```

## Diagnostic Signs

Custom signs for error/warn/hint/info — configured in `lsp.lua` via `vim.diagnostic.config`.
