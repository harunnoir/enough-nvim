local map = vim.keymap.set

-- ╔══════════════════════════════════════════════════════════════════════╗
-- ║                        KEYMAP TREE                                   ║
-- ╠══════════════════════════════════════════════════════════════════════╣
-- ║  (no prefix)   → vim primitives (save, quit, fold, alternate buf)    ║
-- ║  g*            → go-to / lsp navigation (vim convention)             ║
-- ║  z*            → folds (ufo)                                         ║
-- ║  [/]           → prev/next (diagnostics, hunks)                      ║
-- ║  motion        → w/e/b (spider), gs/gS (flash)                       ║
-- ╠══════════════════════════════════════════════════════════════════════╣
-- ║  <leader>f     → FILES & SEARCH                                      ║
-- ║  <leader>b     → BUFFERS                                             ║
-- ║  <leader>c     → CODE / LSP actions                                  ║
-- ║  <leader>G     → GIT                                                 ║
-- ║  <leader>s     → SPLITS                                              ║
-- ║  <leader>d     → DEBUG (DAP)                                         ║
-- ║  <leader>x     → DIAGNOSTICS / TROUBLE                               ║
-- ║  <leader>h     → BOOKMARKS (haunt)                                   ║
-- ║  <leader>i     → INSERT / ICONS                                      ║
-- ║  <leader>p     → PASTE / YANK history                                ║
-- ║  <leader>u     → UNDO tree                                           ║
-- ║  <leader>9     → AI (99 plugin)                                      ║
-- ║  <leader>a/e   → HARPOON add / menu                                  ║
-- ║  <leader>1-4   → HARPOON jump                                        ║
-- ╚══════════════════════════════════════════════════════════════════════╝

-- ── Primitives ────────────────────────────────────────────────────────
map('n', '<leader>w', '<CMD>w<CR>',  { desc = 'Save' })
map('n', '<leader>q', '<CMD>q<CR>',  { desc = 'Close window' })
map('n', '<leader>Q', '<CMD>qa<CR>', { desc = 'Quit all' })
map('n', '<BS>',      '<C-^>',       { desc = 'Alternate buffer' })
map('n', '<Tab>',     'za',          { desc = 'Toggle fold' })

