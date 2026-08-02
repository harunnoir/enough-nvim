local theme = 'limei'

return {
    -- {
    --     dir = '~/wrk/nvim/limei.nvim-1.3.0/',
    --     name = 'limei.nvim',
    --     lazy = false,
    --     priority = 1000,

    --     config = function() vim.cmd.colorscheme('limei') end,
    -- },
    {
        'Aejkatappaja/cendre',
        lazy = theme ~= 'cendre',
        priority = 1000,
        config = function()
            require('cendre').setup({})
            vim.cmd.colorscheme('cendre')
        end,
    },
    {
        'harunnoir/limei.nvim',
        lazy = theme ~= 'limei',
        priority = 1000,
        config = function()
            require('limei').setup({
                matching = {
                    brackets = true,
                    quotes = true,
                },
            })
            vim.cmd.colorscheme('limei')
        end,
    },
    {
        'maxmx03/solarized.nvim',
        lazy = theme ~= 'solarized',
        priority = 1000,
        opts = {},
        config = function(_, opts)
            vim.o.termguicolors = true
            vim.o.background = 'light'
            require('solarized').setup(opts)
            vim.cmd.colorscheme('solarized')
        end,
    },
    {
        'sainnhe/gruvbox-material',
        lazy = theme ~= 'gruvbox-material',
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            vim.g.gruvbox_material_background = 'medium'
            vim.cmd.colorscheme('gruvbox-material')
        end,
    },
    {
        'ellisonleao/gruvbox.nvim',
        name = 'gruvbox-ellison',
        lazy = theme ~= 'gruvbox',
        priority = 1000,
        opts = {},
        config = function(_, opts)
            require('gruvbox').setup(opts)
            vim.cmd.colorscheme('gruvbox')
        end,
    },
    {
        'https://gitlab.com/motaz-shokry/gruvbox.nvim',
        name = 'gruvbox-motaz',
        lazy = theme ~= 'gruvbox-new',
        priority = 1000,
        config = function() vim.cmd.colorscheme('gruvbox') end,
    },
    {
        'nendix/zen.nvim',
        lazy = theme ~= 'zen',
        priority = 1000,
        config = function() vim.cmd.colorscheme('zen') end,
    },
    {
        'vague-theme/vague.nvim',
        lazy = theme ~= 'vague',
        priority = 1000,
        config = function() vim.cmd.colorscheme('vague') end,
    },
    {
        'xero/miasma.nvim',
        lazy = theme ~= 'miasma',
        priority = 1000,
        config = function() vim.cmd.colorscheme('miasma') end,
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = theme ~= 'kanagawa',
        priority = 1000,
        config = function() vim.cmd.colorscheme('kanagawa-dragon') end,
    },
    {
        'thallada/farout.nvim',
        lazy = theme ~= 'farout',
        priority = 1000,
        config = function() vim.cmd.colorscheme('farout') end,
    },
}
