return {
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				'<leader>?',
				function()
					require('which-key').show { global = false }
				end,
				desc = 'Buffer Local Keymaps (which-key)',
			},
		},
	},
	{
		'm4xshen/hardtime.nvim',
		lazy = false,
		dependencies = { 'MunifTanjim/nui.nvim' },
		opts = {},
	},
}
