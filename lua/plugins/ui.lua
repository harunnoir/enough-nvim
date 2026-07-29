local theme = 'limei' -- 'solarized' | 'gruvbox-material' | 'gruvbox' | 'gruvbox-new' | 'zen' | 'vague' | 'miasma' | 'kanagawa' | 'farout'

return {
    {
        'harunnoir/limei.nvim',
        lazy = (theme ~= 'limei'),
        priority = 1000,
        config = function()
            require('limei').setup({
                matching = {
                    brackets = true,
                    quotes = true,
                },
            })
            vim.cmd.colorscheme('limei')
        end,
    },
    {
        'maxmx03/solarized.nvim',
        lazy = (theme ~= 'solarized'),
        priority = 1000,
        opts = {},
        config = function(_, opts)
            vim.o.termguicolors = true
            vim.o.background = 'light'
            require('solarized').setup(opts)
            vim.cmd.colorscheme('solarized')
        end,
    },
    {
        'sainnhe/gruvbox-material',
        lazy = (theme ~= 'gruvbox-material'),
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            vim.g.gruvbox_material_background = 'medium'
            vim.cmd.colorscheme('gruvbox-material')
        end,
    },
    {
        'ellisonleao/gruvbox.nvim',
        name = 'gruvbox-ellison',
        lazy = (theme ~= 'gruvbox'),
        priority = 1000,
        opts = {},
        config = function(_, opts)
            require('gruvbox').setup(opts)
            vim.cmd.colorscheme('gruvbox')
        end,
    },
    {
        'https://gitlab.com/motaz-shokry/gruvbox.nvim',
        name = 'gruvbox-motaz',
        lazy = (theme ~= 'gruvbox-new'),
        priority = 1000,
        config = function() vim.cmd.colorscheme('gruvbox') end,
    },
    {
        'nendix/zen.nvim',
        lazy = (theme ~= 'zen'),
        priority = 1000,
        config = function() vim.cmd.colorscheme('zen') end,
    },
    {
        'vague-theme/vague.nvim',
        lazy = (theme ~= 'vague'),
        priority = 1000,
        config = function() vim.cmd.colorscheme('vague') end,
    },
    {
        'xero/miasma.nvim',
        lazy = (theme ~= 'miasma'),
        priority = 1000,
        config = function() vim.cmd('colorscheme miasma') end,
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = (theme ~= 'kanagawa'),
        priority = 1000,
        config = function() vim.cmd.colorscheme('kanagawa-dragon') end,
    },
    {
        'thallada/farout.nvim',
        lazy = (theme ~= 'farout'),
        priority = 1000,
        config = function() vim.cmd.colorscheme('farout') end,
    },
    {
        'sschleemilch/slimline.nvim',
        opts = {
            style = 'fg',
            components = {
                left = { 'mode', 'path', 'git' },
                center = {
                    function()
                        local rec = vim.fn.reg_recording()
                        return rec ~= '' and 'recording @' .. rec or ''
                    end,
                    function() return vim.t.maximized and ' 󰊓 ' or '' end,
                },
                right = {
                    'diagnostics',
                    function()
                        local buf = vim.api.nvim_get_current_buf()
                        local formatters = require('conform').list_formatters(buf)
                        if #formatters == 0 then
                            return ''
                        end
                        return ' ' .. formatters[1].name
                    end,
                    'filetype_lsp',
                },
            },
            hl = {
                base = 'StatusLine',
                base_inactive = 'StatusLineNC',
                primary = 'StatusLine',
                secondary = 'StatusLineNC',
            },
            configs = {
                progress = {
                    follow = false,
                },
            },
            spaces = {
                components = '',
                left = '',
                right = '',
            },
            disabled_filetypes = { 'snacks_dashboard', 'snacks_terminal', 'oil', 'ministarter' },
        },
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = function()
            return {
                bigfile = { enabled = true },
                bufdelete = { enabled = true },
                git = { enabled = true },
                gitbrowse = { enabled = true },
                lazygit = { enabled = true },
                quickfile = { enabled = true },
                scope = { enabled = true },
                indent = { enabled = true },
                input = { enabled = true },
                words = { enabled = true },
                picker = {
                    enabled = true,
                    prompt = '   ',
                    layout = {
                        cycle = true,
                        preset = 'ivy',
                    },
                    icons = {
                        ui = {
                            selected = '󱞩 ',
                        },
                    },
                    win = {
                        list = { border = 'rounded' },
                        preview = { border = 'rounded' },
                    },
                },
                notifier = { enabled = false },
                animate = { enabled = true },
                scroll = { enabled = true },
                dim = { enabled = false },
                scratch = { enabled = false },
                image = { enabled = false },
                terminal = {
                    enabled = true,
                    win = {
                        position = 'right',
                        width = 60,
                    },
                },
                statuscolumn = {
                    enabled = true,
                    refresh = 50,
                    left = { 'sign', 'mark', 'git' },
                    right = { 'fold' },
                    folds = { open = true, git_hl = true },
                    git = { patterns = { 'GitSign', 'MiniDiffSign' } },
                },
            }
        end,
        config = function(_, opts) require('snacks').setup(opts) end,
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
                    cmdline = {
                        pattern = '^:',
                        icon = ' ',
                        lang = 'vim',
                    },
                    search_down = {
                        kind = 'search',
                        pattern = '^/',
                        icon = ' ',
                        lang = 'regex',
                    },
                    search_up = {
                        kind = 'search',
                        pattern = '^%?',
                        icon = ' ',
                        lang = 'regex',
                    },
                    filter = {
                        pattern = '^:%s*!',
                        icon = '$',
                        lang = 'bash',
                    },
                    lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
                    help = { pattern = '^:%s*he?l?p?%s+', icon = '󰋖' },
                    input = { view = 'cmdline_input', icon = '󰥻 ' },
                },
            },
            views = {
                cmdline_popup = {
                    position = { row = 0, col = '50%' },
                    size = { width = '40%', height = 'auto' },
                    border = { style = 'rounded' },
                    win_options = { winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder' },
                },
                popupmenu = {
                    relative = 'editor',
                    position = { row = 2, col = '50%' },
                    size = { width = '40%', height = 10 },
                    border = { style = 'rounded' },
                },
            },
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
    },
    {
        'gbprod/yanky.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'lukas-reineke/virt-column.nvim',
        event = 'VeryLazy',
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
    { 'folke/todo-comments.nvim', event = 'VeryLazy', dependencies = { 'nvim-lua/plenary.nvim' }, config = true },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        opts = {
            default = true,
        },
    },
    {
        'hat0uma/csvview.nvim',
        opts = {
            parser = { comments = { '#', '//' } },
            keymaps = {
                textobject_field_inner = { 'if', mode = { 'o', 'x' } },
                textobject_field_outer = { 'af', mode = { 'o', 'x' } },
                jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
                jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
                jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
                jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
            },
        },
        cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
    },
}
