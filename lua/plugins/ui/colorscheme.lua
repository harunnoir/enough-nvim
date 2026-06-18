return {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            vim.g.gruvbox_material_background = 'soft'
            vim.cmd.colorscheme('gruvbox-material')
        end,
    },
    --[[ {
        'harunnoir/grv.nvim',
        lazy = false,
        priority = 2000,
        config = function()
            vim.o.background = 'dark'
            vim.cmd.colorscheme('grv')
        end,
    }, ]]
    { 'maxmx03/solarized.nvim' },
    { 'thallada/farout.nvim' },
    {
        'ember-theme/nvim',
        name = 'ember',
    },
    { "catppuccin/nvim", name = "catppuccin" },
    { "folke/tokyonight.nvim" },
    --[[ {
        dir = '~/gruvbox-material',
        -- or your github repo once pushed
        lazy = false,
        priority = 1000,
        config = function()
            require('catppuccin').setup({ flavour = 'soft' }) -- or mini/origin
            vim.cmd.colorscheme('gruvbox-material-soft')
        end,
    } ]]
}
