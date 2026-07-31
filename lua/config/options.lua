-- Editor options.

-- General
vim.o.termguicolors = true
vim.o.laststatus = 3
vim.o.ttimeoutlen = 50

-- Mouse
vim.o.mouse = 'a'
vim.o.mousescroll = 'ver:3,hor:6'
vim.o.mousemoveevent = false

-- UI
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
vim.opt.shortmess:append('c')
vim.opt.list = true
vim.opt.listchars = {
    space = '·',
    tab = '↦ ',
    -- eol = '↲',
    -- extends = '»',
    -- precedes = '«',
    nbsp = '␣',
    trail = '›',
}

vim.opt.fillchars = {
    eob = ' ',
}

vim.opt.cursorline = true

-- Editor behavior
vim.o.wrap = false
vim.o.incsearch = true
vim.o.hlsearch = false

-- Line numbers
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

-- Files and buffers
vim.o.hidden = true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false

-- Clipboard and spelling
vim.o.clipboard = 'unnamedplus'
vim.o.spell = false

-- Autocomplete
vim.opt.completeopt = 'menuone,noselect'

-- Keybindings
vim.g.mapleader = ' '

-- GUI font
vim.o.guifont = 'IosevkaTerm Nerd Font:h14'
