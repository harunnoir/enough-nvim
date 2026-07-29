local M = {}

function M.setup(zoom_in, zoom_out, reset)
    local modes = { 'n', 'i', 'v', 't' }
    local function opts(desc) return { desc = desc, silent = true } end

    vim.keymap.set(modes, '<C-=>', zoom_in, opts('Neovide zoom in'))
    vim.keymap.set(modes, '<C-+>', zoom_in, opts('Neovide zoom in'))
    vim.keymap.set(modes, '<C-->', zoom_out, opts('Neovide zoom out'))
    vim.keymap.set(modes, '<C-0>', reset, opts('Neovide reset zoom'))
end

return M
