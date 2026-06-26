return {
  -- Python
  {
    'benomahony/uv.nvim',
    -- Optional filetype to lazy load when you open a python file
    -- ft = { python }
    -- Optional dependency, but recommended:
    -- dependencies = {
    --   "folke/snacks.nvim"
    -- or
    --   "nvim-telescope/telescope.nvim"
    -- },
    opts = {
      picker_integration = true,
    },
  },
  -- Render-markdown: WYSIWYG markdown preview
  {
    'MeanderingProgrammer/render-markdown.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    opts = {
      heading = {
        position = 'overlay',
        width = 'block',
        border = false,
        left_pad = 1,
        right_pad = 1,
      },
      code = {
        border = 'hide',
        position = 'left',
        width = 'full',
        left_pad = 1,
      },
      dash = { width = 'full' },
      quote = { icon = '▋' },
    },
    config = function(_, opts)
      require('render-markdown').setup(opts)
      local hl = vim.api.nvim_set_hl
      local c = {
        bg2 = '#3c3836',
        fg = '#d4be98',
        red = '#ea6962',
        orange = '#e78a4e',
        yellow = '#d8a657',
        green = '#a9b665',
        blue = '#7daea3',
        purple = '#d3869b',
        aqua = '#89b482',
        gray = '#928374',
        -- dimmed heading backgrounds
        red_dim = '#5a3030',
        orange_dim = '#4e3520',
        yellow_dim = '#4a3d20',
        green_dim = '#2e3b20',
        aqua_dim = '#253b35',
        blue_dim = '#253540',
      }
      -- Headings
      hl(0, 'RenderMarkdownH1', { fg = c.red, bold = true })
      hl(0, 'RenderMarkdownH1Bg', { fg = c.red, bg = c.red_dim, bold = true })
      hl(0, 'RenderMarkdownH2', { fg = c.orange, bold = true })
      hl(0, 'RenderMarkdownH2Bg', { fg = c.orange, bg = c.orange_dim, bold = true })
      hl(0, 'RenderMarkdownH3', { fg = c.yellow, bold = true })
      hl(0, 'RenderMarkdownH3Bg', { fg = c.yellow, bg = c.yellow_dim, bold = true })
      hl(0, 'RenderMarkdownH4', { fg = c.green, bold = true })
      hl(0, 'RenderMarkdownH4Bg', { fg = c.green, bg = c.green_dim, bold = true })
      hl(0, 'RenderMarkdownH5', { fg = c.aqua, bold = true })
      hl(0, 'RenderMarkdownH5Bg', { fg = c.aqua, bg = c.aqua_dim, bold = true })
      hl(0, 'RenderMarkdownH6', { fg = c.blue, bold = true })
      hl(0, 'RenderMarkdownH6Bg', { fg = c.blue, bg = c.blue_dim, bold = true })
      -- Treesitter heading overrides
      hl(0, '@markup.heading.1.markdown', { fg = c.red, bg = c.red_dim, bold = true })
      hl(0, '@markup.heading.2.markdown', { fg = c.orange, bg = c.orange_dim, bold = true })
      hl(0, '@markup.heading.3.markdown', { fg = c.yellow, bg = c.yellow_dim, bold = true })
      hl(0, '@markup.heading.4.markdown', { fg = c.green, bg = c.green_dim, bold = true })
      hl(0, '@markup.heading.5.markdown', { fg = c.aqua, bg = c.aqua_dim, bold = true })
      hl(0, '@markup.heading.6.markdown', { fg = c.blue, bg = c.blue_dim, bold = true })
      -- Code
      hl(0, 'RenderMarkdownCode', { bg = c.bg2 })
      hl(0, 'RenderMarkdownCodeBorder', { bg = c.bg2 })
      hl(0, 'RenderMarkdownCodeInline', { bg = c.bg2 })
      -- Lists
      hl(0, 'RenderMarkdownBullet', { fg = c.aqua })
      hl(0, 'RenderMarkdownUnchecked', { fg = c.gray })
      hl(0, 'RenderMarkdownChecked', { fg = c.green })
      -- Quotes & tables
      for i = 1, 6 do
        hl(0, ('RenderMarkdownQuote%d'):format(i), { fg = c.gray })
      end
      hl(0, 'RenderMarkdownTableHead', { fg = c.orange })
      hl(0, 'RenderMarkdownTableRow', { fg = c.fg })
      hl(0, 'RenderMarkdownDash', { fg = c.gray })
      hl(0, 'RenderMarkdownLink', { fg = c.blue, underline = true })
      hl(0, 'RenderMarkdownWikiLink', { fg = c.purple, underline = true })
      hl(0, 'RenderMarkdownSign', { fg = c.gray })
      -- Callouts
      hl(0, 'RenderMarkdownInfo', { fg = c.blue })
      hl(0, 'RenderMarkdownSuccess', { fg = c.green })
      hl(0, 'RenderMarkdownWarn', { fg = c.yellow })
      hl(0, 'RenderMarkdownError', { fg = c.red })
      hl(0, 'RenderMarkdownHint', { fg = c.purple })
      hl(0, 'RenderMarkdownQuote', { fg = c.gray })
    end,
  },
}
