return {
    { import = 'plugins.nav.motion' },
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
                layout_config = { prompt_position = 'top' },
                prompt_prefix = '   ',
                mappings = { i = { ['<C-j>'] = 'move_selection_next', ['<C-k>'] = 'move_selection_previous' } },
            },
        },
    },
    {
        'rmagatti/goto-preview',
        dependencies = { 'rmagatti/logger.nvim' },
        event = 'BufEnter',
        config = true,
    },
    {
        'stevearc/oil.nvim',
        config = function()
            require('oil').setup()
        end,
        keys = { { '-', '<CMD>Oil<CR>' } },
    },
    {
        'JezerM/oil-lsp-diagnostics.nvim',
        event = 'VeryLazy',
        dependencies = { 'stevearc/oil.nvim' },
        opts = {},
    },
    {
        'benomahony/oil-git.nvim',
        event = 'VeryLazy',
        dependencies = { 'stevearc/oil.nvim' },
    },
    {
        'dnlhc/glance.nvim',
        cmd = 'Glance',
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup()

            vim.keymap.set('n', '<leader>a', function()
                harpoon:list():add()
            end)

            vim.keymap.set('n', '<leader>e', function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            vim.keymap.set('n', '<leader>1', function()
                harpoon:list():select(1)
            end)
            vim.keymap.set('n', '<leader>2', function()
                harpoon:list():select(2)
            end)
            vim.keymap.set('n', '<leader>3', function()
                harpoon:list():select(3)
            end)
            vim.keymap.set('n', '<leader>4', function()
                harpoon:list():select(4)
            end)
        end,
    },
}
