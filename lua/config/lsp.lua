-- Allow vim.lsp.enable() to find Mason-installed servers
vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

-- LSP servers to enable (configs defined below via vim.lsp.config)
local servers = {
  'pyright', -- Python
  'clangd', -- C/C++
  'lua_ls', -- Lua
  'ts_ls', -- TypeScript/JavaScript
  'beancount', -- Plain text accounting
}
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- Python
-- vim.lsp.config('basedpyright', {
--     cmd = { 'basedpyright-langserver', '--stdio' },
--     filetypes = { 'python' },
--     root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
--     settings = {
--         basedpyright = {
--             analysis = {
--                 autoSearchPaths = true,
--                 useLibraryCodeForTypes = true,
--                 typeCheckingMode = 'basic',
--                 diagnosticMode = 'openFilesOnly',
--             },
--         },
--     },
-- })
vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        '.git',
    },
})

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
