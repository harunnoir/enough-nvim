return {
    -- Mason: LSP / linter / formatter installer UI
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
            -- Ensure Mason's bin dir is on PATH for vim.lsp.enable(), conform, etc.
            vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH
        end,
    },
    -- Tiny inline diagnostic: show diagnostics at end of line
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        event = 'VeryLazy',
        priority = 1000,
        config = function()
            require('tiny-inline-diagnostic').setup({
                preset = 'classic',
                transparent_bg = true,
                options = {
                    multilines = {
                        enabled = true,
                        always_show = true,
                    },
                    overflow = {
                        mode = 'wrap',
                        padding = 0,
                    },
                },
            })
            vim.diagnostic.config({ virtual_text = false })
        end,
    },
    -- Nvim-lint: async linting on save
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require('lint')
            lint.linters_by_ft = {
                markdown = { 'markdownlint' },
                python = { 'flake8' },
                sh = { 'shellcheck' },
                -- lua = { 'selene' },
            }
            vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
                group = vim.api.nvim_create_augroup('lint', { clear = true }),
                callback = function()
                    if vim.bo.modifiable then
                        lint.try_lint()
                    end
                end,
            })
        end,
    },
    -- Fidget: LSP progress spinner
    {
        'j-hui/fidget.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    -- Symbol-usage: inline reference / definition counts
    {
        'Wansmer/symbol-usage.nvim',
        event = 'VeryLazy',
        config = function()
            local function text_format(symbol)
                local fragments = {}
                -- Indicator that shows if there are any other symbols in the same line
                local stacked_functions = symbol.stacked_count > 0 and (' | +%s'):format(symbol.stacked_count) or ''
                if symbol.references then
                    local usage = symbol.references <= 1 and 'usage' or 'usages'
                    local num = symbol.references == 0 and 'no' or symbol.references
                    table.insert(fragments, ('%s %s'):format(num, usage))
                end
                if symbol.definition then
                    table.insert(fragments, symbol.definition .. ' defs')
                end
                if symbol.implementation then
                    table.insert(fragments, symbol.implementation .. ' impls')
                end
                return table.concat(fragments, ', ') .. stacked_functions
            end

            require('symbol-usage').setup({
                text_format = text_format,
                vt_position = 'end_of_line',
            })
        end,
    },
}
