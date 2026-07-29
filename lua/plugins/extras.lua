return {
    -- Task runner inside Neovim. Run make/scripts, see output in splits.
    {
        'stevearc/overseer.nvim',
        cmd = {
            'OverseerRun',
            'OverseerToggle',
            'OverseerOpen',
            'OverseerClose',
            'OverseerShell',
            'OverseerTaskAction',
        },
        keys = {
            { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run task' },
            { '<leader>ot', '<cmd>OverseerToggle<cr>', desc = 'Toggle task output' },
            { '<leader>oo', '<cmd>OverseerOpen<cr>', desc = 'Open task panel' },
            { '<leader>ox', '<cmd>OverseerClose<cr>', desc = 'Close task panel' },
            { '<leader>os', '<cmd>OverseerShell<cr>', desc = 'Shell task' },
            { '<leader>oa', '<cmd>OverseerTaskAction<cr>', desc = 'Task action' },
        },
        ---@module 'overseer'
        ---@type overseer.SetupOpts
        opts = {},
    },
    {
        'TheNoeTrevino/haunt.nvim',
        keys = {
            { '<leader>ha', function() require('haunt.api').annotate() end, desc = 'Annotate' },
            { '<leader>ht', function() require('haunt.api').toggle_annotation() end, desc = 'Toggle annotation' },
            { '<leader>hT', function() require('haunt.api').toggle_all_lines() end, desc = 'Toggle all annotations' },
            { '<leader>hd', function() require('haunt.api').delete() end, desc = 'Delete bookmark' },
            { '<leader>hC', function() require('haunt.api').clear_all() end, desc = 'Clear all bookmarks' },
            { '<leader>hp', function() require('haunt.api').prev() end, desc = 'Previous bookmark' },
            { '<leader>hn', function() require('haunt.api').next() end, desc = 'Next bookmark' },
            { '<leader>hl', function() require('haunt.picker').show() end, desc = 'List bookmarks' },
            { '<leader>hq', function() require('haunt.api').to_quickfix() end, desc = 'Bookmarks to quickfix' },
            {
                '<leader>hQ',
                function() require('haunt.api').to_quickfix({ current_buffer = true }) end,
                desc = 'Buffer bookmarks to quickfix',
            },
            {
                '<leader>hy',
                function() require('haunt.api').yank_locations({ current_buffer = true }) end,
                desc = 'Yank buffer bookmark locations',
            },
            { '<leader>hY', function() require('haunt.api').yank_locations() end, desc = 'Yank bookmark locations' },
        },
        opts = {
            sign = '󱙝',
            sign_hl = 'HauntAnnotation',
            virt_text_hl = 'HauntAnnotation',
            annotation_prefix = ' 󰆉 ',
            annotation_suffix = '',
            line_hl = nil,
            virt_text_pos = 'eol',
            data_dir = nil,
            per_branch_bookmarks = true,
            picker = 'auto',
            picker_keys = {
                delete = { key = 'd', mode = { 'n' } },
                edit_annotation = { key = 'a', mode = { 'n' } },
            },
        },
        config = function(_, opts) require('haunt').setup(opts) end,
    },

    -- Hardtime: discourage bad movement habits
    {
        'm4xshen/hardtime.nvim',
        event = 'VeryLazy',
        dependencies = { 'MunifTanjim/nui.nvim' },
        opts = {},
    },

    {
        '2kabhishek/nerdy.nvim',
        dependencies = { 'folke/snacks.nvim' },
        cmd = 'Nerdy',
        keys = {
            { '<leader>in', '<cmd>Nerdy list<cr>', desc = 'Browse Nerd Font icons' },
            { '<leader>iN', '<cmd>Nerdy recents<cr>', desc = 'Recent Nerd Font icons' },
        },
        opts = {
            max_recents = 30,
            copy_to_clipboard = false,
            copy_register = '+',
        },
    },

    {
        'jiaoshijie/undotree',
        keys = { { '<leader>u', function() require('undotree').toggle() end, desc = 'Undo tree' } },
        opts = {},
    },

    -- Leetcode: practice in Neovim
    {
        'kawre/leetcode.nvim',
        cmd = 'Leet',
        build = ':TSUpdate html',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        opts = {},
    },

    -- Persistence: auto-save / restore sessions
    {
        'folke/persistence.nvim',
        event = 'VeryLazy',
        opts = {},
    },
}