-- ── Move lines ────────────────────────────────────────────────────────
map('n', '<A-S-j>', '<CMD>m .+1<CR>==',  { desc = 'Move line down' })
map('n', '<A-S-k>', '<CMD>m .-2<CR>==',  { desc = 'Move line up' })
map('v', '<A-S-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<A-S-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- ── Visual indent ─────────────────────────────────────────────────────
map('v', '<Tab>',   '>gv', { desc = 'Indent' })
map('v', '<S-Tab>', '<gv', { desc = 'Outdent' })

-- ── Terminal ──────────────────────────────────────────────────────────
-- <C-\> → toggleterm (defined in ui.lua, plugin handles open_mapping)
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- ── z = Folds (ufo) ──────────────────────────────────────────────────
map('n', 'zR', function() require('ufo').openAllFolds() end,  { desc = 'Open all folds' })
map('n', 'zM', function() require('ufo').closeAllFolds() end, { desc = 'Close all folds' })

-- ── [ / ] = Prev / Next ───────────────────────────────────────────────
map('n', '[d', vim.diagnostic.goto_prev,                    { desc = 'Prev diagnostic' })
map('n', ']d', vim.diagnostic.goto_next,                    { desc = 'Next diagnostic' })
map('n', '[h', function() require('gitsigns').prev_hunk() end, { desc = 'Prev hunk' })
map('n', ']h', function() require('gitsigns').next_hunk() end, { desc = 'Next hunk' })

-- ── g = Go-to / LSP navigation ───────────────────────────────────────
map('n', 'K',  '<CMD>Lspsaga hover_doc<CR>',      { desc = 'Hover doc' })
map('n', 'gD', '<CMD>Glance definitions<CR>',      { desc = 'Definitions' })
map('n', 'gR', '<CMD>Glance references<CR>',       { desc = 'References' })
map('n', 'gY', '<CMD>Glance type definitions<CR>', { desc = 'Type definitions' })
map('n', 'gM', '<CMD>Glance implementations<CR>',  { desc = 'Implementations' })
-- gs / gS → flash.nvim (motion plugin, defined below)

-- ── Motion overrides ─────────────────────────────────────────────────
-- Spider: smarter w/e/b (camelCase, snake_case aware)
map({ 'n', 'o', 'x' }, 'w',  function() require('spider').motion('w') end,  { desc = 'Spider w' })
map({ 'n', 'o', 'x' }, 'e',  function() require('spider').motion('e') end,  { desc = 'Spider e' })
map({ 'n', 'o', 'x' }, 'b',  function() require('spider').motion('b') end,  { desc = 'Spider b' })
map({ 'n', 'o', 'x' }, 'ge', function() require('spider').motion('ge') end, { desc = 'Spider ge' })

-- Flash: jump / treesitter select
map({ 'n', 'x', 'o' }, 'gs', function() require('flash').jump() end,             { desc = 'Flash jump' })
map({ 'n', 'x', 'o' }, 'gS', function() require('flash').treesitter() end,       { desc = 'Flash treesitter' })
map('o',                'r',  function() require('flash').remote() end,            { desc = 'Flash remote' })
map({ 'o', 'x' },      'R',  function() require('flash').treesitter_search() end, { desc = 'Flash treesitter search' })
map('c',                '<C-s>', function() require('flash').toggle() end,         { desc = 'Flash toggle search' })

-- ── <C-*> = Window navigation (smart-splits) ─────────────────────────
map('n', '<C-h>', function() require('smart-splits').move_cursor_left() end,  { desc = 'Move to left split' })
map('n', '<C-j>', function() require('smart-splits').move_cursor_down() end,  { desc = 'Move to lower split' })
map('n', '<C-k>', function() require('smart-splits').move_cursor_up() end,    { desc = 'Move to upper split' })
map('n', '<C-l>', function() require('smart-splits').move_cursor_right() end, { desc = 'Move to right split' })
map('n', '<leader>m', '<cmd>MaximizerToggle<CR>',                             { desc = 'Maximize window' })

-- ── <A-*> = Resize + yank cycle ──────────────────────────────────────
map('n', '<A-h>', function() require('smart-splits').resize_left() end,  { desc = 'Resize left' })
map('n', '<A-j>', function() require('smart-splits').resize_down() end,  { desc = 'Resize down' })
map('n', '<A-k>', function() require('smart-splits').resize_up() end,    { desc = 'Resize up' })
map('n', '<A-l>', function() require('smart-splits').resize_right() end, { desc = 'Resize right' })
map('n', '<A-p>', '<Plug>(YankyPreviousEntry)',                           { desc = 'Prev yank entry' })
map('n', '<A-n>', '<Plug>(YankyNextEntry)',                               { desc = 'Next yank entry' })

-- ── - = File explorer (Oil) ───────────────────────────────────────────
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open Oil' })

-- ── f = Files & Search ───────────────────────────────────────────────
map('n', '<leader>ff', function() require('snacks').picker.files() end,                          { desc = 'Find files' })
map('n', '<leader>fg', function() require('snacks').picker.grep() end,                           { desc = 'Live grep' })
map('n', '<leader>fw', function() require('snacks').picker.grep_word() end,                      { desc = 'Grep word' })
map('n', '<leader>fr', function() require('snacks').picker.recent() end,                         { desc = 'Recent files' })
map('n', '<leader>f.', function() require('snacks').picker.resume() end,                         { desc = 'Resume picker' })
map('n', '<leader>fh', function() require('snacks').picker.help() end,                           { desc = 'Help tags' })
map('n', '<leader>fk', function() require('snacks').picker.keymaps() end,                        { desc = 'Keymaps' })
map('n', '<leader>fl', function() require('snacks').picker.lines() end,                          { desc = 'Buffer lines' })

-- ── b = Buffers ───────────────────────────────────────────────────────
map('n', '<leader>bb', function() require('snacks').picker.buffers() end, { desc = 'List buffers' })
map('n', '<leader>bd', function() require('snacks').bufdelete() end,      { desc = 'Delete buffer' })

-- ── c = Code / LSP ───────────────────────────────────────────────────
map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,                                         { desc = 'Code actions' })
map('n',          '<leader>cr', '<CMD>Lspsaga rename<CR>',                                        { desc = 'Rename symbol' })
map({ 'n', 'v' }, '<leader>cf', function() require('conform').format({ async = true }) end,      { desc = 'Format' })
map('n',          '<leader>cs', function() require('snacks').picker.lsp_symbols() end,           { desc = 'Symbols' })
map('n',          '<leader>cS', function() require('snacks').picker.lsp_workspace_symbols() end, { desc = 'Workspace symbols' })
map('n',          '<leader>co', '<CMD>AerialToggle<CR>',                                          { desc = 'Outline toggle' })
map('n',          '<leader>cn', function() require('aerial').next() end,                          { desc = 'Next symbol' })
map('n',          '<leader>cp', function() require('aerial').prev() end,                          { desc = 'Prev symbol' })

