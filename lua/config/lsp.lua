-- Allow vim.lsp.enable() to find Mason-installed servers
vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

-- LSP servers to enable (configs defined below via vim.lsp.config)
local servers = {
  -- 'pyright', -- Python
  'basedpyright', -- Python
  'clangd', -- C/C++
  'lua_ls', -- Lua
  'ts_ls', -- TypeScript/JavaScript
  'beancount', -- Plain text accounting
  'rust_analyzer', -- Rust
  'gopls', -- Go
}
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- TypeScript/JavaScript
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', '.git' },
})

-- Go
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work', '.git' },
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

-- Rust
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'Cargo.lock', '.git' },
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = { command = 'clippy' },
      inlayHints = { enable = true },
    },
  },
})

-- Python
vim.lsp.config('basedpyright', {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'all', -- off=none basic=common standard=unknown strict=full all=pedantic
                diagnosticMode = 'openFilesOnly',
            },
        },
    },
})

--[[ vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        '.git',
    },
}) ]]

-- C/C++
vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--all-scopes-completion',
    '--completion-style=detailed',
    '--header-insertion=iwyu',
    '--function-arg-placeholders',
    '--pch-storage=memory',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
})

-- Lua
vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            runtime = { version = 'LuaJIT' },
        },
    },
})

-- Beancount
vim.lsp.config('beancount', {
  cmd = { 'beancount-language-server' },
  filetypes = { 'beancount' },
  root_markers = { '.git', '.beancount', 'main.bean', 'ledger.bean' },
})

-- Diagnostics
vim.diagnostic.config({
  signs = {
    text = {
      ERROR = '',
      WARN = '',
      HINT = '',
      INFO = '',
    },
  },
})

-- Inlay hints
vim.lsp.inlay_hint.enable(true)
