return {
  -- Spider: smarter w/e/b motions (camelCase, snake_case aware)
  { 'mrjones2014/smart-splits.nvim' },
  {
    'chrisgrieser/nvim-spider',
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
      { 'ge', "<cmd>lua require('spider').motion('ge')<CR>", mode = { 'n', 'o', 'x' } },
    },
  },
  -- Maximizer: toggle current window fullscreen
  {
    'amwadud/nvim-maximizer',
    keys = { { '<C-m>', '<cmd>MaximizerToggle<CR>' } },
  },
  -- Flash: jump anywhere visible
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        'gs',
        mode = { 'n', 'x', 'o' },
        function() require('flash').jump() end,
        desc = 'Flash',
      },
      {
        'gS',
        mode = { 'n', 'x', 'o' },
        function() require('flash').treesitter() end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function() require('flash').remote() end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function() require('flash').treesitter_search() end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function() require('flash').toggle() end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  -- Glance: peek LSP definitions / references
  {
    'dnlhc/glance.nvim',
    cmd = 'Glance',
  },
  -- Oil: file explorer as a buffer
  {
    'stevearc/oil.nvim',
    opts = {
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
    },
    keys = { { '-', '<CMD>Oil<CR>' } },
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
    event = 'VeryLazy',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {},
  },
  -- Harpoon: quick file marks
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        '<leader>a',
        function() require('harpoon'):list():add() end,
        desc = 'Harpoon add file',
      },
      {
        '<leader>e',
        function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,
        desc = 'Harpoon toggle menu',
      },
      {
        '<leader>1',
        function() require('harpoon'):list():select(1) end,
        desc = 'Harpoon file 1',
      },
      {
        '<leader>2',
        function() require('harpoon'):list():select(2) end,
        desc = 'Harpoon file 2',
      },
      {
        '<leader>3',
        function() require('harpoon'):list():select(3) end,
        desc = 'Harpoon file 3',
      },
      {
        '<leader>4',
        function() require('harpoon'):list():select(4) end,
        desc = 'Harpoon file 4',
      },
    },
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
