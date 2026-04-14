return {
    {
        'stevearc/conform.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('conform').setup({ formatters_by_ft = { lua = { 'stylua' }, python = { 'ruff_format' } } })
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
                selection_caret = '󰁕 ',
                sorting_strategy = 'ascending',
                layout_config = {
                    prompt_position = 'top',
                },
                prompt_prefix = '   ', --   
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
        'echasnovski/mini.pairs',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('mini.pairs').setup()
        end,
    },
    {
        'nvim-mini/mini.surround',
        version = '*',
    },
}
