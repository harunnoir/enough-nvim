local maps = require('maps.extras')

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
        keys = maps.tasks,
        ---@module 'overseer'
        ---@type overseer.SetupOpts
        opts = {},
    },
    {
        'TheNoeTrevino/haunt.nvim',
        keys = maps.bookmarks,
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
        keys = maps.icons,
        opts = {
            max_recents = 30,
            copy_to_clipboard = false,
            copy_register = '+',
        },
    },

    {
        'jiaoshijie/undotree',
        keys = maps.undo,
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
