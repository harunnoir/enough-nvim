return {
    {
        'ThePrimeagen/99',
        keys = {
            {
                '<leader>9v',
                function()
                    require('99').visual()
                    vim.cmd('startinsert')
                end,
                mode = 'v',
                desc = '99 visual prompt',
            },
            {
                '<leader>9s',
                function()
                    require('99').search()
                    vim.cmd('startinsert')
                end,
                desc = '99 search prompt',
            },
            {
                '<leader>9x',
                function()
                    require('99').stop_all_requests()
                end,
                desc = '99 cancel',
            },
            {
                '<leader>9m',
                function()
                    require('99.extensions.telescope').select_model()
                end,
                desc = '99 select model',
            },
            {
                '<leader>9l',
                function()
                    require('99').view_logs()
                end,
                desc = '99 view logs',
            },
        },
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
        end,
    },
}
