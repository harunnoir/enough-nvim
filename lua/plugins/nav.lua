local maps = require('maps.nav')

return {
    {
        'mrjones2014/smart-splits.nvim',
        keys = maps.splits,
    },

    {
        'chrisgrieser/nvim-spider',
        keys = maps.spider,
    },

    -- Toggle one window without changing the split layout.
    {
        'declancm/maximize.nvim',
        cmd = 'Maximize',
        keys = maps.maximize,
        config = true,
    },

    -- Long-range visible jumps.
    {
        'folke/flash.nvim',
        keys = maps.flash,
        opts = {},
    },

    -- Glance: peek LSP definitions / references
    {
        'dnlhc/glance.nvim',
        cmd = 'Glance',
        keys = maps.glance,
    },

    -- Oil: file explorer as a buffer (key in keymaps.lua)
    {
        'stevearc/oil.nvim',
        lazy = false,
        keys = maps.oil,
        opts = {
            columns = { 'icon', 'permissions', 'size', 'mtime' },
        },
    },

    -- Oil plugins: diagnostics and git status in Oil
    {
        'JezerM/oil-lsp-diagnostics.nvim',
        ft = 'oil',
        dependencies = { 'stevearc/oil.nvim' },
        opts = {},
    },
    {
        'benomahony/oil-git.nvim',
        ft = 'oil',
        dependencies = { 'stevearc/oil.nvim' },

        opts = function()
            local function get_hl(group, attr)
                local ok, hl = pcall(vim.api.nvim_get_hl, 0, {
                    name = group,
                    link = false,
                })

                if not ok or type(hl) ~= 'table' then
                    return nil
                end

                local value = hl[attr]

                if type(value) ~= 'number' then
                    return nil
                end

                return string.format('#%06x', value)
            end

            return {
                highlights = {
                    OilGitAdded = {
                        fg = get_hl('DiagnosticOk', 'fg') or '#a9b665',
                    },
                    OilGitModified = {
                        fg = get_hl('DiagnosticWarn', 'fg') or '#d8a657',
                    },
                    OilGitRenamed = {
                        fg = get_hl('Keyword', 'fg') or '#d3869b',
                    },
                    OilGitUntracked = {
                        fg = get_hl('Function', 'fg') or '#7daea3',
                    },
                    OilGitIgnored = {
                        fg = get_hl('Comment', 'fg') or '#928374',
                    },
                },
            }
        end,
    },

    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = maps.harpoon,
        config = function() require('harpoon').setup() end,
    },

    -- Marks: visual indicators for marks a-z
    {
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        opts = {},
    },
}
