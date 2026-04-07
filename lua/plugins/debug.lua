return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			'nvim-neotest/nvim-nio',
			'mason-org/mason.nvim',
			'jay-babu/mason-nvim-dap.nvim',
			'leoluz/nvim-dap-go',
		},
		keys = {
			{ '<F5>', function() require('dap').continue() end },
			{ '<F1>', function() require('dap').step_into() end },
			{ '<F2>', function() require('dap').step_over() end },
			{ '<F3>', function() require('dap').step_out() end },
			{ '<F6>', function() require('dapui').toggle() end },
			{ '<leader>db', function() require('dap').toggle_breakpoint() end },
		},
		config = function()
			local dap = require 'dap'
			local dapui = require 'dapui'
			require('mason-nvim-dap').setup { automatic_installation = true, ensure_installed = { 'delve' } }
			dapui.setup()
			dap.listeners.after.event_initialized['dapui_config'] = dapui.open
			dap.listeners.before.event_terminated['dapui_config'] = dapui.close
			require('dap-go').setup { delve = { detached = vim.fn.has 'win32' == 0 } }
		end,
	},
	{
		'mfussenegger/nvim-dap-python',
		dependencies = { 'mfussenegger/nvim-dap' },
		ft = 'python',
		config = function()
			require('dap-python').setup 'python3'
		end,
	},
}
