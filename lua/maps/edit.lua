return {
    format = {
        {
            '<leader>cf',
            function() require('conform').format({ async = true }) end,
            mode = { 'n', 'v' },
            desc = 'Format',
        },
    },
    trouble = {
        { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
        { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics' },
        { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols' },
        { '<leader>xl', '<cmd>Trouble lsp toggle focus=false<cr>', desc = 'LSP references' },
    },
    split_join = {
        { '<leader>sj', function() require('treesj').toggle() end, desc = 'Toggle split/join' },
    },
    dial = {
        {
            '<C-a>',
            function() return require('dial.map').inc_normal() end,
            expr = true,
            desc = 'Increment',
        },
        {
            '<C-x>',
            function() return require('dial.map').dec_normal() end,
            expr = true,
            desc = 'Decrement',
        },
    },
}
