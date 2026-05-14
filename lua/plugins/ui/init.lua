return {
    { import = 'plugins.ui.colorscheme' },
    { import = 'plugins.ui.lualine' },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            notifier = { enabled = true },
            picker = { expand = true },
            animate = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            dashboard = { enabled = false },
            bigfile = { enabled = true },
            scroll = { enabled = true },
            words = { enabled = true },
            dim = { enabled = true },
            scratch = { enabled = true },
            bufdelete = { enabled = true },
            statuscolumn = {
                enabled = true,
                left = { 'git', 'sign', 'mark' },
                right = { 'fold' },
                folds = { open = true, git_hl = true },
                git = { patterns = { 'GitSign', 'MiniDiffSign' } },
                refresh = 50,
            },
        },
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            presets = {
                bottom_search = false,
                command_palette = false,
                long_message_to_split = false,
                inc_rename = false,
                lsp_doc_border = false,
            },
            cmdline = {
                format = {
                    cmdline = { pattern = '^:', icon = ' ', lang = 'vim' },
                    search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
                    search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
                    filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
                    lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
                    help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
                    input = { view = 'cmdline_input', icon = '󰥻 ' },
                },
            },
            views = {
                cmdline_popup = {
                    position = { row = 0, col = '50%' },
                    size = { width = '40%', height = 'auto' },
                    border = { style = 'none', padding = { 0, 1 } },
                    win_options = { winhighlight = 'Normal:NormalFloat,FloatBorder:NormalFloat' },
                },
                popupmenu = {
                    relative = 'editor',
                    position = { row = 1, col = '50%' },
                    size = { width = '40%', height = 10 },
                    border = { style = 'none', padding = { 0, 1 } },
                },
            },
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { 'amansingh-afk/milli.nvim' },
        opts = function()
            local splash = require('milli').load({ splash = 'finger' })
            return {
                theme = 'doom',
                config = {
                    header = splash.frames[1],
                    center = {
                        { icon = '  ', desc = 'Find File', key = 'f', action = 'Telescope find_files' },
                        { icon = '  ', desc = 'Quit', key = 'q', action = 'qa' },
                    },
                },
            }
        end,
        config = function(_, opts)
            require('dashboard').setup(opts)
            require('milli').dashboard({ splash = 'finger', loop = true })
        end,
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {},
        keys = {
            {
                '<leader>?',
                function()
                    require('which-key').show { global = false }
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
    },
    {
        'gbprod/yanky.nvim',
        opts = {},
    },
    {
        'lukas-reineke/virt-column.nvim',
        opts = {
            char = '│',
            highlight = 'VirtColumn',
        },
    },
    {
        'stevearc/quicker.nvim',
        ft = 'qf',
        opts = {},
    },
    { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },
    { 'kungfusheep/mfd.nvim' },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        opts = {
            default = true,
            color_icons = false,
        },
    },
}
