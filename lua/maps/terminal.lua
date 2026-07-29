return {
    { '<C-\\>', function() require('snacks').terminal() end, desc = 'Toggle terminal' },
    { '<Esc><Esc>', '<C-\\><C-n>', mode = 't', desc = 'Exit terminal mode' },
}
