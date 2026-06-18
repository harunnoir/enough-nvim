local map = vim.keymap.set

-- Core
map('n', '<C-s>', '<CMD>w<CR>', { desc = 'Save' })
map('n', '<leader>q', '<CMD>q<CR>', { desc = 'Quit' })

map({ 'n', 'v' }, '<leader>f', function()
    require('conform').format({ async = true })
end, { desc = 'Format' })

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Move lines
map('n', '<A-j>', '<CMD>m .+1<CR>==', { desc = 'Move down' })
map('n', '<A-k>', '<CMD>m .-2<CR>==', { desc = 'Move up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move up' })

-- Telescope
map('n', '<leader>tt', '<CMD>Telescope<CR>', { desc = 'Telescope' })
map('n', '<leader>tf', '<CMD>Telescope find_files<CR>', { desc = 'Find files' })
map('n', '<leader>tg', '<CMD>Telescope live_grep<CR>', { desc = 'Live grep' })
map('n', '<leader>tb', '<CMD>Telescope buffers<CR>', { desc = 'Buffers' })
map('n', '<leader>tr', '<CMD>Telescope resume<CR>', { desc = 'Resume' })
map('n', '<leader>th', '<CMD>Telescope help_tags<CR>', { desc = 'Help' })
map('n', '<leader>ts', '<CMD>Telescope grep_string<CR>', { desc = 'Grep string' })
map('n', '<leader>tc', '<CMD>Telescope commands<CR>', { desc = 'Commands' })
map('n', '<leader>tm', '<CMD>Telescope marks<CR>', { desc = 'Marks' })
map('n', '<leader>to', '<CMD>Telescope oldfiles<CR>', { desc = 'Old files' })
map('n', '<leader>td', '<CMD>Telescope diagnostics<CR>', { desc = 'Diagnostics' })
map('n', '<leader>tG', '<CMD>Telescope git_files<CR>', { desc = 'Git files' })
map('n', '<leader>tgs', '<CMD>Telescope git_status<CR>', { desc = 'Git status' })
map('n', '<leader>tgb', '<CMD>Telescope git_branches<CR>', { desc = 'Git branches' })
map('n', '<leader>tgl', '<CMD>Telescope git_log<CR>', { desc = 'Git log' })

-- Trouble
map('n', '<leader>xx', '<CMD>Trouble diagnostics toggle<CR>', { desc = 'Diagnostics' })
map('n', '<leader>xX', '<CMD>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Buffer diag' })
map('n', '<leader>xs', '<CMD>Trouble symbols toggle focus=false<CR>', { desc = 'Symbols' })
map('n', '<leader>xl', '<CMD>Trouble lsp toggle focus=false<CR>', { desc = 'LSP refs' })

-- Splits
map('n', '<leader>sv', '<C-w>v', { desc = 'Split vertical' })
map('n', '<leader>sh', '<C-w>s', { desc = 'Split horizontal' })
map('n', '<leader>sx', '<C-w>c', { desc = 'Close split' })
map('n', '<leader>se', '<C-w>=', { desc = 'Equalize' })

-- Resize splits
map('n', '<M-,>', '<C-w>3<', { desc = 'Shrink width' })
map('n', '<M-.>', '<C-w>3>', { desc = 'Expand width' })
map('n', '<M-->', '<C-w>3-', { desc = 'Shrink height' })
map('n', '<M-=>', '<C-w>3+', { desc = 'Expand height' })

-- LSP UI
map('n', 'K', '<CMD>Lspsaga hover_doc<CR>')

map('n', 'gD', '<CMD>Glance definitions<CR>')
map('n', 'gR', '<CMD>Glance references<CR>')
map('n', 'gY', '<CMD>Glance type_definitions<CR>')
map('n', 'gM', '<CMD>Glance implementations<CR>')

map('n', 'gP', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { desc = 'Preview def' })

map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })

-- Misc
vim.keymap.set('n', '<Tab>', 'za', { desc = 'Toggle fold' })
vim.keymap.set('n', '<BS>', '<C-^>', { desc = 'Alt buffer' })

-- Clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank system' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line system' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste after' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = 'Paste before' })

-- Visual helpers
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent' })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Outdent' })
