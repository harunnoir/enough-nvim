return {
    tasks = {
        { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run task' },
        { '<leader>ot', '<cmd>OverseerToggle<cr>', desc = 'Toggle task output' },
        { '<leader>oo', '<cmd>OverseerOpen<cr>', desc = 'Open task panel' },
        { '<leader>ox', '<cmd>OverseerClose<cr>', desc = 'Close task panel' },
        { '<leader>os', '<cmd>OverseerShell<cr>', desc = 'Shell task' },
        { '<leader>oa', '<cmd>OverseerTaskAction<cr>', desc = 'Task action' },
    },
    bookmarks = {
        { '<leader>ha', function() require('haunt.api').annotate() end, desc = 'Annotate' },
        { '<leader>ht', function() require('haunt.api').toggle_annotation() end, desc = 'Toggle annotation' },
        { '<leader>hT', function() require('haunt.api').toggle_all_lines() end, desc = 'Toggle all annotations' },
        { '<leader>hd', function() require('haunt.api').delete() end, desc = 'Delete bookmark' },
        { '<leader>hC', function() require('haunt.api').clear_all() end, desc = 'Clear all bookmarks' },
        { '<leader>hp', function() require('haunt.api').prev() end, desc = 'Previous bookmark' },
        { '<leader>hn', function() require('haunt.api').next() end, desc = 'Next bookmark' },
        { '<leader>hl', function() require('haunt.picker').show() end, desc = 'List bookmarks' },
        { '<leader>hq', function() require('haunt.api').to_quickfix() end, desc = 'Bookmarks to quickfix' },
        {
            '<leader>hQ',
            function() require('haunt.api').to_quickfix({ current_buffer = true }) end,
            desc = 'Buffer bookmarks to quickfix',
        },
        {
            '<leader>hy',
            function() require('haunt.api').yank_locations({ current_buffer = true }) end,
            desc = 'Yank buffer bookmark locations',
        },
        { '<leader>hY', function() require('haunt.api').yank_locations() end, desc = 'Yank bookmark locations' },
    },
    icons = {
        { '<leader>in', '<cmd>Nerdy list<cr>', desc = 'Browse Nerd Font icons' },
        { '<leader>iN', '<cmd>Nerdy recents<cr>', desc = 'Recent Nerd Font icons' },
    },
    undo = {
        { '<leader>u', function() require('undotree').toggle() end, desc = 'Undo tree' },
    },
    ai = {
        {
            '<leader>9v',
            function()
                require('99').visual()
                vim.cmd.startinsert()
            end,
            mode = 'v',
            desc = 'AI visual prompt',
        },
        {
            '<leader>9s',
            function()
                require('99').search()
                vim.cmd.startinsert()
            end,
            desc = 'AI search prompt',
        },
        { '<leader>9x', function() require('99').stop_all_requests() end, desc = 'AI cancel' },
        { '<leader>9l', function() require('99').view_logs() end, desc = 'AI logs' },
    },
    school = {
        { '<leader>42', '<cmd>Stdheader<cr>', desc = '42 header' },
    },
}
