return {
    signs = {
        { '[h', function() require('gitsigns').prev_hunk() end, desc = 'Previous hunk' },
        { ']h', function() require('gitsigns').next_hunk() end, desc = 'Next hunk' },
        { '<leader>Gb', function() require('gitsigns').blame_line() end, desc = 'Blame line' },
        { '<leader>Gh', function() require('gitsigns').preview_hunk() end, desc = 'Preview hunk' },
        { '<leader>Gs', function() require('gitsigns').stage_hunk() end, desc = 'Stage hunk' },
        { '<leader>Gu', function() require('gitsigns').undo_stage_hunk() end, desc = 'Unstage hunk' },
    },
    graph = {
        {
            '<leader>Gl',
            function() require('gitgraph').draw({}, { all = true, max_count = 5000 }) end,
            desc = 'Git graph',
        },
    },
    snacks = {
        { '<leader>Gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
        { '<leader>GB', function() Snacks.gitbrowse() end, desc = 'Git browse' },
    },
}
