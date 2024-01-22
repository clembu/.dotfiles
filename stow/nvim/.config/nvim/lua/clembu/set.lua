-- Line numbering
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'number'

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line width
vim.opt.wrap = false
vim.opt.textwidth = 80

-- History
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Colors
vim.opt.termguicolors = true

-- Windowing
vim.opt.scrolloff = 8
vim.opt.laststatus = 3

-- File handling
-- This one helps vim think `@` can be part of a filename
vim.opt.isfname:append('@-@')
vim.opt.updatetime = 50

-- WHITESPACE
vim.opt.listchars = 'tab:> ,trail:-,nbsp:+,eol:\\u21b5,extends:\\u2026,precedes:\\u2026'
