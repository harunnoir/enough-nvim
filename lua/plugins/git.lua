local maps = require('maps.git')

return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        keys = maps.signs,
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
        keys = maps.graph,
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
