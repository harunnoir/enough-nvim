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
    {
        dir = '~/wrk/nvim-plugins/grv.nvim/',
        config = function()
            vim.o.background = 'dark'
            vim.cmd.colorscheme('grv')
        end,
    },
    { 'maxmx03/solarized.nvim' },
    { 'thallada/farout.nvim' },
    {
        'ember-theme/nvim',
        name = 'ember',
    },
}
