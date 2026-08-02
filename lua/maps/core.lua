local map = vim.keymap.set

-- Native editor primitives.
map('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save' })
map('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Close window' })
map('n', '<leader>Q', '<cmd>quitall<cr>', { desc = 'Quit all' })
map('n', '<BS>', '<C-^>', { desc = 'Alternate buffer' })
map('n', '<Tab>', 'za', { desc = 'Toggle fold' })
map("n", "<leader>ya", ":%y+<CR>", {
    desc = "Yank entire file to system clipboard",
    silent = true,
})

map('n', '<A-S-j>', '<cmd>move .+1<cr>==', { desc = 'Move line down' })
map('n', '<A-S-k>', '<cmd>move .-2<cr>==', { desc = 'Move line up' })
map('v', '<A-S-j>', ":move '>+1<cr>gv=gv", { desc = 'Move selection down' })
map('v', '<A-S-k>', ":move '<-2<cr>gv=gv", { desc = 'Move selection up' })
map('v', '<Tab>', '>gv', { desc = 'Indent' })
map('v', '<S-Tab>', '<gv', { desc = 'Outdent' })

map('n', '<leader>sv', '<C-w>v', { desc = 'Split vertical' })
map('n', '<leader>sh', '<C-w>s', { desc = 'Split horizontal' })
map('n', '<leader>sx', '<C-w>c', { desc = 'Close split' })
map('n', '<leader>se', '<C-w>=', { desc = 'Equalize splits' })

return {
    folds = {
        { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
        { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
    },
}
