return {
    {
        'TheNoeTrevino/haunt.nvim',
        opts = {
            sign = '󱙝',
            sign_hl = 'HauntAnnotation',
            virt_text_hl = 'HauntAnnotation',
            annotation_prefix = ' 󰆉 ',
            annotation_suffix = '',
            line_hl = nil,
            virt_text_pos = 'eol',
            data_dir = nil,
            per_branch_bookmarks = true,
            picker = 'auto',
            picker_keys = {
                delete = { key = 'd', mode = { 'n' } },
                edit_annotation = { key = 'a', mode = { 'n' } },
            },
        },
        keys = {
            { '<leader>ha', function() require('haunt.api').annotate() end, desc = 'Annotate' },
            { '<leader>ht', function() require('haunt.api').toggle_annotation() end, desc = 'Toggle annotation' },
            { '<leader>hT', function() require('haunt.api').toggle_all_lines() end, desc = 'Toggle all annotations' },
            { '<leader>hd', function() require('haunt.api').delete() end, desc = 'Delete bookmark' },
            { '<leader>hC', function() require('haunt.api').clear_all() end, desc = 'Delete all bookmarks' },
            { '<leader>hp', function() require('haunt.api').prev() end, desc = 'Previous bookmark' },
            { '<leader>hn', function() require('haunt.api').next() end, desc = 'Next bookmark' },
            { '<leader>hl', function() require('haunt.picker').show() end, desc = 'Show Picker' },
            { '<leader>hq', function() require('haunt.api').to_quickfix() end, desc = 'Send to QF (buffer)' },
            { '<leader>hQ', function() require('haunt.api').to_quickfix({ current_buffer = true }) end, desc = 'Send to QF (all)' },
            { '<leader>hy', function() require('haunt.api').yank_locations({ current_buffer = true }) end, desc = 'Yank locations (buffer)' },
            { '<leader>hY', function() require('haunt.api').yank_locations() end, desc = 'Yank locations (all)' },
        },
        config = function(_, opts)
            require('haunt').setup(opts)
        end,
    },
}
