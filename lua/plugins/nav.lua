return {
  -- Aerial: LSP/treesitter symbol outline
  {
    'stevearc/aerial.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      backends = { 'lsp', 'treesitter' },
      layout = { max_width = 30, min_width = 20 },
      attach_mode = 'global',
    },
  },
  -- Smart-splits: window navigation & resize (keys in maps.lua)
  { 'mrjones2014/smart-splits.nvim' },

  -- Spider: smarter w/e/b motions (keys in maps.lua)
  { 'chrisgrieser/nvim-spider', lazy = true },

  -- Maximizer: toggle window fullscreen (keys in maps.lua)
  { 'amwadud/nvim-maximizer', lazy = true },

  -- Flash: jump anywhere visible (keys in maps.lua)
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Glance: peek LSP definitions / references
  {
    'dnlhc/glance.nvim',
    cmd = 'Glance',
  },

  -- Oil: file explorer as a buffer (key in maps.lua)
  {
    'stevearc/oil.nvim',
    opts = {
      columns = { 'icon', 'permissions', 'size', 'mtime' },
    },
  },

  -- Oil plugins: diagnostics and git status in Oil
  {
    'JezerM/oil-lsp-diagnostics.nvim',
    event = 'VeryLazy',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {},
  },
  {
    'benomahony/oil-git.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    opts = function()
      local function get_hl(group, attr)
        local ok, val = pcall(vim.api.nvim_get_hl, 0, { name = group })
        return ok and val and string.format('#%06x', val[attr])
      end
      return {
        highlights = {
          OilGitAdded = { fg = get_hl('DiagnosticOk', 'fg') or '#a9b665' },
          OilGitModified = { fg = get_hl('DiagnosticWarn', 'fg') or '#d8a657' },
          OilGitRenamed = { fg = get_hl('Keyword', 'fg') or '#d3869b' },
          OilGitUntracked = { fg = get_hl('Function', 'fg') or '#7daea3' },
          OilGitIgnored = { fg = get_hl('Comment', 'fg') or '#928374' },
        },
      }
    end,
  },

  -- Harpoon: quick file marks (keys in maps.lua)
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    config = function() require('harpoon').setup() end,
  },

  -- Marks: visual indicators for marks a-z
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Satellite: scrollbar with diagnostics, marks, search
  {
    'lewis6991/satellite.nvim',
    event = 'VeryLazy',
    config = true,
  },
}
