return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		opts = {
			ensure_installed = { 'lua', 'python', 'c', 'cpp', 'bash', 'markdown', 'yaml', 'json', 'toml', 'typescript' },
			highlight = true,
			indent = true,
			fold = true,
		},
	},
	-- Extra plugins depending on nvim-treesitter
	{
		'kevinhwang91/nvim-ufo',
		dependencies = 'kevinhwang91/promise-async',
		config = function()
			vim.o.foldcolumn = '1'
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			-- remap to ufo's own functions (fixes zR/zM behavior)
			vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
			vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

			require('ufo').setup {
				provider_selector = function()
					return { 'treesitter', 'indent' }
				end,
			}
		end,
	},
}
