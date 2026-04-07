local function get_hl(group, attr)
	local ok, val = pcall(vim.api.nvim_get_hl, 0, { name = group })
	return ok and val and string.format('#%06x', val[attr])
end

local function get_colors()
	return {
		fg = get_hl('Normal', 'fg') or '#657b83',
		bg = get_hl('Normal', 'bg') or '#002b36',
		comment = get_hl('Comment', 'fg') or '#93a1a1',
		warning = get_hl('DiagnosticWarn', 'fg') or '#b58900',
	}
end

local function filename()
	local name = vim.fn.expand '%:t'
	return name == '' and '[No Name]' or name
end

local function filename_color()
	local c = get_colors()
	local name = vim.fn.expand '%:t'
	return name == '' and { fg = c.warning, bg = c.bg } or { fg = c.fg, bg = c.bg }
end

local function get_theme()
	local c = get_colors()
	return {
		normal = { c = { fg = c.fg, bg = c.bg } },
		inactive = { c = { fg = c.comment, bg = c.bg } },
	}
end

return {
	{
		'folke/snacks.nvim',
		priority = 1000,
		lazy = false,
		opts = {
			notifier = { enabled = true },
			picker = { expand = true },
			animate = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			dashboard = { enabled = false },
			bigfile = { enabled = true },
			scroll = { enabled = true },
		},
	},
	{ 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
	{ 'maxmx03/solarized.nvim' },
	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
		config = function()
			vim.o.background = 'dark'
			vim.cmd.colorscheme 'gruvbox-material'
		end,
	},
	{
		'gbprod/yanky.nvim',
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		lazy = true,
		event = 'VeryLazy',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = function()
			return {
				options = {
					theme = get_theme,
					globalstatus = true,
					disabled_filetypes = { 'alpha', 'dashboard' },
					component_separators = '',
					section_separators = '',
				},
				sections = {
					lualine_a = { {
						'mode',
						icon = ' 󰘍',
						fmt = function(s)
							return s:sub(1, 3)
						end,
					} },
					lualine_b = { { 'branch', icon = ' ' } },
					lualine_c = { { filename, icon = ' 󰈔', color = filename_color } },
					lualine_x = { { 'diagnostics', icon = ' ', symbols = { error = '󰅙 ', warn = '󰀪 ', info = '󰋽 ', hint = '󰌶 ' } } },
					lualine_y = { { 'filetype', icon = '  ' } },
					lualine_z = { { 'location', icon = ' 󰓆' } },
				},
			}
		end,
	},
}
