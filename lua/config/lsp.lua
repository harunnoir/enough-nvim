-- Enable Language Server Protocol servers
vim.lsp.enable('basedpyright')
vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('beancount')

-- Configure basedpyright (Python language server)
vim.lsp.config('basedpyright', {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        '.git',
    },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
            },
        },
    },
})

-- Configure clangd (C/C++ language server)
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

-- Configure beancount (Beancount language server for plain text accounting)
vim.lsp.config('beancount', {
    cmd = { 'beancount-language-server' },
    filetypes = { 'beancount' },
    root_markers = { '.git', '.beancount', 'main.bean', 'ledger.bean' },
})

-- Configure lua_ls (Lua language server)
vim.lsp.config('lua_ls', {
    filetypes = { 'lua' },
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            runtime = { version = 'LuaJIT' },
        },
    },
})

-- Configure diagnostic signs
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

-- Enable inlay hints globally
vim.lsp.inlay_hint.enable(true)
