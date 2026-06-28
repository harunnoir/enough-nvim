return {
  -- 99: AI chat in Neovim (keys in maps.lua under <leader>9)
  {
    'ThePrimeagen/99',
    lazy = true,
    config = function()
      local _99    = require('99')
      local cwd    = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)
      _99.setup({
        model  = 'opencode/big-pickle',
        logger = {
          level          = _99.DEBUG,
          path           = '/tmp/' .. basename .. '.99.debug',
          print_on_error = true,
        },
        tmp_dir    = vim.fn.stdpath('data') .. '/99/tmp',
        completion = {
          custom_rules = { vim.fn.stdpath('data') .. '/99/custom_rules/' },
          files        = {},
          source       = 'native',
        },
        md_files = { 'AGENT.md' },
      })
    end,
  },
}
