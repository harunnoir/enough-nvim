return {
    -- Smart indent
    {
        'nemanjamalesija/smart-paste.nvim',
        event = 'VeryLazy',
        config = true,
    },
    -- Conform: format on demand
    {
        'stevearc/conform.nvim',
        event = 'VeryLazy',
        keys = {
            {
                '<leader>cf',
                function() require('conform').format({ async = true }) end,
                mode = { 'n', 'v' },
                desc = 'Format',
            },
        },
        config = function()
            require('conform').setup({
                formatters = {
                    c_formatter_42 = {
                        command = 'c_formatter_42',
                        args = { '$FILENAME' },
                        stdin = false,
                    },
                    bean_format = {
                        command = 'bean-format',
                        stdin = true,
                    },
                },
                formatters_by_ft = {
                    lua = { 'stylua' },
                    python = { 'ruff_format' },
                    sh = { 'shfmt' },
                    c = { 'c_formatter_42' },
                    beancount = { 'bean-format' },
                    markdown = { 'prettier' },
                },
            })
        end,
    },
    -- Autopairs: auto-close brackets, quotes
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
    -- Grug-far: project-wide search & replace
    {
        'MagicDuck/grug-far.nvim',
        cmd = 'GrugFar',
        config = function() require('grug-far').setup({}) end,
    },
    -- Trouble: diagnostic / symbol / reference list
    {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        keys = {
            { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer diagnostics',
            },
            { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols' },
            { '<leader>xl', '<cmd>Trouble lsp toggle focus=false<cr>', desc = 'LSP references' },
        },
        opts = {},
    },
    -- Vim-repeat: make . repeat plugin actions
    { 'tpope/vim-repeat', event = 'VeryLazy' },
    -- Treesj: split/join blocks (function args, if/else, tables)
    {
        'Wansmer/treesj',
        keys = { { '<leader>sj', function() require('treesj').toggle() end, desc = 'Toggle split/join' } },
        cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
        opts = { use_default_keymaps = false },
    },
    -- Dial: increment / decrement numbers, dates, hex colors
    {
        'monaqa/dial.nvim',
        keys = {
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
        config = function()
            local augend = require('dial.augend')
            require('dial.config').augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.date.alias['%Y-%m-%d'],
                    augend.date.alias['%H:%M'],
                    augend.hexcolor.new({ case = 'lower' }),
                    augend.constant.alias.bool,
                    augend.semver.alias.semver,
                },
            })
        end,
    },
}
