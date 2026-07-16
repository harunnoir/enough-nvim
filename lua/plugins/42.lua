-- 42 School: header

return {
  {
    'Diogo-ss/42-header.nvim',
    cmd = { 'Stdheader' },
    keys = { '<leader>42' },
    opts = {
      default_map = true, -- Default mapping <F1> in normal mode.
      auto_update = true, -- Update header when saving.
      -- user = 'abait-el', -- Your user.
      -- mail = 'abait-el@student.1337.ma', -- Your mail.
      -- add other options.
    },
    config = function(_, opts)
      require('42header').setup(opts)
      vim.keymap.set('n', '<leader>42', '<cmd>Stdheader<cr>', { desc = '42 header' })
    end,
  },
  {
    'hardyrafael17/norminette42.nvim',
    config = function()
      local norminette = require('norminette')
      norminette.setup({
        runOnSave = true,
        maxErrorsToShow = 5,
        active = true,
      })
    end,
  },
}
