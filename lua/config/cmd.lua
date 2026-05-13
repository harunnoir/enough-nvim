-- Save view (cursor position, folds, etc.) when leaving a buffer/window
vim.api.nvim_create_autocmd('BufWinLeave', {
    pattern = '*',
    callback = function()
        vim.cmd('silent! mkview')
    end,
})

-- Restore view when entering a buffer/window
vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*',
    callback = function()
        vim.cmd('silent! loadview')
    end,
})

-- Filetype-specific settings (colorcolumn, textwidth, indentation, etc.)
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'python' },
    callback = function()
        vim.opt_local.colorcolumn = '79,99'
        vim.opt_local.textwidth = 79
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.expandtab = true
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp' },
    callback = function()
        vim.opt_local.colorcolumn = '80,120'
        vim.opt_local.textwidth = 80
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.expandtab = false -- C typically uses tabs
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua' },
    callback = function()
        vim.opt_local.colorcolumn = '120'
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.expandtab = true
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown', 'text', 'rst' },
    callback = function()
        vim.opt_local.colorcolumn = '80'
        vim.opt_local.textwidth = 80
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'javascript', 'typescript', 'json' },
    callback = function()
        vim.opt_local.colorcolumn = '100'
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'yaml', 'toml' },
    callback = function()
        vim.opt_local.colorcolumn = '80'
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,
})
