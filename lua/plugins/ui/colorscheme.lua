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
    { 'maxmx03/solarized.nvim' },
    {
        'ember-theme/nvim',
        name = 'ember',
    },
}
