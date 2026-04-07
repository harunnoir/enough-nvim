return {
	{
		'saghen/blink.cmp',
		version = '1.*',
		lazy = true,
		event = 'InsertEnter',
		dependencies = { 'rafamadriz/friendly-snippets' },
		opts = { keymap = { preset = 'default' }, completion = { ghost_text = { enabled = true } } },
	},
}
