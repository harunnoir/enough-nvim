return {
    {
        'catgoose/nvim-colorizer.lua',
        event = 'BufReadPre',
        config = function()
            require('colorizer').setup({
                filetypes = { '*' }, -- filetypes to highlight, "*" for all
                buftypes = {}, -- buftypes to highlight
                user_commands = true, -- enable user commands (ColorizerToggle, etc.)
                lazy_load = false, -- lazily schedule buffer highlighting
                options = {
                    parsers = {
                        css = false, -- preset: enables names, hex, rgb, hsl, oklch, css_var
                        css_fn = false, -- preset: enables rgb, hsl, oklch
                        names = {
                            enable = true, -- enable named colors (e.g. "Blue")
                            lowercase = true, -- match lowercase names
                            camelcase = true, -- match CamelCase names (e.g. "LightBlue")
                            uppercase = false, -- match UPPERCASE names
                            strip_digits = false, -- ignore names with trailing digits (e.g. "blue3")
                            custom = false, -- custom name-to-hex mappings; table|function|false
                            extra_word_chars = '-', -- extra chars treated as part of color name
                        },
                        hex = {
                            default = true, -- default value for unset format keys (see above)
                            rgb = true, -- #RGB (3-digit)
                            rgba = true, -- #RGBA (4-digit)
                            rrggbb = true, -- #RRGGBB (6-digit)
                            rrggbbaa = false, -- #RRGGBBAA (8-digit)
                            hash_aarrggbb = false, -- #AARRGGBB (QML-style, alpha first)
                            aarrggbb = false, -- 0xAARRGGBB
                            no_hash = false, -- hex without '#' at word boundaries
                        },
                        rgb = { enable = false }, -- rgb()/rgba() functions
                        hsl = { enable = false }, -- hsl()/hsla() functions
                        oklch = { enable = false }, -- oklch() function
                        hwb = { enable = false }, -- hwb() function (CSS Color Level 4)
                        lab = { enable = false }, -- lab() function (CIE Lab)
                        lch = { enable = false }, -- lch() function (CIE LCH)
                        css_color = { enable = false }, -- color() function (srgb, display-p3, a98-rgb, etc.)
                        tailwind = {
                            enable = false, -- parse Tailwind color names
                            update_names = false, -- feed LSP colors back into name parser (requires both enable + lsp.enable)
                            lsp = { -- accepts boolean, true is shortcut for { enable = true, disable_document_color = true }
                                enable = false, -- use Tailwind LSP documentColor
                                disable_document_color = true, -- auto-disable vim.lsp.document_color on attach
                            },
                        },
                        sass = {
                            enable = false, -- parse Sass color variables
                            parsers = { css = true }, -- parsers for resolving variable values
                            variable_pattern = '^%$([%w_-]+)', -- Lua pattern for variable names
                        },
                        xterm = { enable = false }, -- xterm 256-color codes (#xNN, \e[38;5;NNNm)
                        xcolor = { enable = false }, -- LaTeX xcolor expressions (e.g. red!30)
                        hsluv = { enable = false }, -- hsluv()/hsluvu() functions
                        css_var_rgb = { enable = false }, -- CSS vars with R,G,B (e.g. --color: 240,198,198)
                        css_var = {
                            enable = false, -- resolve var(--name) references to their defined color
                            parsers = { css = true }, -- parsers for resolving variable values
                        },
                        custom = {}, -- list of custom parser definitions
                    },
                    display = {
                        mode = 'background', -- string or list: "background"|"foreground"|"underline"|"virtualtext"
                        background = {
                            bright_fg = '#000000', -- text color on bright backgrounds
                            dark_fg = '#ffffff', -- text color on dark backgrounds
                        },
                        virtualtext = {
                            char = '󰝤', -- character used for virtualtext
                            position = 'eol', -- "eol"|"before"|"after"
                            hl_mode = 'foreground', -- "background"|"foreground"
                        },
                        priority = {
                            default = 150, -- extmark priority for normal highlights
                            lsp = 200, -- extmark priority for LSP/Tailwind highlights
                        },
                        disable_document_color = true, -- true (all LSPs) | false | { lsp_name = true, ... }
                    },
                    hooks = {
                        should_highlight_line = false, -- function(line, bufnr, line_num) -> bool
                        should_highlight_color = false, -- function(rgb_hex, parser_name, ctx) -> bool
                        transform_color = false, -- function(rgb_hex, ctx) -> string
                        on_attach = false, -- function(bufnr, opts)
                        on_detach = false, -- function(bufnr)
                    },
                    always_update = false, -- update highlights even in unfocused buffers
                    debounce_ms = 0, -- debounce highlight updates (ms); 0 = no debounce
                },
            })
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        'necrom4/calcium.nvim',
        cmd = { 'Calcium' },
        opts = {},
    },
    {
        '2kabhishek/nerdy.nvim',
        dependencies = {
            'folke/snacks.nvim',
        },
        cmd = 'Nerdy',
        opts = {
            max_recents = 30, -- Configure recent icons limit
            copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
            copy_register = '+', -- Register to use for copying (if `copy_to_clipboard` is true)
        },
        keys = {
            { '<leader>in', ':Nerdy list<CR>', desc = 'Browse nerd icons' },
            { '<leader>iN', ':Nerdy recents<CR>', desc = 'Browse recent nerd icons' },
        },
    },
    {
        'dstein64/vim-startuptime',
    },
    {
        'nvzone/typr',
        dependencies = 'nvzone/volt',
        opts = {},
        cmd = { 'Typr', 'TyprStats' },
    },
    { 'nvim-mini/mini.nvim', version = '*' },
    {
        'jiaoshijie/undotree',
        opts = {
            -- your options
        },
        keys = { -- load the plugin only when using it's keybinding:
            { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
        },
    },
    {
        'chrscchrn/dictionary.nvim',
        config = function()
            require('dictionary').setup()
        end,
    },
}
