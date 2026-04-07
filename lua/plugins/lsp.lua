return {
	{ 'nvim-lua/plenary.nvim' },
	{ 'neovim/nvim-lspconfig', event = 'VeryLazy' },
	{ 'williamboman/mason.nvim', cmd = 'Mason' },
	{ 'williamboman/mason-lspconfig.nvim', event = 'VeryLazy' },
	{
		'rachartier/tiny-inline-diagnostic.nvim',
		event = 'VeryLazy',
		priority = 1000,
		config = function()
			require('tiny-inline-diagnostic').setup {
				-- Available: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
				preset = 'classic',
				transparent_bg = true,
			}
			vim.diagnostic.config { virtual_text = false } -- Disable Neovim's default virtual text diagnostics
		end,
	},
}
