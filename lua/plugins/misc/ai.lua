return {
    {
        'ThePrimeagen/99',
        config = function()
            local _99 = require('99')
            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)
            _99.setup({
                model = 'opencode/big-pickle',
                logger = {
                    level = _99.DEBUG,
                    path = '/tmp/' .. basename .. '.99.debug',
                    print_on_error = true,
                },
                tmp_dir = './tmp',
                completion = {
                    custom_rules = { 'scratch/custom_rules/' },
                    files = {},
                    source = 'native',
                },
                md_files = { 'AGENT.md' },
            })

            vim.keymap.set('v', '<leader>9v', function()
                _99.visual()
                vim.cmd('startinsert')
            end, { desc = '99 visual prompt' })

            vim.keymap.set('n', '<leader>9s', function()
                _99.search()
                vim.cmd('startinsert')
            end, { desc = '99 search prompt' })

            vim.keymap.set('n', '<leader>9x', function()
                _99.stop_all_requests()
            end, { desc = '99 cancel' })

            vim.keymap.set('n', '<leader>9m', function()
                require('99.extensions.telescope').select_model()
            end, { desc = '99 select model' })

            vim.keymap.set('n', '<leader>9l', function()
                require('99').view_logs()
            end, { desc = '99 view logs' })
        end,
    },
}
