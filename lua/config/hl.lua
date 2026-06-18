local function fix_gruvbox_functions()
    -- Palette
    local c = {
        bg1 = '#32302F',
        bg2 = '#3c3836',
        bg3 = '#504945',
        fg = '#d4be98',
        red = '#ea6962',
        orange = '#e78a4e',
        yellow = '#d8a657',
        green = '#a9b665',
        blue = '#7daea3',
        purple = '#d3869b',
        aqua = '#89b482',
        gray = '#928374',
    }
    local hl = function(name, opts)
        vim.api.nvim_set_hl(0, name, opts)
    end

    -- ── Floats & Completion ───────────────────────────────────────────────
    hl('FloatBorder', { fg = c.bg3, bg = c.bg1 })
    hl('NormalFloat', { bg = c.bg1 })
    hl('BlinkCmpMenu', { bg = c.bg1 })
    hl('BlinkCmpMenuBorder', { fg = c.bg3, bg = c.bg1 })
    hl('BlinkCmpDoc', { bg = c.bg1 })
    hl('BlinkCmpDocBorder', { fg = c.bg3, bg = c.bg1 })

    -- ── LSP / Treesitter ──────────────────────────────────────────────────
    hl('@parameter', { italic = true })
    hl('@lsp.type.parameter', { italic = true })
    hl('@lsp.type.parameter.python', { italic = true })

    -- ── Oil Git ───────────────────────────────────────────────────────────
    hl('OilGitAdded', { fg = c.green })
    hl('OilGitModified', { fg = c.yellow })
    hl('OilGitRenamed', { fg = c.purple })
    hl('OilGitUntracked', { fg = c.aqua })
    hl('OilGitIgnored', { fg = c.gray })
    hl('OilGitDeleted', { fg = c.red })

    -- ── render-markdown.nvim ──────────────────────────────────────────────
    -- Headings — foreground
    hl('RenderMarkdownH1', { fg = c.red, bold = true })
    hl('RenderMarkdownH2', { fg = c.orange, bold = true })
    hl('RenderMarkdownH3', { fg = c.yellow, bold = true })
    hl('RenderMarkdownH4', { fg = c.green, bold = true })
    hl('RenderMarkdownH5', { fg = c.blue, bold = true })
    hl('RenderMarkdownH6', { fg = c.purple, bold = true })
    -- Headings — background strip (warm tints)
    hl('RenderMarkdownH1Bg', { bg = '#3b2a2a' })
    hl('RenderMarkdownH2Bg', { bg = '#3b2f1f' })
    hl('RenderMarkdownH3Bg', { bg = '#373323' })
    hl('RenderMarkdownH4Bg', { bg = '#2c3223' })
    hl('RenderMarkdownH5Bg', { bg = '#253238' })
    hl('RenderMarkdownH6Bg', { bg = '#38293b' })

    -- Code blocks
    hl('RenderMarkdownCode', { bg = c.bg1 })
    hl('RenderMarkdownCodeBorder', { fg = c.bg3 })
    hl('RenderMarkdownCodeInline', { fg = c.yellow, bg = c.bg2 })
    hl('RenderMarkdownCodeFallback', { fg = c.gray })

    -- Bullets, dash, quotes
    hl('RenderMarkdownBullet', { fg = c.orange })
    hl('RenderMarkdownDash', { fg = c.bg3 })
    hl('RenderMarkdownQuote', { fg = c.gray })
    hl('RenderMarkdownQuote1', { fg = c.blue })
    hl('RenderMarkdownQuote2', { fg = c.aqua })
    hl('RenderMarkdownQuote3', { fg = c.green })
    hl('RenderMarkdownQuote4', { fg = c.yellow })
    hl('RenderMarkdownQuote5', { fg = c.orange })
    hl('RenderMarkdownQuote6', { fg = c.red })

    -- Callouts
    hl('RenderMarkdownInfo', { fg = c.blue })
    hl('RenderMarkdownSuccess', { fg = c.green })
    hl('RenderMarkdownHint', { fg = c.aqua })
    hl('RenderMarkdownWarn', { fg = c.yellow })
    hl('RenderMarkdownError', { fg = c.red })

    -- Tables
    hl('RenderMarkdownTableHead', { fg = c.yellow, bold = true })
    hl('RenderMarkdownTableRow', { fg = c.fg })

    -- Links
    hl('RenderMarkdownLink', { fg = c.blue, underline = true })
    hl('RenderMarkdownLinkTitle', { fg = c.aqua })
    hl('RenderMarkdownWikiLink', { fg = c.purple })

    -- Misc
    hl('RenderMarkdownSign', { fg = c.gray })
    hl('RenderMarkdownMath', { fg = c.purple })
    hl('RenderMarkdownChecked', { fg = c.green })
    hl('RenderMarkdownUnchecked', { fg = c.gray })
    hl('RenderMarkdownTodo', { fg = c.yellow })
    hl('RenderMarkdownInlineHighlight', { fg = c.yellow, bg = c.bg2 })

    -- Oil
    hl('OilDir', { fg = c.fg, bold = true })

    -- Flash
    hl('FlashMatch', { fg = c.fg, bg = c.bg3 })
    hl('FlashCurrent', { fg = c.yellow, bg = c.bg2, bold = true })
    hl('FlashLabel', { fg = c.bg1, bg = c.red, bold = true })
    hl('FlashBackdrop', { fg = c.gray })
    hl('FlashPrompt', { fg = c.yellow, bg = c.bg1 })
    hl('FlashPromptIcon', { fg = c.orange, bg = c.bg1 })
    hl('FlashCursor', { fg = c.bg1, bg = c.aqua })
    hl('FlashTreesitter', { fg = c.bg1, bg = c.green, bold = true })
    hl('FlashRemote', { fg = c.bg1, bg = c.blue })
end

vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        if vim.g.colors_name == 'gruvbox-material' then
            fix_gruvbox_functions()
        end
    end,
})
if vim.g.colors_name == 'gruvbox-material' then
    fix_gruvbox_functions()
end
