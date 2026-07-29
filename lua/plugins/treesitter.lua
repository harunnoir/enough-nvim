local keys = {}

local function select(lhs, capture, desc)
    table.insert(keys, {
        lhs,
        function() require('nvim-treesitter-textobjects.select').select_textobject(capture, 'textobjects') end,
        mode = { 'x', 'o' },
        desc = desc,
    })
end

local function move(lhs, method, capture, desc)
    table.insert(keys, {
        lhs,
        function() require('nvim-treesitter-textobjects.move')[method](capture, 'textobjects') end,
        mode = { 'n', 'x', 'o' },
        desc = desc,
    })
end

select('ai', '@block.outer', 'Around code block')
select('ii', '@block.inner', 'Inside code block')
select('af', '@function.outer', 'Around function')
select('if', '@function.inner', 'Inside function')
select('ac', '@class.outer', 'Around class')
select('ic', '@class.inner', 'Inside class')
select('aC', '@conditional.outer', 'Around conditional')
select('iC', '@conditional.inner', 'Inside conditional')
select('al', '@loop.outer', 'Around loop')
select('il', '@loop.inner', 'Inside loop')
select('aa', '@parameter.outer', 'Around argument')
select('ia', '@parameter.inner', 'Inside argument')
select('aF', '@call.outer', 'Around function call')
select('iF', '@call.inner', 'Inside function call')

move(']f', 'goto_next_start', '@function.outer', 'Next function start')
move('[f', 'goto_previous_start', '@function.outer', 'Previous function start')
move(']F', 'goto_next_end', '@function.outer', 'Next function end')
move('[F', 'goto_previous_end', '@function.outer', 'Previous function end')
move(']C', 'goto_next_start', '@class.outer', 'Next class')
move('[C', 'goto_previous_start', '@class.outer', 'Previous class')

return {
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        lazy = true,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        keys = vim.list_extend(keys, {
            {
                '<leader>an',
                function() require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner') end,
                desc = 'Swap with next argument',
            },
            {
                '<leader>ap',
                function() require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner') end,
                desc = 'Swap with previous argument',
            },
        }),
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
