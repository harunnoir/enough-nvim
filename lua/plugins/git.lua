return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        keys = {
            { '[h', function() require('gitsigns').prev_hunk() end, desc = 'Previous hunk' },
            { ']h', function() require('gitsigns').next_hunk() end, desc = 'Next hunk' },
            { '<leader>Gb', function() require('gitsigns').blame_line() end, desc = 'Blame line' },
            { '<leader>Gh', function() require('gitsigns').preview_hunk() end, desc = 'Preview hunk' },
            { '<leader>Gs', function() require('gitsigns').stage_hunk() end, desc = 'Stage hunk' },
            { '<leader>Gu', function() require('gitsigns').undo_stage_hunk() end, desc = 'Unstage hunk' },
        },
        opts = {
            signs = {
                add = { text = '┃' },
                change = { text = '┃' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            },
            signs_staged = {
                add = { text = '┃' },
                change = { text = '┃' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            },
        },
    },

    {
        'isakbm/gitgraph.nvim',
        keys = {
            {
                '<leader>Gl',
                function() require('gitgraph').draw({}, { all = true, max_count = 5000 }) end,
                desc = 'Git graph',
            },
        },
        opts = {
            git_cmd = 'git',
            symbols = {
                merge_commit = '●',
                commit = '●',
                merge_commit_end = '●',
                commit_end = '●',
                GVER = '│',
                GHOR = '─',
                GCLD = '│',
                GCRD = '│',
                GCLU = '│',
                GCRU = '│',
                GLRU = '├',
                GLRD = '├',
                GLUD = '│',
                GRUD = '│',
                GFORKU = '●',
                GFORKD = '●',
            },
            format = {
                timestamp = '%H:%M:%S %d-%m-%Y',
                fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
            },
            hooks = {
                on_select_commit = function(commit) vim.notify('selected commit: ' .. commit.hash, vim.log.levels.INFO) end,
                on_select_range_commit = function(from, to)
                    vim.notify('selected range: ' .. from.hash .. ' - ' .. to.hash, vim.log.levels.INFO)
                end,
            },
        },
    },
}
