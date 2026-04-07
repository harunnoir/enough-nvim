local map = vim.keymap.set

-- Ctrl keys
map('n', '<C-s>', '<CMD>w<CR>', { desc = 'Save' })
map('n', '<C-q>', '<CMD>q<CR>', { desc = 'Quit' })
map({ 'n', 'v' }, '<C-f>', function()
	require('conform').format { async = true }
end, { desc = 'Format' })

-- Oil
map('n', '-', '<CMD>Oil<CR>', { desc = 'Parent dir' })

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diag' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diag' })

-- Move lines
map('n', '<A-j>', '<CMD>m .+1<CR>==', { desc = 'Down' })
map('n', '<A-k>', '<CMD>m .-2<CR>==', { desc = 'Up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Up' })

-- Telescope
map('n', 'tt', '<CMD>Telescope<CR>')
map('n', 'tf', '<CMD>Telescope find_files<CR>')
map('n', 'tg', '<CMD>Telescope live_grep<CR>')
map('n', 'tb', '<CMD>Telescope buffers<CR>')
map('n', 'tr', '<CMD>Telescope resume<CR>')
map('n', 'th', '<CMD>Telescope help_tags<CR>')
map('n', 'ts', '<CMD>Telescope grep_string<CR>')
map('n', 'tc', '<CMD>Telescope commands<CR>')
map('n', 'tm', '<CMD>Telescope marks<CR>')
map('n', 'to', '<CMD>Telescope oldfiles<CR>')
map('n', 'td', '<CMD>Telescope diagnostics<CR>')
map('n', 'tG', '<CMD>Telescope git_files<CR>')
map('n', 'tgs', '<CMD>Telescope git_status<CR>')
map('n', 'tgb', '<CMD>Telescope git_branches<CR>')
map('n', 'tgl', '<CMD>Telescope git_log<CR>')

-- Trouble
map('n', 'xx', '<CMD>Trouble diagnostics toggle<CR>')
map('n', 'xX', '<CMD>Trouble diagnostics toggle filter.buf=0<CR>')
map('n', 'xs', '<CMD>Trouble symbols toggle focus=false<CR>')
map('n', 'xl', '<CMD>Trouble lsp toggle focus=false<CR>')
