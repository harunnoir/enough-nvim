return {
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        lazy = true,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },

        config = function()
            require('nvim-treesitter-textobjects').setup({
                select = {
                    -- Jump forward when the cursor is just before an object.
                    lookahead = true,

                    -- Large code objects should be selected linewise.
                    selection_modes = {
                        ['@block.outer'] = 'V',
                        ['@block.inner'] = 'V',

                        ['@function.outer'] = 'V',
                        ['@function.inner'] = 'V',

                        ['@class.outer'] = 'V',
                        ['@class.inner'] = 'V',

                        ['@conditional.outer'] = 'V',
                        ['@conditional.inner'] = 'V',

                        ['@loop.outer'] = 'V',
                        ['@loop.inner'] = 'V',

                        ['@parameter.outer'] = 'v',
                        ['@parameter.inner'] = 'v',

                        ['@call.outer'] = 'v',
                        ['@call.inner'] = 'v',
                    },

                    include_surrounding_whitespace = false,
                },

                move = {
                    -- Add movements to Neovim's jump list.
                    set_jumps = true,
                },
            })
        end,
    },
}
