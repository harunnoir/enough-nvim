-- Neovim Options

-- General
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.laststatus = 3
vim.o.ttimeoutlen = 50

-- UI
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
vim.opt.shortmess:append('c')
vim.opt.list = true
vim.opt.listchars = {
  space = '·', -- ·
  tab = '↦ ',
  eol = '↲', -- ↲
  extends = '»',
  precedes = '«',
  nbsp = '␣',
  trail = '›',
}

vim.opt.fillchars = {
  eob = ' ',
}
vim.opt.cursorline = true

-- Editor Behavior
vim.o.wrap = false
vim.o.incsearch = true
vim.o.hlsearch = false

-- Line Numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.nrformats = 'unsigned'

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Indent
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Files & Buffers
vim.o.hidden = true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false

vim.o.clipboard = 'unnamedplus'
vim.o.spell = false

-- Autocomplete
vim.opt.completeopt = 'menuone,noselect'

-- Keybindings
vim.g.mapleader = ' '

-- Font
vim.o.guifont = 'VictorMono Nerd Font:h10'
