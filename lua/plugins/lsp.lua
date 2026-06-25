return {
    -- Mason: LSP / linter / formatter installer UI
    { 'williamboman/mason.nvim', cmd = 'Mason' },
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
    -- Lspsaga: hover doc, code action UI
    {
        'nvimdev/lspsaga.nvim',
        event = 'VeryLazy',
        config = function()
            require('lspsaga').setup({
                symbol_in_winbar = { enable = false },
                ui = { code_action = '' },
            })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
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
                lua = { 'selene' },
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
        event = 'BufReadPre',
        config = function()
            local function h(name)
                return vim.api.nvim_get_hl(0, { name = name })
            end

            vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = h('CursorLine').bg, italic = true })
            vim.api.nvim_set_hl(
                0,
                'SymbolUsageContent',
                { bg = h('CursorLine').bg, fg = h('Comment').fg, italic = true }
            )
            vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = h('Function').fg, bg = h('CursorLine').bg, italic = true })
            vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg = h('Type').fg, bg = h('CursorLine').bg, italic = true })
            vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg = h('@keyword').fg, bg = h('CursorLine').bg, italic = true })

            local function text_format(symbol)
                local res = {}

                local round_start = { '', 'SymbolUsageRounding' }
                local round_end = { '', 'SymbolUsageRounding' }

                local stacked_functions_content = symbol.stacked_count > 0 and ('+%s'):format(symbol.stacked_count)
                    or ''

                if symbol.references then
                    local usage = symbol.references <= 1 and 'usage' or 'usages'
                    local num = symbol.references == 0 and 'no' or symbol.references
                    table.insert(res, round_start)
                    table.insert(res, { '󰌹 ', 'SymbolUsageRef' })
                    table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageContent' })
                    table.insert(res, round_end)
                end

                if symbol.definition then
                    if #res > 0 then
                        table.insert(res, { ' ', 'NonText' })
                    end
                    table.insert(res, round_start)
                    table.insert(res, { '󰳽 ', 'SymbolUsageDef' })
                    table.insert(res, { symbol.definition .. ' defs', 'SymbolUsageContent' })
                    table.insert(res, round_end)
                end

                if symbol.implementation then
                    if #res > 0 then
                        table.insert(res, { ' ', 'NonText' })
                    end
                    table.insert(res, round_start)
                    table.insert(res, { '󰡱 ', 'SymbolUsageImpl' })
                    table.insert(res, { symbol.implementation .. ' impls', 'SymbolUsageContent' })
                    table.insert(res, round_end)
                end

                if stacked_functions_content ~= '' then
                    if #res > 0 then
                        table.insert(res, { ' ', 'NonText' })
                    end
                    table.insert(res, round_start)
                    table.insert(res, { ' ', 'SymbolUsageImpl' })
                    table.insert(res, { stacked_functions_content, 'SymbolUsageContent' })
                    table.insert(res, round_end)
                end

                return res
            end

            local SymbolKind = vim.lsp.protocol.SymbolKind

            require('symbol-usage').setup({
                text_format = text_format,
                hl = { link = 'Comment' },
                kinds = {
                    SymbolKind.Function,
                    SymbolKind.Method,
                    SymbolKind.Class,
                    SymbolKind.Constructor,
                },
                kinds_filter = {},
                vt_position = 'end_of_line',
                request_pending_text = false,
                references = { enabled = true, include_declaration = false },
                definition = { enabled = false },
                implementation = { enabled = false },
                disable = {
                    lsp = {},
                    filetypes = { 'markdown', 'text', 'help' },
                    cond = {},
                },
                symbol_request_pos = 'end',
                log = { enabled = false },
            })
        end,
    },
    -- DAP: debug adapter protocol (Go, Python, etc.)
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
            {
                '<F5>',
                function()
                    require('dap').continue()
                end,
            },
            {
                '<F1>',
                function()
                    require('dap').step_into()
                end,
            },
            {
                '<F2>',
                function()
                    require('dap').step_over()
                end,
            },
            {
                '<F3>',
                function()
                    require('dap').step_out()
                end,
            },
            {
                '<F6>',
                function()
                    require('dapui').toggle()
                end,
            },
            {
                '<leader>db',
                function()
                    require('dap').toggle_breakpoint()
                end,
            },
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            require('mason-nvim-dap').setup({ automatic_installation = true, ensure_installed = { 'delve' } })
            dapui.setup()
            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            require('dap-go').setup({ delve = { detached = vim.fn.has('win32') == 0 } })
        end,
    },
    -- DAP Python: Python debugger
    {
        'mfussenegger/nvim-dap-python',
        dependencies = { 'mfussenegger/nvim-dap' },
        ft = 'python',
        config = function()
            require('dap-python').setup('python3')
        end,
    },
}
