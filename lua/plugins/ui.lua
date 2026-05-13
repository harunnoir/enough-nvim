return {
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
            statuscolumn = {
                enabled = true,
                left = { 'mark', 'sign', 'git' }, -- priority of signs on the left (high to low)
                right = { 'fold' }, -- priority of signs on the right (high to low)
                folds = {
                    open = true, -- show open fold icons
                    git_hl = false, -- use Git Signs hl for fold icons
                },
                git = {
                    -- patterns to match Git signs
                    patterns = { 'GitSign', 'MiniDiffSign' },
                },
                refresh = 50, -- refresh at most every 50ms
            },
        },
    },
    { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'maxmx03/solarized.nvim' },
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            vim.g.gruvbox_material_background = 'soft'
            vim.cmd.colorscheme('gruvbox-material')
        end,
    },
    {
        'ember-theme/nvim',
        name = 'ember',
    },
    {
        'kungfusheep/mfd.nvim',
    },
    {
        'gbprod/yanky.nvim',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
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
                    win_options = {
                        winhighlight = 'Normal:NormalFloat,FloatBorder:NormalFloat',
                    },
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
        'stevearc/quicker.nvim',
        ft = 'qf',
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {},
    },
    {
        'lukas-reineke/virt-column.nvim',
        opts = {
            char = '│', -- or "▕"  "┊"  "╎"
            highlight = 'VirtColumn',
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
                    header = splash.frames[1], -- seed header with frame 0
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
    -- FIXME: fix this.
    --[[ {
        'shellRaining/hlchunk.nvim',
        event = { 'BufReadPre', 'BufNewFile' },

        config = function()
            require('hlchunk').setup({
                chunk = {
                    enable = true,

                    style = {
                        '#7daea3', -- blue
                    },

                    chars = {
                        horizontal_line = '─',
                        vertical_line = '│',
                        left_top = '╭',
                        left_bottom = '╰',
                        right_arrow = '─',
                    },
                },

                indent = {
                    enable = true,

                    chars = {
                        '│',
                    },

                    style = {
                        '#ea6962', -- red
                        '#e78a4e', -- orange
                        '#d8a657', -- yellow
                        '#a9b665', -- green
                        '#89b482', -- aqua
                        '#7daea3', -- blue
                        '#d3869b', -- purple
                    },
                },

                line_num = {
                    enable = false,
                },

                blank = {
                    enable = false,
                },
            })
        end,
    }, ]]
}
