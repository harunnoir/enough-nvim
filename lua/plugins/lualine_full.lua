-- ============================================================
-- lualine.lua — standalone statusline config
-- ============================================================

local function get_hl(group, attr)
    local ok, val = pcall(vim.api.nvim_get_hl, 0, { name = group })
    return ok and val and string.format('#%06x', val[attr])
end

local function get_colors()
    return {
        fg      = get_hl('Normal', 'fg')         or '#657b83',
        bg      = get_hl('Normal', 'bg')         or '#002b36',
        comment = get_hl('Comment', 'fg')        or '#93a1a1',
        warning = get_hl('DiagnosticWarn', 'fg') or '#b58900',
        green   = get_hl('DiagnosticOk', 'fg')   or '#859900',
        cyan    = get_hl('Function', 'fg')        or '#268bd2',
    }
end

local function filename()
    local name = vim.fn.expand('%:t')
    return name == '' and '[No Name]' or name
end

local function filename_color()
    local c = get_colors()
    local name = vim.fn.expand('%:t')
    return name == '' and { fg = c.warning, bg = c.bg } or { fg = c.fg, bg = c.bg }
end

local function get_theme()
    local c = get_colors()
    return {
        normal   = { c = { fg = c.fg,      bg = c.bg } },
        inactive = { c = { fg = c.comment, bg = c.bg } },
    }
end

local function lsp_info()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then return '󰒋 none' end
    local names = vim.tbl_map(function(c) return c.name end, clients)
    return '󰒋 ' .. table.concat(names, ', ')
end

local function treesitter_info()
    local ok, parsers = pcall(require, 'nvim-treesitter.parsers')
    if not ok then return '󰙅 none' end
    local lang = parsers.get_buf_lang()
    if parsers.has_parser(lang) then return '󰙅 ts' end
    return '󰙅 none'
end

local function formatter_info()
    local ok, conform = pcall(require, 'conform')
    if not ok then return '󰉿 none' end
    local formatters = conform.list_formatters(0)
    if #formatters == 0 then return '󰉿 none' end
    local names = vim.tbl_map(function(f) return f.name end, formatters)
    return '󰉿 ' .. table.concat(names, ', ')
end

local function linter_info()
    local ok, lint = pcall(require, 'lint')
    if not ok then return '󱉶 none' end
    local ft = vim.bo.filetype
    local linters = lint.linters_by_ft[ft] or {}
    if #linters == 0 then return '󱉶 none' end
    return '󱉶 ' .. table.concat(linters, ', ')
end

return {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
        return {
            options = {
                theme = get_theme,
                globalstatus = true,
                component_separators = '',
                section_separators = '',
                disabled_filetypes = {
                    statusline = { 'oil', '' },
                },
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        icon = ' 󰘍',
                        fmt = function(s) return s:sub(1, 3) end,
                    },
                },
                lualine_b = { { 'branch', icon = ' ' } },
                lualine_c = { { filename, icon = ' 󰈔', color = filename_color } },
                lualine_x = {
                    { lsp_info,       color = function() local c = get_colors() return { fg = c.cyan,    bg = c.bg } end },
                    { treesitter_info,color = function() local c = get_colors() return { fg = c.green,   bg = c.bg } end },
                    { formatter_info, color = function() local c = get_colors() return { fg = c.comment, bg = c.bg } end },
                    { linter_info,    color = function() local c = get_colors() return { fg = c.warning, bg = c.bg } end },
                    {
                        'diagnostics',
                        icon = ' ',
                        symbols = { error = '󰅙 ', warn = '󰀪 ', info = '󰋽 ', hint = '󰌶 ' },
                    },
                },
                lualine_y = { { 'filetype', icon = '  ' } },
                lualine_z = { { 'location', icon = ' 󰓆' } },
            },
        }
    end,
}
