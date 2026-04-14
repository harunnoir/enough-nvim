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
