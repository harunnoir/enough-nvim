return {
    {
        'saghen/blink.cmp',
        version = '1.*',
        lazy = true,
        event = 'InsertEnter',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'archie-judd/blink-cmp-words',
        },
        opts = {
            keymap = { preset = 'default' },
            completion = {
                ghost_text = { enabled = true },
                menu = {
                    border = 'rounded',
                    draw = {
                        columns = {
                            { 'kind_icon', 'kind', gap = 2 },
                            { 'label', 'label_description' },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    window = { border = 'rounded' },
                },
            },
            signature = {
                enabled = true,
                window = { border = 'rounded' },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    thesaurus = {
                        name = 'blink-cmp-words',
                        module = 'blink-cmp-words.thesaurus',
                        opts = {
                            score_offset = 0,
                            definition_pointers = { '!', '&', '^' },
                            similarity_pointers = { '&', '^' },
                            similarity_depth = 2,
                        },
                    },
                    dictionary = {
                        name = 'blink-cmp-words',
                        module = 'blink-cmp-words.dictionary',
                        opts = {
                            dictionary_search_threshold = 3,
                            score_offset = 0,
                            definition_pointers = { '!', '&', '^' },
                        },
                    },
                },
                per_filetype = {
                    text = { 'lsp', 'path', 'snippets', 'buffer', 'dictionary' },
                    markdown = { 'lsp', 'path', 'snippets', 'buffer', 'thesaurus' },
                },
            },
        },
    },
    {
        'stevearc/conform.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('conform').setup({

                formatters = {
                    c_formatter_42 = {
                        command = 'c_formatter_42',
                        args = { '$FILENAME' },
                        stdin = false,
                    },

                    bean_format = {
                        command = 'bean-format',
                        stdin = true,
                    },
                },

                formatters_by_ft = {
                    lua = { 'stylua' },
                    python = { 'ruff_format' },
                    sh = { 'shfmt' },
                    c = { 'c_formatter_42' },
                    beancount = { 'bean-format' },
                    markdown = { 'prettier' },
                },
            })
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
    {
        'echasnovski/mini.surround',
        opts = {
            mappings = {
                add = 'gsa',
                delete = 'gsd',
                find = 'gsf',
                find_left = 'gsF',
                highlight = 'gsh',
                replace = 'gsr',
                update_n_lines = 'gsn',
            },
        },
    },
    {
        'MagicDuck/grug-far.nvim',
        cmd = 'GrugFar',
        config = function()
            require('grug-far').setup({})
        end,
    },
    {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        opts = {},
    },
    {
        'numToStr/Comment.nvim',
        event = 'BufEnter',
        config = true,
    },
    { 'tpope/vim-repeat', event = 'VeryLazy' },
    {
        'monaqa/dial.nvim',
        keys = {
            {
                '<C-a>',
                function()
                    return require('dial.map').inc_normal()
                end,
                expr = true,
                desc = 'Increment',
            },
            {
                '<C-x>',
                function()
                    return require('dial.map').dec_normal()
                end,
                expr = true,
                desc = 'Decrement',
            },
        },
        config = function()
            local augend = require('dial.augend')
            require('dial.config').augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.date.alias['%Y-%m-%d'],
                    augend.date.alias['%H:%M'],
                    augend.hexcolor.new({ case = 'lower' }),
                    augend.constant.alias.bool,
                    augend.semver.alias.semver,
                },
            })
        end,
    },
    --[[ {
        dir = '~/dev/nvim-plugins/scratchpad.nvim', -- local plugin
        -- or
        -- "yourusername/scratchpad.nvim",  -- if published
        config = function()
            require('scratchpad').setup()
        end,
        keys = {
            {
                '<leader>st',
                function()
                    require('scratchpad').open()
                end,
                desc = 'Scratch file',
            },
        },
    }, ]]
}
