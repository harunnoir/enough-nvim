local function get_hl(group, attr)
    local ok, val = pcall(vim.api.nvim_get_hl, 0, { name = group })
    return ok and val and string.format('#%06x', val[attr])
end

local function lsp_name()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        return ''
    end
    return '󰒋 '
        .. table.concat(
            vim.tbl_map(function(c)
                return c.name
            end, clients),
            ','
        )
end

local function formatter_name()
    local ok, conform = pcall(require, 'conform')
    local f = ok and conform.list_formatters(0) or {}
    if #f == 0 then
        return ''
    end
    return '󰉿 '
        .. table.concat(
            vim.tbl_map(function(x)
                return x.name
            end, f),
            ','
        )
end

local function linter_name()
    local ok, lint = pcall(require, 'lint')
    local l = ok and (lint.linters_by_ft[vim.bo.filetype] or {}) or {}
    if #l == 0 then
        return ''
    end
    return '󱉶 ' .. table.concat(l, ',')
end

local function setup_lualine()
    local c = {
        fg = get_hl('Normal', 'fg') or '#d4be98',
        bg = get_hl('Normal', 'bg') or '#32302f',
        comment = get_hl('Comment', 'fg') or '#928374',
        green = get_hl('DiagnosticOk', 'fg') or '#a9b665',
        warning = get_hl('DiagnosticWarn', 'fg') or '#d8a657',
        error = get_hl('DiagnosticError', 'fg') or '#ea6962',
        info = get_hl('DiagnosticInfo', 'fg') or '#7daea3',
        cyan = get_hl('Function', 'fg') or '#7daea3',
    }

    require('lualine').setup({
        options = {
            theme = {
                normal = {
                    a = { fg = c.fg, bg = c.bg },
                    b = { fg = c.comment, bg = c.bg },
                    c = { fg = c.fg, bg = c.bg },
                },
                inactive = {
                    a = { fg = c.comment, bg = c.bg },
                    b = { fg = c.comment, bg = c.bg },
                    c = { fg = c.comment, bg = c.bg },
                },
            },
            globalstatus = true,
            component_separators = '',
            section_separators = '',
            disabled_filetypes = { statusline = { 'dashboard', 'oil' } },
        },
        sections = {
            lualine_a = {
                {
                    function()
                        local reg = vim.fn.reg_recording()
                        return reg ~= '' and '  @' .. reg or ''
                    end,
                    color = { fg = c.warning, bg = c.bg },
                },
            },
            lualine_b = { { 'branch', icon = '', color = { fg = c.comment, bg = c.bg } } },
            lualine_c = {
                {
                    'filename',
                    path = 1,
                    color = { fg = c.fg, bg = c.bg },
                    symbols = { modified = ' +', readonly = ' -' },
                },
            },
            lualine_x = {
                { lsp_name, color = { fg = c.cyan, bg = c.bg } },
                { formatter_name, color = { fg = c.comment, bg = c.bg } },
                { linter_name, color = { fg = c.warning, bg = c.bg } },
                {
                    'diagnostics',
                    color = { fg = c.error, bg = c.bg },
                    symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
                },
            },
            lualine_y = {},
            lualine_z = {},
        },
    })
end

return {
    { 'mrjones2014/smart-splits.nvim' },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        keys = {
            { '<C-\\>', '<CMD>ToggleTerm<CR>', desc = 'Toggle terminal' },
        },
        opts = {
            direction = 'horizontal',
            open_mapping = '<C-\\>',
        },
    },
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            vim.g.gruvbox_material_background = 'medium'
            vim.cmd.colorscheme('gruvbox-material')
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = true,
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            setup_lualine()

            vim.api.nvim_create_autocmd('ColorScheme', {
                group = vim.api.nvim_create_augroup('LualineAdaptive', { clear = true }),
                callback = setup_lualine,
            })
        end,
    },
    {
        'folke/snacks.nvim',
        lazy = false,
        opts = {
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
            picker = { enabled = false },
            notifier = { enabled = false },
            dashboard = { enabled = false },
            animate = { enabled = true },
            scroll = { enabled = true },
            dim = { enabled = false },
            scratch = { enabled = false },
            image = { enabled = false },
            statuscolumn = {
                enabled = true,
                refresh = 50,
                left = { 'sign', 'mark', 'git' },
                right = { 'fold' },
                folds = { open = true, git_hl = true },
                git = { patterns = { 'GitSign', 'MiniDiffSign' } },
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
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { 'amansingh-afk/milli.nvim' },
        opts = function()
            local ok, splash = pcall(require('milli').load, { splash = 'batmancatman' })
            local header = ok and splash.frames[1] or {}
            return {
                theme = 'doom',
                config = {
                    header = header,
                    center = {
                        { icon = '  ', desc = 'Find File', key = 'f', action = 'Telescope find_files' },
                        { icon = '  ', desc = 'Quit', key = 'q', action = 'qa' },
                    },
                },
            }
        end,
        config = function(_, opts)
            require('dashboard').setup(opts)
            pcall(require('milli').dashboard, { splash = 'batmancatman', loop = true })
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
                    require('which-key').show({ global = false })
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
            highlight = 'NonText',
        },
    },
    {
        'stevearc/quicker.nvim',
        ft = 'qf',
        opts = {},
    },
    { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },
    { 'kungfusheep/mfd.nvim', event = 'VeryLazy' },
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
