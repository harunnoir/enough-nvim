-- Neovide currently needs neovide-git for reliable Neovim 0.12 font rendering.
if not vim.g.neovide then
    vim.g.snacks_scroll = true
    return
end

vim.g.snacks_scroll = false

-- Typography and window.
vim.opt.guifont = 'IosevkaTerm Nerd Font:h14'
vim.opt.linespace = 0
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_remember_window_size = true
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_left = 0
vim.g.neovide_padding_right = 0

-- Rendering and floating windows.
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_floating_blur_amount_x = 3.0
vim.g.neovide_floating_blur_amount_y = 3.0
vim.g.neovide_floating_shadow = false
vim.g.neovide_window_blurred = true
vim.g.neovide_hide_mouse_when_typing = true

-- Keep motion smooth without making input feel delayed.
vim.g.neovide_position_animation_length = 0.1
vim.g.neovide_scroll_animation_length = 0.18
vim.g.neovide_scroll_animation_far_lines = 1
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_short_animation_length = 0.03
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_smooth_blink = true
vim.opt.guicursor:append('a:blinkwait700-blinkon475-blinkoff475')

local default_scale = 1.0
local minimum_scale = 0.5
local maximum_scale = 3.0
local scale_step = 1.1

local function set_scale(scale)
    scale = math.max(minimum_scale, math.min(maximum_scale, scale))
    vim.g.neovide_scale_factor = math.floor(scale * 100 + 0.5) / 100
end

local function zoom(direction)
    local scale = tonumber(vim.g.neovide_scale_factor) or default_scale
    set_scale(direction > 0 and scale * scale_step or scale / scale_step)
end

local modes = { 'n', 'i', 'v', 't' }
local map_opts = { silent = true }

vim.keymap.set(modes, '<C-=>', function() zoom(1) end, vim.tbl_extend('force', map_opts, { desc = 'Neovide zoom in' }))
vim.keymap.set(modes, '<C-+>', function() zoom(1) end, vim.tbl_extend('force', map_opts, { desc = 'Neovide zoom in' }))
vim.keymap.set(
    modes,
    '<C-->',
    function() zoom(-1) end,
    vim.tbl_extend('force', map_opts, { desc = 'Neovide zoom out' })
)
vim.keymap.set(
    modes,
    '<C-0>',
    function() set_scale(default_scale) end,
    vim.tbl_extend('force', map_opts, { desc = 'Neovide reset zoom' })
)
