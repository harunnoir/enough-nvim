return {
    {
        'stevearc/conform.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    lua = { 'stylua' },
                    python = { 'ruff_format' },
                    sh = { 'shfmt' },
                    c = { 'c_formatter_42' },
                },
            })
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
        },
        opts = {
            defaults = {
                selection_caret = ' ',
                sorting_strategy = 'ascending',
                layout_config = {
                    prompt_position = 'top',
                },
                prompt_prefix = '   ',
                mappings = { i = { ['<C-j>'] = 'move_selection_next', ['<C-k>'] = 'move_selection_previous' } },
            },
        },
    },
    {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        opts = {},
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        'nvim-mini/mini.surround',
        version = '*',
        config = function()
            require('mini.surround').setup()
        end,
    },
    {
        'MagicDuck/grug-far.nvim',
        -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
        -- additional lazy config to defer loading is not really needed...
        config = function()
            -- optional setup call to override plugin options
            -- alternatively you can set options with vim.g.grug_far = { ... }
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
            })
        end,
    },
    --[[ {
        'kylechui/nvim-surround',
        version = '^4.0.0', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
        -- config = function()
        --     require("nvim-surround").setup({
        --         -- Put your configuration here
        --     })
        -- end
    }, ]]
}
