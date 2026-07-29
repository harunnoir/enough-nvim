-- Native Neovim LSP configuration (Neovim 0.11+).
vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

require('lsp.servers')

local servers = {
    'pyright',
    'clangd',
    'lua_ls',
    'ts_ls',
    'beancount',
    'rust_analyzer',
    'gopls',
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end
