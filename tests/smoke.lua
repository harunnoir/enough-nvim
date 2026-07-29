local mappings = {
    n = {
        '<leader>w',
        'zR',
        'zM',
        '[h',
        ']h',
        'gD',
        'gR',
        'gY',
        'gM',
        'gs',
        '<C-h>',
        '<A-h>',
        '<leader>ff',
        '<leader>fp',
        '<leader>cf',
        '<leader>Gg',
        '<leader>Gl',
        '<leader>sj',
        '<leader>dc',
        '<leader>du',
        '<leader>xx',
        '<leader>ha',
        '<leader>in',
        '<leader>p',
        '<leader>u',
        '<leader>42',
        '<leader>9s',
        '<leader>a',
        '<leader>1',
        '<leader>or',
        '<leader>ddt',
        '-',
    },
    x = { 'gs', 'ai', 'if', 'y', 'p', '<leader>cf', '<leader>9v' },
    o = { 'gs', 'r', 'ai', 'if', ']f' },
    c = { '<C-s>' },
    t = { '<Esc><Esc>' },
}

for mode, keys in pairs(mappings) do
    for _, lhs in ipairs(keys) do
        local mapping = vim.fn.maparg(lhs, mode, false, true)
        assert(next(mapping) ~= nil, ('missing %s-mode mapping: %s'):format(mode, lhs))
    end
end
