-- [[ BACKUP of previous lualine config ]] --
-- Original author: harunnoir (enough-nvim)

local function get_hl(group, attr)
  local ok, val = pcall(vim.api.nvim_get_hl, 0, { name = group })
  return ok and val and string.format('#%06x', val[attr])
end

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

return { setup = setup }
