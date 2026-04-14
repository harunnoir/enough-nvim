local function fix_gruvbox_functions()
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#504945', bg = '#32302F' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#32302F' })
    vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = '#32302F' })
    vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { fg = '#504945', bg = '#32302F' })
    vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { bg = '#32302F' })
    vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { fg = '#504945', bg = '#32302F' })

    vim.api.nvim_set_hl(0, '@parameter', { italic = true })
    vim.api.nvim_set_hl(0, '@lsp.type.parameter', { italic = true })
    vim.api.nvim_set_hl(0, '@lsp.type.parameter.python', { italic = true })
end

vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        if vim.g.colors_name == 'gruvbox-material' then
            fix_gruvbox_functions()
        end
    end,
})

-- Apply immediately if already using the theme
if vim.g.colors_name == 'gruvbox-material' then
    fix_gruvbox_functions()
end
