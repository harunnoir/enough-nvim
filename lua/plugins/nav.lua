return {
    {
        'rmagatti/goto-preview',
        dependencies = { 'rmagatti/logger.nvim' },
        event = 'BufEnter',
        config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    },
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
        'stevearc/oil.nvim',
        lazy = false,
        config = function()
            require('oil').setup()
        end,
        keys = { { '-', '<CMD>Oil<CR>' } },
    },
    {
        'numToStr/Comment.nvim',
        event = 'BufEnter',
        config = true,
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
}
