return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
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
        opts = {
            git_cmd = 'git',
            symbols = {
                merge_commit = "●",
                commit = "●",

                merge_commit_end = "●",
                commit_end = "●",

                GVER = "│",
                GHOR = "─",

                GCLD = "│",
                GCRD = "│",
                GCLU = "│",
                GCRU = "│",

                GLRU = "├",
                GLRD = "├",
                GLUD = "│",
                GRUD = "│",

                GFORKU = "●",
                GFORKD = "●",
            },
            --[[ symbols = {
                merge_commit = '',
                commit = '',
                merge_commit_end = '',
                commit_end = '',
                GVER = '',
                GHOR = '',
                GCLD = '',
                GCRD = '╭',
                GCLU = '',
                GCRU = '',
                GLRU = '',
                GLRD = '',
                GLUD = '',
                GRUD = '',
                GFORKU = '',
                GFORKD = '',
                GRUDCD = '',
                GRUDCU = '',
                GLUDCD = '',
                GLUDCU = '',
                GLRDCL = '',
                GLRDCR = '',
                GLRUCL = '',
                GLRUCR = '',
            }, ]]
            format = {
                timestamp = '%H:%M:%S %d-%m-%Y',
                fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
            },
            hooks = {
                on_select_commit = function(commit)
                    vim.notify('selected commit: ' .. commit.hash, vim.log.levels.INFO)
                end,
                on_select_range_commit = function(from, to)
                    vim.notify('selected range: ' .. from.hash .. ' - ' .. to.hash, vim.log.levels.INFO)
                end,
            },
        },
        keys = {
            {
                '<leader>gl',
                function()
                    require('gitgraph').draw({}, { all = true, max_count = 5000 })
                end,
                desc = 'GitGraph - Draw',
            },
        },
    },
    {
        'SuperBo/fugit2.nvim',
        build = false,
        opts = { width = 100 },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
            {
                'chrisgrieser/nvim-tinygit',
                dependencies = { 'stevearc/dressing.nvim' },
            },
        },
        cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph', 'Fugit2Rebase' },
        keys = {
            { '<leader>F', mode = 'n', '<cmd>Fugit2<cr>' },
        },
    },
}
