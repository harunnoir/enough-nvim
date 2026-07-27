--[[ return {
    dir = "/home/hrn/wrk/nvim/cold.nvim",
    name = "cold.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cold").setup({
        transparent = false,
        terminal_colors = true,
        italics = {
          comments = false,
        },
      })

      vim.cmd.colorscheme("cold")
    end,
  } ]]
return {}
