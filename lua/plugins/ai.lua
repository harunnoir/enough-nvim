return {
    {
        'ThePrimeagen/99',
        lazy = true,
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
                    custom_rules = {
                        'scratch/custom_rules/',
                    },
                    files = {},
                    source = 'native',
                },
                md_files = {
                    'AGENT.md',
                    'AGENTS.md',
                },
            })
        end,
    },
}
