return {
  -- DAP: debug adapter protocol (all keys in maps.lua)
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap-python',
      'leoluz/nvim-dap-go',
    },
    config = function()
      local dap    = require('dap')
      local dapui  = require('dapui')

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = 'scopes',      size = 0.33 },
              { id = 'watches',     size = 0.17 },
              { id = 'stacks',      size = 0.17 },
              { id = 'breakpoints', size = 0.33 },
            },
            size = 0.33,
            position = 'right',
          },
          {
            elements = {
              { id = 'repl',    size = 0.45 },
              { id = 'console', size = 0.55 },
            },
            size = 0.25,
            position = 'bottom',
          },
        },
        floating = {
          max_height = 0.9,
          max_width  = 0.5,
          border     = 'rounded',
        },
      })

      dap.listeners.after.event_initialized['dapui_config']  = dapui.open
      dap.listeners.before.event_terminated['dapui_config']  = dapui.close
      dap.listeners.before.event_exited['dapui_config']      = dapui.close

      vim.fn.sign_define('DapBreakpoint',          { text = '',  texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '',  texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DapLogPoint',            { text = '',  texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DapStopped',             { text = '',  texthl = 'DiagnosticSignWarn' })
    end,
  },

  -- DAP Python: Python debugger via debugpy (keys in maps.lua)
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    config = function()
      require('dap-python').setup('python3')
      require('dap-python').test_runner = 'pytest'
    end,
  },
}
