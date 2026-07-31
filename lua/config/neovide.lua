-- Neovide currently needs neovide-git for reliable Neovim 0.12 rendering.
if not vim.g.neovide then
    vim.g.snacks_scroll = true
    return
end

-- Snacks scrolling conflicts with Neovide's native scrolling animation.
vim.g.snacks_scroll = false

-- ── Typography ───────────────────────────────────────────────────────────────

vim.o.guifont = "IosevkaTerm Nerd Font:h14"
vim.o.linespace = 0

-- ── Window ───────────────────────────────────────────────────────────────────

vim.g.neovide_scale_factor = 1.0
vim.g.neovide_remember_window_size = true

vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_left = 0
vim.g.neovide_padding_right = 0

-- ── Rendering ────────────────────────────────────────────────────────────────

vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5

vim.g.neovide_floating_blur_amount_x = 3.0
vim.g.neovide_floating_blur_amount_y = 3.0
vim.g.neovide_floating_shadow = false
vim.g.neovide_window_blurred = true

-- ── Mouse ────────────────────────────────────────────────────────────────────

-- Enable clicking, dragging, selections and scrolling in all modes.
vim.o.mouse = "a"

-- Standard wheel/touchpad scrolling distances.
vim.o.mousescroll = "ver:3,hor:6"

-- Do not send an event for every normal mouse movement.
vim.o.mousemoveevent = false

-- Keep the pointer visible while troubleshooting mouse behavior.
vim.g.neovide_hide_mouse_when_typing = false

-- ── Motion ───────────────────────────────────────────────────────────────────

vim.g.neovide_position_animation_length = 0.10

vim.g.neovide_scroll_animation_length = 0.10
vim.g.neovide_scroll_animation_far_lines = 0

-- ── Cursor ───────────────────────────────────────────────────────────────────

vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_short_animation_length = 0.03
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_antialiasing = true

vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_smooth_blink = true

vim.opt.guicursor:append(
    "a:blinkwait700-blinkon475-blinkoff475"
)

-- ── Zoom ─────────────────────────────────────────────────────────────────────

local default_scale = 1.0
local minimum_scale = 0.5
local maximum_scale = 3.0
local scale_step = 1.1

local function set_scale(scale)
    scale = math.max(minimum_scale, math.min(maximum_scale, scale))

    vim.g.neovide_scale_factor =
        math.floor(scale * 100 + 0.5) / 100
end

local function zoom(direction)
    local scale =
        tonumber(vim.g.neovide_scale_factor) or default_scale

    if direction > 0 then
        set_scale(scale * scale_step)
    else
        set_scale(scale / scale_step)
    end
end

require("maps.neovide").setup(
    function()
        zoom(1)
    end,
    function()
        zoom(-1)
    end,
    function()
        set_scale(default_scale)
    end
)
