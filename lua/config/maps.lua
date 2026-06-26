local map = vim.keymap.set

-- ── Core ─────────────────────────────────────────────────────────────
map('n', '<leader>w', '<CMD>w<CR>', { desc = 'Save' })
map('n', '<leader>q', '<CMD>q<CR>', { desc = 'Close window' })
map('n', '<leader>Q', '<CMD>qa<CR>', { desc = 'Quit all' })
map({ 'n', 'v' }, '<leader>cf', function() require('conform').format({ async = true }) end, { desc = 'Format' })

-- ── Diagnostics ───────────────────────────────────────────────────────
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- ── Move Lines ────────────────────────────────────────────────────────
map('n', '<A-S-j>', '<CMD>m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-S-k>', '<CMD>m .-2<CR>==', { desc = 'Move line up' })
map('v', '<A-S-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<A-S-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- ── Picker (snacks) ───────────────────────────────────────────────────
map('n', '<leader>ff', function() require('snacks').picker.files() end, { desc = 'Find files' })
map('n', '<leader>fg', function() require('snacks').picker.grep() end, { desc = 'Live grep' })
map('n', '<leader>fw', function() require('snacks').picker.grep_word() end, { desc = 'Grep word' })
map('n', '<leader>fb', function() require('snacks').picker.buffers() end, { desc = 'Buffers' })
map('n', '<leader>fr', function() require('snacks').picker.resume() end, { desc = 'Resume picker' })
map('n', '<leader>f.', function() require('snacks').picker.recent() end, { desc = 'Recent files' })
map('n', '<leader>fh', function() require('snacks').picker.help() end, { desc = 'Help tags' })
map('n', '<leader>fk', function() require('snacks').picker.keymaps() end, { desc = 'Keymaps' })
map('n', '<leader>fl', function() require('snacks').picker.lines() end, { desc = 'Buffer lines' })
map('n', '<leader>fs', function() require('snacks').picker.lsp_symbols() end, { desc = 'LSP symbols' })
map('n', '<leader>fS', function() require('snacks').picker.lsp_workspace_symbols() end, { desc = 'Workspace symbols' })

-- ── Trouble ───────────────────────────────────────────────────────────
map('n', '<leader>xx', '<CMD>Trouble diagnostics toggle<CR>', { desc = 'Diagnostics' })
map('n', '<leader>xX', '<CMD>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Buffer diagnostics' })
map('n', '<leader>xs', '<CMD>Trouble symbols toggle focus=false<CR>', { desc = 'Symbols' })
map('n', '<leader>xl', '<CMD>Trouble lsp toggle focus=false<CR>', { desc = 'LSP references' })

-- ── LSP ───────────────────────────────────────────────────────────────
map('n', 'K', '<CMD>Lspsaga hover_doc<CR>', { desc = 'Hover doc' })
map('n', 'gD', '<CMD>Glance definitions<CR>', { desc = 'Definitions' })
map('n', 'gR', '<CMD>Glance references<CR>', { desc = 'References' })
map('n', 'gY', '<CMD>Glance type definitions<CR>', { desc = 'Type definitions' })
map('n', 'gM', '<CMD>Glance implementations<CR>', { desc = 'Implementations' })
map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
map('n', '<leader>cr', '<CMD>Lspsaga rename<CR>', { desc = 'Rename symbol' })

-- ── Splits ────────────────────────────────────────────────────────────
map('n', '<leader>sv', '<C-w>v', { desc = 'Split vertical' })
map('n', '<leader>sh', '<C-w>s', { desc = 'Split horizontal' })
map('n', '<leader>sx', '<C-w>c', { desc = 'Close split' })
map('n', '<leader>se', '<C-w>=', { desc = 'Equalize splits' })

-- ── Smart Splits: Navigation ──────────────────────────────────────────
map('n', '<C-h>', function() require('smart-splits').move_cursor_left() end, { desc = 'Move to left split' })
map('n', '<C-j>', function() require('smart-splits').move_cursor_down() end, { desc = 'Move to lower split' })
map('n', '<C-k>', function() require('smart-splits').move_cursor_up() end, { desc = 'Move to upper split' })
map('n', '<C-l>', function() require('smart-splits').move_cursor_right() end, { desc = 'Move to right split' })

-- ── Smart Splits: Resize ──────────────────────────────────────────────
map('n', '<A-h>', require('smart-splits').resize_left, { desc = 'Resize left' })
map('n', '<A-j>', require('smart-splits').resize_down, { desc = 'Resize down' })
map('n', '<A-k>', require('smart-splits').resize_up, { desc = 'Resize up' })
map('n', '<A-l>', require('smart-splits').resize_right, { desc = 'Resize right' })

-- ── Smart Splits: Swap Buffers ────────────────────────────────────────
map('n', '<leader><leader>h', function() require('smart-splits').swap_buf_left() end, { desc = 'Swap buf left' })
map('n', '<leader><leader>j', function() require('smart-splits').swap_buf_down() end, { desc = 'Swap buf down' })
map('n', '<leader><leader>k', function() require('smart-splits').swap_buf_up() end, { desc = 'Swap buf up' })
map('n', '<leader><leader>l', function() require('smart-splits').swap_buf_right() end, { desc = 'Swap buf right' })

-- ── Yank (yanky) ──────────────────────────────────────────────────────
map({ 'n', 'x' }, 'y', '<Plug>(YankyYank)', { desc = 'Yank' })
map({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'Paste after' })
map({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'Paste before' })
map({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)', { desc = 'Paste after (cursor after)' })
map({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)', { desc = 'Paste before (cursor after)' })
map('n', '<A-p>', '<Plug>(YankyPreviousEntry)', { desc = 'Cycle yank prev' })
map('n', '<A-n>', '<Plug>(YankyNextEntry)', { desc = 'Cycle yank next' })
map({ 'n', 'x' }, '<leader>p', '<cmd>YankyRingHistory<cr>', { desc = 'Yank history' })

-- ── Visual ────────────────────────────────────────────────────────────
map('v', '<Tab>', '>gv', { desc = 'Indent' })
map('v', '<S-Tab>', '<gv', { desc = 'Outdent' })

-- ── Misc ──────────────────────────────────────────────────────────────
map('n', '<Tab>', 'za', { desc = 'Toggle fold' })
map('n', '<BS>', '<C-^>', { desc = 'Alternate buffer' })

-- ── Terminal ──────────────────────────────────────────────────────────
-- map({ 'n', 't' }, '<C-\\>', function() require('snacks').terminal.toggle(nil, { win = { style = 'float' } }) end, { desc = 'Toggle terminal' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- ── Git ──────────────────────────────────────────────────────────
-- map(']h', function() require('gitsigns').next_hunk() end, desc = 'Next hunk')
-- map('[h', function() require('gitsigns').prev_hunk() end, desc = 'Prev hunk')
