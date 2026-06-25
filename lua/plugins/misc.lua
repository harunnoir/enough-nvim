return {
    -- 99: AI chat in Neovim
    {
        'ThePrimeagen/99',
        keys = {
            {
                '<leader>9v',
                function()
                    require('99').visual()
                    vim.cmd('startinsert')
                end,
                mode = 'v',
                desc = '99 visual prompt',
            },
            {
                '<leader>9s',
                function()
                    require('99').search()
                    vim.cmd('startinsert')
                end,
                desc = '99 search prompt',
            },
            {
                '<leader>9x',
                function()
                    require('99').stop_all_requests()
                end,
                desc = '99 cancel',
            },
            {
                '<leader>9m',
                function()
                    require('99.extensions.telescope').select_model()
                end,
                desc = '99 select model',
            },
            {
                '<leader>9l',
                function()
                    require('99').view_logs()
                end,
                desc = '99 view logs',
            },
        },
        config = function()
            local _99 = require('99')
            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
            _99.setup({
                model = 'opencode/big-pickle',
                logger = {
                    level = _99.DEBUG,
                    path = '/tmp/' .. basename .. '.99.debug',
                    print_on_error = true,
                },
                tmp_dir = vim.fn.stdpath('data') .. '/99/tmp',
                completion = {
                    custom_rules = { vim.fn.stdpath('data') .. '/99/custom_rules/' },
                    files = {},
                    source = 'native',
                },
                md_files = { 'AGENT.md' },
            })
        end,
    },
    -- Haunt: bookmark / annotate lines
    {
        'TheNoeTrevino/haunt.nvim',
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
        keys = {
            {
                '<leader>ha',
                function()
                    require('haunt.api').annotate()
                end,
                desc = 'Annotate',
            },
            {
                '<leader>ht',
                function()
                    require('haunt.api').toggle_annotation()
                end,
                desc = 'Toggle annotation',
            },
            {
                '<leader>hT',
                function()
                    require('haunt.api').toggle_all_lines()
                end,
                desc = 'Toggle all annotations',
            },
            {
                '<leader>hd',
                function()
                    require('haunt.api').delete()
                end,
                desc = 'Delete bookmark',
            },
            {
                '<leader>hC',
                function()
                    require('haunt.api').clear_all()
                end,
                desc = 'Delete all bookmarks',
            },
            {
                '<leader>hp',
                function()
                    require('haunt.api').prev()
                end,
                desc = 'Previous bookmark',
            },
            {
                '<leader>hn',
                function()
                    require('haunt.api').next()
                end,
                desc = 'Next bookmark',
            },
            {
                '<leader>hl',
                function()
                    require('haunt.picker').show()
                end,
                desc = 'Show Picker',
            },
            {
                '<leader>hq',
                function()
                    require('haunt.api').to_quickfix()
                end,
                desc = 'Send to QF (buffer)',
            },
            {
                '<leader>hQ',
                function()
                    require('haunt.api').to_quickfix({ current_buffer = true })
                end,
                desc = 'Send to QF (all)',
            },
            {
                '<leader>hy',
                function()
                    require('haunt.api').yank_locations({ current_buffer = true })
                end,
                desc = 'Yank locations (buffer)',
            },
            {
                '<leader>hY',
                function()
                    require('haunt.api').yank_locations()
                end,
                desc = 'Yank locations (all)',
            },
        },
        config = function(_, opts)
            require('haunt').setup(opts)
        end,
    },
    -- Hardtime: discourage bad movement habits
    {
        'm4xshen/hardtime.nvim',
        event = 'VeryLazy',
        dependencies = { 'MunifTanjim/nui.nvim' },
        opts = {},
    },
    -- Mini.hipatterns: highlight hex colors
    {
        'nvim-mini/mini.hipatterns',
        version = '*',
        event = 'VeryLazy',
        config = function()
            local hipatterns = require('mini.hipatterns')
            hipatterns.setup({
                highlighters = {
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },
    -- Render-markdown: WYSIWYG markdown preview
    {
        'MeanderingProgrammer/render-markdown.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
        config = function()
            require('render-markdown').setup({})
        end,
    },
    -- Calcium: in-buffer calculator
    {
        'necrom4/calcium.nvim',
        cmd = { 'Calcium' },
        opts = {},
    },
    -- Nerdy: Nerd Font icon browser
    {
        '2kabhishek/nerdy.nvim',
        dependencies = { 'folke/snacks.nvim' },
        cmd = 'Nerdy',
        opts = {
            max_recents = 30,
            copy_to_clipboard = false,
            copy_register = '+',
        },
        keys = {
            { '<leader>in', ':Nerdy list<CR>', desc = 'Browse nerd icons' },
            { '<leader>iN', ':Nerdy recents<CR>', desc = 'Browse recent nerd icons' },
        },
    },
    -- StartupTime: debug startup performance
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
    },
    -- Typr: typing tutor
    {
        'nvzone/typr',
        dependencies = 'nvzone/volt',
        opts = {},
        cmd = { 'Typr', 'TyprStats' },
    },
    -- Undotree: visual undo tree
    {
        'jiaoshijie/undotree',
        opts = {},
        keys = {
            { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
        },
    },
    -- Dictionary: thesaurus / dictionary lookup
    {
        'chrscchrn/dictionary.nvim',
        cmd = 'Dictionary',
        config = function()
            require('dictionary').setup()
        end,
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
        event = 'BufReadPre',
        opts = {},
    },
    -- Atone: scratch buffer manager
    'XXiaoA/atone.nvim',
    -- Presenting: presentation mode
    {
        'harunnoir/presenting.nvim',
        opts = {},
        cmd = { 'Presenting' },
    },
}
