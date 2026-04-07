return {
	{
		'stevearc/conform.nvim',
		lazy = true,
		event = 'VeryLazy',
		config = function()
			require('conform').setup { formatters_by_ft = { lua = { 'stylua' }, python = { 'ruff_format' } } }
		end,
	},
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { defaults = { mappings = { i = { ['<C-j>'] = 'move_selection_next', ['<C-k>'] = 'move_selection_previous' } } } },
	},
	{
		'folke/trouble.nvim',
		cmd = 'Trouble',
		opts = {},
	},
	{
		'echasnovski/mini.pairs',
		lazy = true,
		event = 'VeryLazy',
		config = function()
			require('mini.pairs').setup()
		end,
	},
}
