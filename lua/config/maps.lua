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
map('n', '<leader>ff', '<CMD>Telescope find_files<CR>', { desc = 'Find files' })
map('n', '<leader>fg', '<CMD>Telescope live_grep<CR>', { desc = 'Live grep' })
map('n', '<leader>fb', '<CMD>Telescope buffers<CR>', { desc = 'Buffers' })
map('n', '<leader>fh', '<CMD>Telescope help_tags<CR>', { desc = 'Help' })
map('n', '<leader>fr', '<CMD>Telescope resume<CR>', { desc = 'Resume' })

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
map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })

-- Misc
map('n', '<Tab>', 'za', { desc = 'Toggle fold' })
map('n', '<BS>', '<C-^>', { desc = 'Alt buffer' })

-- Clipboard
map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank system' })
map('n', '<leader>Y', '"+Y', { desc = 'Yank line system' })
map({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste after' })
map({ 'n', 'v' }, '<leader>P', '"+P', { desc = 'Paste before' })

-- Visual helpers
map('v', '<Tab>', '>gv', { desc = 'Indent' })
map('v', '<S-Tab>', '<gv', { desc = 'Outdent' })

-- Smart splits: moving between splits
map('n', '<C-h>', require('smart-splits').move_cursor_left)
map('n', '<C-j>', require('smart-splits').move_cursor_down)
map('n', '<C-k>', require('smart-splits').move_cursor_up)
map('n', '<C-l>', require('smart-splits').move_cursor_right)
map('n', '<C-\\>', require('smart-splits').move_cursor_previous)

-- Smart splits: swapping buffers between windows
map('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
map('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
map('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
map('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
