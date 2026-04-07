return {
	{
		'amwadud/nvim-maximizer',
		keys = { { '<C-m>', '<cmd>MaximizerToggle<CR>' } },
	},
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
	{
		'stevearc/oil.nvim',
		lazy = false,
		config = function()
			require('oil').setup()
		end,
		keys = { { '-', '<CMD>Oil<CR>' } },
	},
	{ 'numToStr/Comment.nvim', lazy = false },
	{
		'ggandor/leap.nvim',
		lazy = true,
		keys = {
			{
				'f',
				function()
					require('leap').leap {
						target_windows = vim.tbl_filter(function(win)
							return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'oil'
						end, vim.api.nvim_list_wins()),
					}
				end,
			},
			{
				'F',
				function()
					require('leap').leap {
						target_windows = vim.tbl_filter(function(win)
							return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'oil'
						end, vim.api.nvim_list_wins()),
						backward = true,
					}
				end,
			},
		},
	},
	{
		'folke/flash.nvim',
		lazy = true,
		keys = {
			{
				's',
				mode = { 'n', 'x', 'o' },
				function()
					require('flash').jump()
				end,
			},
			{
				'S',
				mode = { 'n', 'x', 'o' },
				function()
					require('flash').treesitter()
				end,
			},
		},
	},
}
