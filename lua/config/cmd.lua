local api = vim.api
local cmd = vim.cmd

-------------------------------------------------------
-- Save/restore view (cursor, folds, etc.)
-------------------------------------------------------
local view_group = api.nvim_create_augroup('AutoViewRestore', { clear = true })

api.nvim_create_autocmd({ 'BufWinLeave' }, {
    group = view_group,
    pattern = '*',
    callback = function()
        cmd('silent! mkview')
    end,
})

api.nvim_create_autocmd({ 'BufWinEnter' }, {
    group = view_group,
    pattern = '*',
    callback = function()
        cmd('silent! loadview')
    end,
})

-------------------------------------------------------
-- Filetype settings (centralized + scalable)
-------------------------------------------------------
local filetype_settings = {
    python = function()
        vim.opt_local.colorcolumn = '79,99'
        vim.opt_local.textwidth = 79
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.expandtab = true
    end,

    c = function()
        vim.opt_local.colorcolumn = '80,120'
        vim.opt_local.textwidth = 80
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.expandtab = false
    end,

    cpp = function()
        vim.opt_local.colorcolumn = '80,120'
        vim.opt_local.textwidth = 80
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.expandtab = false
    end,

    lua = function()
        vim.opt_local.colorcolumn = '120'
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.expandtab = true
    end,

    markdown = function()
        vim.opt_local.colorcolumn = '80'
        vim.opt_local.textwidth = 80
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,

    text = function()
        vim.opt_local.colorcolumn = '80'
        vim.opt_local.textwidth = 80
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,

    rst = function()
        vim.opt_local.colorcolumn = '80'
        vim.opt_local.textwidth = 80
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,

    javascript = function()
        vim.opt_local.colorcolumn = '100'
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,

    typescript = function()
        vim.opt_local.colorcolumn = '100'
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,

    json = function()
        vim.opt_local.colorcolumn = '100'
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,

    yaml = function()
        vim.opt_local.colorcolumn = '80'
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,

    toml = function()
        vim.opt_local.colorcolumn = '80'
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
    end,
}

local ft_group = api.nvim_create_augroup('FileTypeSettings', { clear = true })

api.nvim_create_autocmd('FileType', {
    group = ft_group,
    pattern = vim.tbl_keys(filetype_settings),
    callback = function(args)
        local fn = filetype_settings[args.match]
        if fn then fn() end
    end,
})

-------------------------------------------------------
-- Scratch file helper
-------------------------------------------------------
vim.keymap.set('n', '<leader>st', function()
    vim.ui.input({ prompt = 'scratch ext: .' }, function(ext)
        if not ext or ext == '' then
            return
        end
        local tmpfile = vim.fn.tempname() .. '.' .. ext
        vim.cmd('edit ' .. vim.fn.fnameescape(tmpfile))
    end)
end, { desc = 'Scratch file' })

-------------------------------------------------------
-- CSV view auto enable
-------------------------------------------------------
local csv_group = api.nvim_create_augroup('CsvViewAutoEnable', { clear = true })

api.nvim_create_autocmd('BufReadPost', {
    group = csv_group,
    pattern = '*.csv',
    callback = function()
        cmd('CsvViewEnable delimiter=, display_mode=border header_lnum=1')
    end,
})

-------------------------------------------------------
-- Highlight on paste
-------------------------------------------------------
local function highlight_paste(key)
    return function()
        local pos_before = api.nvim_win_get_cursor(0)
        vim.cmd('normal! ' .. vim.v.count1 .. key)
        local pos_after = api.nvim_win_get_cursor(0)

        local start_line = math.min(pos_before[1], pos_after[1]) - 1
        local end_line = math.max(pos_before[1], pos_after[1])

        local ns = api.nvim_create_namespace('paste_highlight')
        api.nvim_buf_set_extmark(0, ns, start_line, 0, {
            end_row = end_line,
            hl_group = 'IncSearch',
            hl_eol = true,
        })

        vim.defer_fn(function()
            api.nvim_buf_clear_namespace(0, ns, 0, -1)
        end, 150)
    end
end

vim.keymap.set('n', 'p', highlight_paste('p'), { desc = 'Paste and highlight' })
vim.keymap.set('n', 'P', highlight_paste('P'), { desc = 'Paste above and highlight' })
