local function fix_gruvbox_functions()
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
  local hl = function(name, opts) vim.api.nvim_set_hl(0, name, opts) end

  -- Floats & Completion
  hl('FloatBorder', { fg = c.bg3, bg = c.bg1 })
  hl('NormalFloat', { bg = c.bg1 })
  hl('BlinkCmpMenu', { bg = c.bg1 })
  hl('BlinkCmpMenuBorder', { fg = c.bg3, bg = c.bg1 })
  hl('BlinkCmpDoc', { bg = c.bg1 })
  hl('BlinkCmpDocBorder', { fg = c.bg3, bg = c.bg1 })

  -- LSP / Treesitter
  hl('@parameter', { italic = true })
  hl('@lsp.type.parameter', { italic = true })
  hl('@lsp.type.parameter.python', { italic = true })

  -- Oil Git
  hl('OilGitAdded', { fg = c.green })
  hl('OilGitModified', { fg = c.yellow })
  hl('OilGitRenamed', { fg = c.purple })
  hl('OilGitUntracked', { fg = c.aqua })
  hl('OilGitIgnored', { fg = c.gray })
  hl('OilGitDeleted', { fg = c.red })

  -- Oil
  hl('OilDir', { fg = c.fg, bold = true })
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
