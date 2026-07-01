return {
  {
    'sschleemilch/slimline.nvim',
    opts = {
      style = 'fg',
      components = {
        left = { 'mode', 'path', 'git' },
        center = {
          function()
            local rec = vim.fn.reg_recording()
            return rec ~= '' and 'recording @' .. rec or ''
          end,
          function() return vim.t.maximized and ' 󰊓 ' or '' end,
        },
        right = {
          'diagnostics',
          function()
            local buf = vim.api.nvim_get_current_buf()
            local formatters = require('conform').list_formatters(buf)
            if #formatters == 0 then
              return ''
            end
            return ' ' .. formatters[1].name
          end,
          'filetype_lsp',
        },
      },
      hl = {
        base = 'StatusLine',
        base_inactive = 'StatusLineNC',
        primary = 'StatusLine',
        secondary = 'StatusLineNC',
      },
      configs = {
        progress = {
          follow = false,
        },
      },
      spaces = {
        components = '',
        left = '',
        right = '',
      },
      disabled_filetypes = { 'snacks_dashboard', 'oil', 'toggleterm' },
    },
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'dark'
      vim.g.gruvbox_material_background = 'medium'
      vim.cmd.colorscheme('gruvbox-material')
    end,
  },
  --[[ {
    'luukvbaal/statuscol.nvim',
    event = 'BufReadPre',
    config = function()
      local builtin = require('statuscol.builtin')

      require('statuscol').setup({
        relculright = true,
        segments = {
          -- Fold column (thin chars via fillchars)
          {
            text = { builtin.foldfunc, ' ' },
            click = 'v:lua.ScFa',
            hl = 'FoldColumn',
          },
          -- Git signs
          {
            sign = { namespace = { 'gitsigns' }, maxwidth = 1, colwidth = 1, auto = false },
            click = 'v:lua.ScSa',
          },
          -- Diagnostics
          {
            sign = { namespace = { 'diagnostic/signs' }, maxwidth = 1, colwidth = 1, auto = false },
            click = 'v:lua.ScSa',
          },
          -- Todo-comments + DAP + everything else
          {
            sign = { name = { '.*' }, maxwidth = 1, colwidth = 1, auto = true, wrap = true },
            click = 'v:lua.ScSa',
          },
          -- Line number
          {
            text = { builtin.lnumfunc, ' ' },
            condition = { true, builtin.not_empty },
            click = 'v:lua.ScLa',
          },
        },
      })
    end,
  }, ]]
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies = { 'amansingh-afk/milli.nvim' },
    opts = function()
      local splash = require('milli').load({ splash = 'batmancatman' })
      return {
        dashboard = {
          enabled = true,
          preset = {
            header = table.concat(splash.frames[1], '\n'),
            keys = {
              { icon = '󰈞 ', desc = 'Find File', key = 'f', action = ':lua Snacks.picker.files()' },
              { icon = '󰍉 ', desc = 'Grep', key = 'g', action = ':lua Snacks.picker.grep()' },
              {
                icon = ' ',
                desc = 'Config',
                key = 'c',
                action = ':lua Snacks.picker.files({cwd = vim.fn.stdpath("config")})',
              },
              { icon = '󰑖 ', desc = 'Recent', key = 'r', action = ':lua Snacks.picker.recent()' },
              { icon = '󰩈 ', desc = 'Quit', key = 'q', action = ':qa' },
            },
          },
          sections = {
            { section = 'header', padding = 1 },
            { section = 'keys', gap = 1, padding = 1 },
            { section = 'startup' },
          },
        },
        bigfile = { enabled = true },
        bufdelete = { enabled = true },
        git = { enabled = true },
        gitbrowse = { enabled = true },
        lazygit = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        words = { enabled = true },
        picker = {
          enabled = true,
          prompt = '   ',
          layout = {
            cycle = true,
            preset = 'ivy',
          },
          icons = {
            ui = {
              selected = '󱞩 ',
            },
          },
          win = {
            list = { border = 'rounded' },
            preview = { border = 'rounded' },
          },
        },
        notifier = { enabled = false },
        animate = { enabled = true },
        scroll = { enabled = true },
        dim = { enabled = false },
        scratch = { enabled = false },
        image = { enabled = false },
        statuscolumn = {
          enabled = true,
          refresh = 50,
          left = { 'sign', 'mark', 'git' },
          right = { 'fold' },
          folds = { open = true, git_hl = true },
          git = { patterns = { 'GitSign', 'MiniDiffSign' } },
        },
      }
    end,
    config = function(_, opts)
      require('snacks').setup(opts)
      require('milli').snacks({ splash = 'batmancatman', loop = true })
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = false,
        inc_rename = false,
        lsp_doc_border = false,
      },
      cmdline = {
        format = {
          cmdline = {
            pattern = '^:',
            icon = ' ',
            lang = 'vim',
          },
          search_down = {
            kind = 'search',
            pattern = '^/',
            icon = ' ',
            lang = 'regex',
          },
          search_up = {
            kind = 'search',
            pattern = '^%?',
            icon = ' ',
            lang = 'regex',
          },
          filter = {
            pattern = '^:%s*!',
            icon = '$',
            lang = 'bash',
          },
          lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
          help = { pattern = '^:%s*he?l?p?%s+', icon = '󰋖' },
          input = { view = 'cmdline_input', icon = '󰥻 ' },
        },
      },
      views = {
        cmdline_popup = {
          position = { row = 0, col = '50%' },
          size = { width = '40%', height = 'auto' },
          border = { style = 'rounded' },
          win_options = { winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder' },
        },
        popupmenu = {
          relative = 'editor',
          position = { row = 2, col = '50%' },
          size = { width = '40%', height = 10 },
          border = { style = 'rounded' },
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },
  {
    'gbprod/yanky.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'lukas-reineke/virt-column.nvim',
    event = 'VeryLazy',
    opts = {
      char = '│',
      highlight = 'NonText',
    },
  },
  {
    'stevearc/quicker.nvim',
    ft = 'qf',
    opts = {},
  },
  { 'folke/todo-comments.nvim', event = 'VeryLazy', dependencies = { 'nvim-lua/plenary.nvim' }, config = true },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    opts = {
      default = true,
    },
  },
  {
    'hat0uma/csvview.nvim',
    opts = {
      parser = { comments = { '#', '//' } },
      keymaps = {
        textobject_field_inner = { 'if', mode = { 'o', 'x' } },
        textobject_field_outer = { 'af', mode = { 'o', 'x' } },
        jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
        jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
        jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
        jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
      },
    },
    cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
  },
  --[[ {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>?',
        function() require('which-key').show({ global = false }) end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  }, ]]
  -- smart-splits keys registered in maps.lua
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<C-\\>', '<CMD>ToggleTerm<CR>', desc = 'Toggle terminal' },
    },
    opts = {
      direction = 'vertical',
      size = 60,
      open_mapping = '<C-\\>',
    },
  },
}
