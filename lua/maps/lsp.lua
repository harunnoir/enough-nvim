local map = vim.keymap.set

map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Previous diagnostic' })
map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Next diagnostic' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename symbol' })

return {
    diagnostics = {
        { '<leader>dde', '<cmd>TinyInlineDiag enable<cr>', desc = 'Enable inline diagnostics' },
        { '<leader>ddd', '<cmd>TinyInlineDiag disable<cr>', desc = 'Disable inline diagnostics' },
        { '<leader>ddt', '<cmd>TinyInlineDiag toggle<cr>', desc = 'Toggle inline diagnostics' },
        {
            '<leader>ddc',
            '<cmd>TinyInlineDiag toggle_cursor_only<cr>',
            desc = 'Toggle cursor-only diagnostics',
        },
        { '<leader>ddr', '<cmd>TinyInlineDiag reset<cr>', desc = 'Reset inline diagnostics' },
    },
}
