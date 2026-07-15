local dir = '/home/hrn/wrk/nvim/quoteboard.nvim'
if vim.fn.isdirectory(dir) == 0 then return {} end

return {
  dir = dir,
  opts = { startup = false, keymap = '<leader>qb' },
}