-- ── G = Git ──────────────────────────────────────────────────────────
map('n', '<leader>Gg', function() require('snacks').lazygit() end,                                    { desc = 'Lazygit' })
map('n', '<leader>Gb', function() require('gitsigns').blame_line() end,                               { desc = 'Blame line' })
map('n', '<leader>Gh', function() require('gitsigns').preview_hunk() end,                             { desc = 'Preview hunk' })
map('n', '<leader>Gs', function() require('gitsigns').stage_hunk() end,                               { desc = 'Stage hunk' })
map('n', '<leader>Gu', function() require('gitsigns').undo_stage_hunk() end,                          { desc = 'Unstage hunk' })
map('n', '<leader>Gl', function() require('gitgraph').draw({}, { all = true, max_count = 5000 }) end, { desc = 'Git graph' })
map('n', '<leader>GB', function() require('snacks').gitbrowse() end,                                  { desc = 'Git browse' })

-- ── s = Splits ───────────────────────────────────────────────────────
map('n', '<leader>sv', '<C-w>v',  { desc = 'Split vertical' })
map('n', '<leader>sh', '<C-w>s',  { desc = 'Split horizontal' })
map('n', '<leader>sx', '<C-w>c',  { desc = 'Close split' })
map('n', '<leader>se', '<C-w>=',  { desc = 'Equalize splits' })

-- Smart splits: swap buffers across splits
map('n', '<leader><leader>h', function() require('smart-splits').swap_buf_left() end,  { desc = 'Swap buf left' })
map('n', '<leader><leader>j', function() require('smart-splits').swap_buf_down() end,  { desc = 'Swap buf down' })
map('n', '<leader><leader>k', function() require('smart-splits').swap_buf_up() end,    { desc = 'Swap buf up' })
map('n', '<leader><leader>l', function() require('smart-splits').swap_buf_right() end, { desc = 'Swap buf right' })

-- ── d = Debug (DAP) ──────────────────────────────────────────────────
map('n', '<leader>dc',  function() require('dap').continue() end,                                     { desc = 'Continue' })
map('n', '<leader>di',  function() require('dap').step_into() end,                                    { desc = 'Step into' })
map('n', '<leader>do',  function() require('dap').step_over() end,                                    { desc = 'Step over' })
map('n', '<leader>dO',  function() require('dap').step_out() end,                                     { desc = 'Step out' })
map('n', '<leader>dr',  function() require('dap').run_to_cursor() end,                                { desc = 'Run to cursor' })
map('n', '<leader>db',  function() require('dap').toggle_breakpoint() end,                            { desc = 'Toggle breakpoint' })
map('n', '<leader>dB',  function() require('dap').set_breakpoint(vim.fn.input('Condition: ')) end,   { desc = 'Conditional breakpoint' })
map('n', '<leader>du',  function() require('dapui').toggle() end,                                     { desc = 'Toggle DAP UI' })
map('n', '<leader>dti', function() require('dap-python').test_method() end,                           { desc = 'Test method (py)' })
map('n', '<leader>dtc', function() require('dap-python').test_class() end,                            { desc = 'Test class (py)' })

-- ── x = Diagnostics / Trouble ────────────────────────────────────────
map('n', '<leader>xx', '<CMD>Trouble diagnostics toggle<CR>',               { desc = 'Diagnostics' })
map('n', '<leader>xX', '<CMD>Trouble diagnostics toggle filter.buf=0<CR>',  { desc = 'Buffer diagnostics' })
map('n', '<leader>xs', '<CMD>Trouble symbols toggle focus=false<CR>',       { desc = 'Symbols' })
map('n', '<leader>xl', '<CMD>Trouble lsp toggle focus=false<CR>',           { desc = 'LSP references' })

