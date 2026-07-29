local map = vim.keymap.set

-- Editor primitives belong here; plugin mappings live with their plugin specs.
map('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save' })
map('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Close window' })
map('n', '<leader>Q', '<cmd>quitall<cr>', { desc = 'Quit all' })
map('n', '<BS>', '<C-^>', { desc = 'Alternate buffer' })
map('n', '<Tab>', 'za', { desc = 'Toggle fold' })

map('n', '<A-S-j>', '<cmd>move .+1<cr>==', { desc = 'Move line down' })
map('n', '<A-S-k>', '<cmd>move .-2<cr>==', { desc = 'Move line up' })
map('v', '<A-S-j>', ":move '>+1<cr>gv=gv", { desc = 'Move selection down' })
map('v', '<A-S-k>', ":move '<-2<cr>gv=gv", { desc = 'Move selection up' })
map('v', '<Tab>', '>gv', { desc = 'Indent' })
map('v', '<S-Tab>', '<gv', { desc = 'Outdent' })

map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Previous diagnostic' })
map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Next diagnostic' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename symbol' })

map('n', '<leader>sv', '<C-w>v', { desc = 'Split vertical' })
map('n', '<leader>sh', '<C-w>s', { desc = 'Split horizontal' })
map('n', '<leader>sx', '<C-w>c', { desc = 'Close split' })
map('n', '<leader>se', '<C-w>=', { desc = 'Equalize splits' })
