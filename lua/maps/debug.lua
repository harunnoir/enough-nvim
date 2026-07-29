return {
    { '<leader>dc', function() require('dap').continue() end, desc = 'Continue' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Step into' },
    { '<leader>do', function() require('dap').step_over() end, desc = 'Step over' },
    { '<leader>dO', function() require('dap').step_out() end, desc = 'Step out' },
    { '<leader>dr', function() require('dap').run_to_cursor() end, desc = 'Run to cursor' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
    {
        '<leader>dB',
        function() require('dap').set_breakpoint(vim.fn.input('Condition: ')) end,
        desc = 'Conditional breakpoint',
    },
    { '<leader>du', function() require('dapui').toggle() end, desc = 'Toggle DAP UI' },
    { '<leader>dti', function() require('dap-python').test_method() end, desc = 'Test method (Python)' },
    { '<leader>dtc', function() require('dap-python').test_class() end, desc = 'Test class (Python)' },
}