-- ── h = Bookmarks (haunt) ────────────────────────────────────────────
map('n', '<leader>ha', function() require('haunt.api').annotate() end,                              { desc = 'Annotate' })
map('n', '<leader>ht', function() require('haunt.api').toggle_annotation() end,                     { desc = 'Toggle annotation' })
map('n', '<leader>hT', function() require('haunt.api').toggle_all_lines() end,                      { desc = 'Toggle all annotations' })
map('n', '<leader>hd', function() require('haunt.api').delete() end,                                { desc = 'Delete bookmark' })
map('n', '<leader>hC', function() require('haunt.api').clear_all() end,                             { desc = 'Clear all bookmarks' })
map('n', '<leader>hp', function() require('haunt.api').prev() end,                                  { desc = 'Prev bookmark' })
map('n', '<leader>hn', function() require('haunt.api').next() end,                                  { desc = 'Next bookmark' })
map('n', '<leader>hl', function() require('haunt.picker').show() end,                               { desc = 'List bookmarks' })
map('n', '<leader>hq', function() require('haunt.api').to_quickfix() end,                           { desc = 'Send to QF (buffer)' })
map('n', '<leader>hQ', function() require('haunt.api').to_quickfix({ current_buffer = true }) end,  { desc = 'Send to QF (all)' })
map('n', '<leader>hy', function() require('haunt.api').yank_locations({ current_buffer = true }) end, { desc = 'Yank locations (buffer)' })
map('n', '<leader>hY', function() require('haunt.api').yank_locations() end,                        { desc = 'Yank locations (all)' })

-- ── i = Insert / Icons ───────────────────────────────────────────────
map('n', '<leader>in', '<CMD>Nerdy list<CR>',    { desc = 'Browse nerd icons' })
map('n', '<leader>iN', '<CMD>Nerdy recents<CR>', { desc = 'Recent nerd icons' })

-- ── p = Paste / Yank ─────────────────────────────────────────────────
map({ 'n', 'x' }, 'y',          '<Plug>(YankyYank)',         { desc = 'Yank' })
map({ 'n', 'x' }, 'p',          '<Plug>(YankyPutAfter)',     { desc = 'Paste after' })
map({ 'n', 'x' }, 'P',          '<Plug>(YankyPutBefore)',    { desc = 'Paste before' })
map({ 'n', 'x' }, 'gp',         '<Plug>(YankyGPutAfter)',    { desc = 'Paste after (move cursor)' })
map({ 'n', 'x' }, 'gP',         '<Plug>(YankyGPutBefore)',   { desc = 'Paste before (move cursor)' })
map({ 'n', 'x' }, '<leader>p',  '<CMD>YankyRingHistory<CR>', { desc = 'Yank history' })

-- ── u = Undo ─────────────────────────────────────────────────────────
map('n', '<leader>u', function() require('undotree').toggle() end, { desc = 'Undo tree' })

-- ── 9 = AI (99 plugin) ───────────────────────────────────────────────
map('v', '<leader>9v', function() require('99').visual();  vim.cmd('startinsert') end, { desc = 'AI visual prompt' })
map('n', '<leader>9s', function() require('99').search();  vim.cmd('startinsert') end, { desc = 'AI search prompt' })
map('n', '<leader>9x', function() require('99').stop_all_requests() end,               { desc = 'AI cancel' })
map('n', '<leader>9l', function() require('99').view_logs() end,                       { desc = 'AI view logs' })

-- ── a / e / 1-4 = Harpoon ────────────────────────────────────────────
map('n', '<leader>a', function() require('harpoon'):list():add() end,                                      { desc = 'Harpoon add' })
map('n', '<leader>e', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,   { desc = 'Harpoon menu' })
map('n', '<leader>1', function() require('harpoon'):list():select(1) end, { desc = 'Harpoon file 1' })
map('n', '<leader>2', function() require('harpoon'):list():select(2) end, { desc = 'Harpoon file 2' })
map('n', '<leader>3', function() require('harpoon'):list():select(3) end, { desc = 'Harpoon file 3' })
map('n', '<leader>4', function() require('harpoon'):list():select(4) end, { desc = 'Harpoon file 4' })

-- ── o = Overseer (Task Runner) ───────────────────────────────────────
map('n', '<leader>or', '<CMD>OverseerRun<CR>',    { desc = 'Run task' })
map('n', '<leader>ot', '<CMD>OverseerToggle<CR>', { desc = 'Toggle output' })
map('n', '<leader>oo', '<CMD>OverseerOpen<CR>',   { desc = 'Open panel' })
map('n', '<leader>ox', '<CMD>OverseerClose<CR>',  { desc = 'Close panel' })
map('n', '<leader>os', '<CMD>OverseerShell<CR>',  { desc = 'Shell task' })
map('n', '<leader>oa', '<CMD>OverseerTaskAction<CR>', { desc = 'Task action' })
