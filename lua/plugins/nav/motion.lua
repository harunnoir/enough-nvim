return {
    {
        'chrisgrieser/nvim-spider',
        keys = {
            { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
            { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
            { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
            { 'ge', "<cmd>lua require('spider').motion('ge')<CR>", mode = { 'n', 'o', 'x' } },
        },
    },
    {
        'amwadud/nvim-maximizer',
        keys = { { '<C-m>', '<cmd>MaximizerToggle<CR>' } },
    },
    {
        'ggandor/leap.nvim',
        lazy = true,
        keys = {
            {
                'f',
                function()
                    require('leap').leap({
                        target_windows = vim.tbl_filter(function(win)
                            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'oil'
                        end, vim.api.nvim_list_wins()),
                    })
                end,
            },
            {
                'F',
                function()
                    require('leap').leap({
                        target_windows = vim.tbl_filter(function(win)
                            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'oil'
                        end, vim.api.nvim_list_wins()),
                        backward = true,
                    })
                end,
            },
        },
    },
    {
        'folke/flash.nvim',
        lazy = true,
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
            },
            {
                'S',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').treesitter()
                end,
            },
        },
    },
    {
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'amwadud/quicksearch.nvim',
        event = 'VeryLazy',
        config = function()
            require('quicksearch').setup()
        end,
    },
    {
        'christoomey/vim-tmux-navigator',
        cmd = {
            'TmuxNavigateLeft', 'TmuxNavigateDown', 'TmuxNavigateUp',
            'TmuxNavigateRight', 'TmuxNavigatePrevious', 'TmuxNavigatorProcessList',
        },
        keys = {
            { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
            { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
            { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
            { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
            { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
        },
    },
}
