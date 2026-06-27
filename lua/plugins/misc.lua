return {
  -- Mini.clue: which-key replacement (shows leader tree)
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      require('mini.clue').setup({
        triggers = {
          { mode = 'n', keys = '<Leader>' },
        },
        clues = {
          require('mini.clue').gen_clues.builtin_completion(),
          require('mini.clue').gen_clues.g(),
          require('mini.clue').gen_clues.marks(),
          require('mini.clue').gen_clues.registers(),
          require('mini.clue').gen_clues.windows(),
          require('mini.clue').gen_clues.z(),
        },
        window = { delay = 300 },
      })
    end,
  },

  -- Haunt: bookmark / annotate lines (keys in maps.lua)
  {
    'TheNoeTrevino/haunt.nvim',
    opts = {
      sign                = '󱙝',
      sign_hl             = 'HauntAnnotation',
      virt_text_hl        = 'HauntAnnotation',
      annotation_prefix   = ' 󰆉 ',
      annotation_suffix   = '',
      line_hl             = nil,
      virt_text_pos       = 'eol',
      data_dir            = nil,
      per_branch_bookmarks = true,
      picker              = 'auto',
      picker_keys = {
        delete          = { key = 'd', mode = { 'n' } },
        edit_annotation = { key = 'a', mode = { 'n' } },
      },
    },
    config = function(_, opts) require('haunt').setup(opts) end,
  },

  -- Hardtime: discourage bad movement habits
  {
    'm4xshen/hardtime.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
  },

  -- Mini.hipatterns: highlight hex colors inline
  {
    'nvim-mini/mini.hipatterns',
    version = '*',
    event = 'VeryLazy',
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = { hex_color = hipatterns.gen_highlighter.hex_color() },
      })
    end,
  },

  -- Calcium: in-buffer calculator
  {
    'necrom4/calcium.nvim',
    cmd  = { 'Calcium' },
    opts = {},
  },

  -- Nerdy: Nerd Font icon browser (keys in maps.lua)
  {
    '2kabhishek/nerdy.nvim',
    dependencies = { 'folke/snacks.nvim' },
    cmd  = 'Nerdy',
    opts = {
      max_recents      = 30,
      copy_to_clipboard = false,
      copy_register    = '+',
    },
  },

  -- StartupTime: debug startup performance
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },

  -- Typr: typing tutor
  {
    'nvzone/typr',
    dependencies = 'nvzone/volt',
    opts = {},
    cmd  = { 'Typr', 'TyprStats' },
  },

  -- Undotree: visual undo tree (key in maps.lua)
  {
    'jiaoshijie/undotree',
    opts = {},
  },

  -- Leetcode: practice in Neovim
  {
    'kawre/leetcode.nvim',
    cmd   = 'Leet',
    build = ':TSUpdate html',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    opts = {},
  },

  -- Persistence: auto-save / restore sessions
  {
    'folke/persistence.nvim',
    event = 'VeryLazy',
    opts  = {},
  },

  -- Presenting: presentation mode
  {
    'harunnoir/presenting.nvim',
    opts = {},
    cmd  = { 'Presenting' },
  },
}
