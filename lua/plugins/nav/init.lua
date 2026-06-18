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
        'dnlhc/glance.nvim',
        cmd = 'Glance',
    },
    {
        'stevearc/oil.nvim',
        opts = {
            columns = {
                'icon',
                'permissions',
                'size',
                'mtime',
            },
        },
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
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            {
                '<leader>a',
                function()
                    require('harpoon'):list():add()
                end,
                desc = 'Harpoon add file',
            },
            {
                '<leader>e',
                function()
                    require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
                end,
                desc = 'Harpoon toggle menu',
            },
            {
                '<leader>1',
                function()
                    require('harpoon'):list():select(1)
                end,
                desc = 'Harpoon file 1',
            },
            {
                '<leader>2',
                function()
                    require('harpoon'):list():select(2)
                end,
                desc = 'Harpoon file 2',
            },
            {
                '<leader>3',
                function()
                    require('harpoon'):list():select(3)
                end,
                desc = 'Harpoon file 3',
            },
            {
                '<leader>4',
                function()
                    require('harpoon'):list():select(4)
                end,
                desc = 'Harpoon file 4',
            },
        },
        config = function()
            require('harpoon').setup()
        end,
    },
}
