return {
    {
        'mrjones2014/smart-splits.nvim',
        keys = {
            { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = 'Move to left split' },
            { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = 'Move to lower split' },
            { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = 'Move to upper split' },
            { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = 'Move to right split' },
            { '<A-h>', function() require('smart-splits').resize_left() end, desc = 'Resize left' },
            { '<A-j>', function() require('smart-splits').resize_down() end, desc = 'Resize down' },
            { '<A-k>', function() require('smart-splits').resize_up() end, desc = 'Resize up' },
            { '<A-l>', function() require('smart-splits').resize_right() end, desc = 'Resize right' },
            { '<leader><leader>h', function() require('smart-splits').swap_buf_left() end, desc = 'Swap buffer left' },
            { '<leader><leader>j', function() require('smart-splits').swap_buf_down() end, desc = 'Swap buffer down' },
            { '<leader><leader>k', function() require('smart-splits').swap_buf_up() end, desc = 'Swap buffer up' },
            {
                '<leader><leader>l',
                function() require('smart-splits').swap_buf_right() end,
                desc = 'Swap buffer right',
            },
        },
    },

    {
        'chrisgrieser/nvim-spider',
        keys = {
            {
                'w',
                function() require('spider').motion('w') end,
                mode = { 'n', 'o', 'x' },
                desc = 'Spider forward',
            },
            {
                'e',
                function() require('spider').motion('e') end,
                mode = { 'n', 'o', 'x' },
                desc = 'Spider end',
            },
            {
                'b',
                function() require('spider').motion('b') end,
                mode = { 'n', 'o', 'x' },
                desc = 'Spider backward',
            },
            {
                'ge',
                function() require('spider').motion('ge') end,
                mode = { 'n', 'o', 'x' },
                desc = 'Spider previous end',
            },
        },
    },

    -- Toggle one window without changing the split layout.
    {
        'declancm/maximize.nvim',
        cmd = 'Maximize',
        keys = { { '<leader>z', '<cmd>Maximize<cr>', desc = 'Maximize window' } },
        config = true,
    },

    -- Long-range visible jumps.
    {
        'folke/flash.nvim',
        keys = {
            { 'gs', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash jump' },
            {
                'gS',
                function() require('flash').treesitter() end,
                mode = { 'n', 'x', 'o' },
                desc = 'Flash treesitter',
            },
            { 'r', function() require('flash').remote() end, mode = 'o', desc = 'Flash remote' },
            {
                'R',
                function() require('flash').treesitter_search() end,
                mode = { 'o', 'x' },
                desc = 'Flash treesitter search',
            },
            { '<C-s>', function() require('flash').toggle() end, mode = 'c', desc = 'Flash toggle search' },
        },
        opts = {},
    },

    -- Glance: peek LSP definitions / references
    {
        'dnlhc/glance.nvim',
        cmd = 'Glance',
        keys = {
            { 'gD', '<cmd>Glance definitions<cr>', desc = 'Definitions' },
            { 'gR', '<cmd>Glance references<cr>', desc = 'References' },
            { 'gY', '<cmd>Glance type definitions<cr>', desc = 'Type definitions' },
            { 'gM', '<cmd>Glance implementations<cr>', desc = 'Implementations' },
        },
    },

    -- Oil: file explorer as a buffer (key in keymaps.lua)
    {
        'stevearc/oil.nvim',
        lazy = false,
        keys = { { '-', '<cmd>Oil<cr>', desc = 'Open Oil' } },
        opts = {
            columns = { 'icon', 'permissions', 'size', 'mtime' },
        },
    },

    -- Oil plugins: diagnostics and git status in Oil
    {
        'JezerM/oil-lsp-diagnostics.nvim',
        ft = 'oil',
        dependencies = { 'stevearc/oil.nvim' },
        opts = {},
    },
    {
        'benomahony/oil-git.nvim',
        ft = 'oil',
        dependencies = { 'stevearc/oil.nvim' },

        opts = function()
            local function get_hl(group, attr)
                local ok, hl = pcall(vim.api.nvim_get_hl, 0, {
                    name = group,
                    link = false,
                })

                if not ok or type(hl) ~= 'table' then
                    return nil
                end

                local value = hl[attr]

                if type(value) ~= 'number' then
                    return nil
                end

                return string.format('#%06x', value)
            end

            return {
                highlights = {
                    OilGitAdded = {
                        fg = get_hl('DiagnosticOk', 'fg') or '#a9b665',
                    },
                    OilGitModified = {
                        fg = get_hl('DiagnosticWarn', 'fg') or '#d8a657',
                    },
                    OilGitRenamed = {
                        fg = get_hl('Keyword', 'fg') or '#d3869b',
                    },
                    OilGitUntracked = {
                        fg = get_hl('Function', 'fg') or '#7daea3',
                    },
                    OilGitIgnored = {
                        fg = get_hl('Comment', 'fg') or '#928374',
                    },
                },
            }
        end,
    },

    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>a', function() require('harpoon'):list():add() end, desc = 'Harpoon add' },
            {
                '<leader>e',
                function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,
                desc = 'Harpoon menu',
            },
            { '<leader>1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon file 1' },
            { '<leader>2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon file 2' },
            { '<leader>3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon file 3' },
            { '<leader>4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon file 4' },
        },
        config = function() require('harpoon').setup() end,
    },

    -- Marks: visual indicators for marks a-z
    {
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        opts = {},
    },
}
