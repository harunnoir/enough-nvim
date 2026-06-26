-- lualine.lua
-- Philosophy: gruvbox-material aware, flat, minimal, reactive, graceful

local function get_hl(group, attr)
  local ok, val = pcall(vim.api.nvim_get_hl, 0, { name = group })
  return ok and val and string.format('#%06x', val[attr])
end

-- ── Palette ─────────────────────────────────────────────────────────────────

local function palette()
  return {
    fg = get_hl('Normal', 'fg') or '#d4be98',
    bg = get_hl('Normal', 'bg') or '#32302f',
    comment = get_hl('Comment', 'fg') or '#928374',
    green = get_hl('DiagnosticOk', 'fg') or '#a9b665',
    warning = get_hl('DiagnosticWarn', 'fg') or '#d8a657',
    error = get_hl('DiagnosticError', 'fg') or '#ea6962',
    info = get_hl('DiagnosticInfo', 'fg') or '#7daea3',
    cyan = get_hl('Function', 'fg') or '#7daea3',
    yellow = get_hl('Type', 'fg') or '#d8a657',
    purple = get_hl('Keyword', 'fg') or '#d3869b',
  }
end

-- ── Mode ─────────────────────────────────────────────────────────────────────

local mode_map = {
  n = 'N',
  i = 'I',
  v = 'V',
  V = 'V',
  ['\22'] = 'V',
  s = 'S',
  S = 'S',
  ['\19'] = 'S',
  c = 'C',
  t = 'T',
  R = 'R',
  r = 'R',
}

local function mode_color(c)
  local colors = {
    n = c.comment,
    i = c.green,
    v = c.cyan,
    V = c.cyan,
    ['\22'] = c.cyan,
    s = c.purple,
    S = c.purple,
    ['\19'] = c.purple,
    c = c.yellow,
    R = c.error,
    r = c.error,
    t = c.purple,
  }
  return colors[vim.fn.mode()] or c.fg
end

-- ── Components ───────────────────────────────────────────────────────────────

local function macro_recording(c)
  return {
    function()
      local reg = vim.fn.reg_recording()
      return reg ~= '' and '  @' .. reg or ''
    end,
    color = { fg = c.warning, bg = c.bg },
  }
end

local function mode_indicator(c)
  return {
    function() return mode_map[vim.fn.mode()] or '?' end,
    color = function() return { fg = c.bg, bg = mode_color(palette()), gui = 'bold' } end,
    padding = { left = 1, right = 1 },
  }
end

local function filename(c)
  return {
    'filename',
    path = 1,
    color = { fg = c.fg, bg = c.bg },
    symbols = { modified = ' +', readonly = ' ', unnamed = '[?]' },
  }
end

local function branch(c)
  return {
    'branch',
    icon = ' ',
    fmt = function(name)
      if name == '' then
        return ''
      end
      -- truncate long branch names: feat/my-long-feature → f›my-long-feature
      local segments = {}
      for s in name:gmatch('[^/]+') do
        table.insert(segments, s)
      end
      if #segments == 1 then
        return name
      end
      local prefix =
        table.concat(vim.tbl_map(function(s) return s:sub(1, 1) end, { unpack(segments, 1, #segments - 1) }))
      local result = prefix .. '›' .. segments[#segments]
      return #result > 20 and result:sub(1, 20) .. '…' or result
    end,
  }
end

local function search(c)
  return {
    'searchcount',
  }
end

local function tooling(c)
  return {
    function()
      local parts = {}
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients > 0 then
        table.insert(parts, ' ' .. table.concat(vim.tbl_map(function(cl) return cl.name end, clients), ','))
      end
      local ok_fmt, conform = pcall(require, 'conform')
      local formatters = ok_fmt and conform.list_formatters(0) or {}
      if #formatters > 0 then
        table.insert(parts, '󰉿 ' .. table.concat(vim.tbl_map(function(x) return x.name end, formatters), ','))
      end
      local ok_lint, lint = pcall(require, 'lint')
      local linters = ok_lint and (lint.linters_by_ft[vim.bo.filetype] or {}) or {}
      if #linters > 0 then
        table.insert(parts, '󱉶 ' .. table.concat(linters, ','))
      end
      return table.concat(parts, ' ')
    end,
    cond = function() return vim.fn.winwidth(0) > 80 end,
  }
end

local function venv(c)
  return {
    function()
      local env = vim.env.VIRTUAL_ENV
      if not env then
        return ''
      end
      return ' ' .. vim.fn.fnamemodify(env, ':t')
    end,
    color = { fg = c.green, bg = c.bg },
    cond = function() return vim.bo.filetype == 'python' and vim.fn.winwidth(0) > 80 end,
  }
end

local function diagnostics(c)
  return {
    'diagnostics',
    color = { bg = c.bg },
    symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
    diagnostics_color = {
      error = { fg = c.error },
      warn = { fg = c.warning },
      info = { fg = c.info },
      hint = { fg = c.comment },
    },
  }
end

local function diff(c)
  return {
    'diff',
    colored = true,
    color = { added = { fg = c.green }, modified = { fg = c.cyan }, removed = { fg = c.error } },
    symbols = { added = '+', modified = '~', removed = '-' },
  }
end

-- ── Setup ────────────────────────────────────────────────────────────────────

local function setup()
  local c = palette()

  require('lualine').setup({
    options = {
      theme = {
        normal = { a = { fg = c.fg, bg = c.bg }, b = { fg = c.fg, bg = c.bg }, c = { fg = c.fg, bg = c.bg } },
        inactive = {
          a = { fg = c.comment, bg = c.bg },
          b = { fg = c.comment, bg = c.bg },
          c = { fg = c.comment, bg = c.bg },
        },
      },
      globalstatus = true,
      component_separators = '',
      section_separators = '',
      disabled_filetypes = { statusline = { 'snacks_dashboard', 'oil' } },
    },
    sections = {
      lualine_a = { branch(c) },
      lualine_b = { filename(c), diff(c) },
      lualine_c = {},
      lualine_x = {
        macro_recording(c),
        diagnostics(c),
        search(c),
        tooling(c),
        venv(c),
      },
      lualine_y = {},
      lualine_z = { mode_indicator(c) },
    },
  })
  vim.o.laststatus = 3
end

return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      setup()
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('LualineAdaptive', { clear = true }),
        callback = setup,
      })
    end,
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
  { 'kungfusheep/mfd.nvim', event = 'VeryLazy' },
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
  -- {
  --   'akinsho/toggleterm.nvim',
  --   version = '*',
  --   keys = {
  --     { '<C-\\>', '<CMD>ToggleTerm<CR>', desc = 'Toggle terminal' },
  --   },
  --   opts = {
  --     direction = 'horizontal',
  --     open_mapping = '<C-\\>',
  --   },
  -- },
}
