return {
    --[[ {
        { "catppuccin/nvim", name = "catppuccin" },
        "folke/tokyonight.nvim",
        'thallada/farout.nvim',
        {
            'ember-theme/nvim',
            name = 'ember',
        },
		"xero/miasma.nvim",
		"akinsho/horizon.nvim",
		"ellisonleao/gruvbox.nvim",
		"nyoom-engineering/oxocarbon.nvim",
		"kdheepak/monochrome.nvim",
        "rebelot/kanagawa.nvim",
        'maxmx03/solarized.nvim',
		{ "mcchrish/zenbones.nvim", dependencies = { "rktjmp/lush.nvim" } },
	}, ]]
    'kungfusheep/mfd.nvim',
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
}
