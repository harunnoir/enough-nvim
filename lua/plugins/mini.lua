return {
    {
        'nvim-mini/mini.nvim',
        version = false,
        lazy = false,
        config = function()
            require('mini.ai').setup()
            require('mini.align').setup()
            require('mini.surround').setup()

            local clue = require('mini.clue')
            clue.setup({
                triggers = {
                    { mode = 'n', keys = '<Leader>' },
                },
                clues = {
                    clue.gen_clues.builtin_completion(),
                    clue.gen_clues.g(),
                    clue.gen_clues.marks(),
                    clue.gen_clues.registers(),
                    clue.gen_clues.windows(),
                    clue.gen_clues.z(),
                },
                window = { delay = 300 },
            })

            local hipatterns = require('mini.hipatterns')
            hipatterns.setup({
                highlighters = { hex_color = hipatterns.gen_highlighter.hex_color() },
            })

            local starter = require('mini.starter')
            starter.setup({
                header = ' nvim ',
                items = {
                    starter.sections.recent_files(10, false),
                    starter.sections.recent_files(10, true),
                    starter.sections.builtin_actions(),
                },
                footer = '',
            })
        end,
    },
}
