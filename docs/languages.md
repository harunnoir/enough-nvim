# Adding a New Language

To add full support for a new language, you need up to four things:

## 1. Treesitter

Add the language to the `patterns` list in `lua/plugins/core.lua`:

```lua
local patterns = {
    -- ... existing ...
    'my_language',
}
```

## 2. LSP Server

In `lua/config/lsp.lua`:

```lua
vim.lsp.config('my_server', {
    cmd = { 'my-language-server', '--stdio' },
    filetypes = { 'my_filetype' },
    root_markers = { '.git', 'my-project-file' },
})
vim.lsp.enable('my_server')
```

Install via Mason if available: `:Mason`.

## 3. Formatter

In `lua/plugins/editor.lua`, inside the `conform` config:

```lua
formatters_by_ft = {
    -- ... existing ...
    my_filetype = { 'my_formatter' },
}
```

Optionally define custom formatter command:

```lua
formatters = {
    my_formatter = {
        command = 'my-formatter',
        args = { '$FILENAME' },
        stdin = false,
    },
}
```

## 4. Linter

In `lua/plugins/lsp.lua`, inside the `nvim-lint` config:

```lua
lint.linters_by_ft = {
    -- ... existing ...
    my_filetype = { 'my_linter' },
}
```

## 5. Filetype Settings (optional)

In `lua/config/cmd.lua`, add filetype-specific options:

```lua
local filetype_settings = {
    -- ... existing ...
    my_filetype = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,
}
```

## Quick Reference

| Step | File | What to add |
|------|------|-------------|
| Treesitter | `lua/plugins/core.lua` | Name in `patterns` list |
| LSP | `lua/config/lsp.lua` | `vim.lsp.config()` + `vim.lsp.enable()` |
| LSP install | `:Mason` | Install binary |
| Formatter | `lua/plugins/editor.lua` | Entry in `formatters_by_ft` |
| Linter | `lua/plugins/lsp.lua` | Entry in `lint.linters_by_ft` |
| Options | `lua/config/cmd.lua` | Entry in `filetype_settings` |
