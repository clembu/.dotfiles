local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>bh', ui.toggle_quick_menu, {desc = "See harpooned files"})
vim.keymap.set('n', '<leader>bm', mark.add_file, {desc = "Harpoon current file"})
vim.keymap.set('n', '<leader>bj', function()ui.nav_file(1)end, {desc = "Go to file 1"})
vim.keymap.set('n', '<leader>bk', function()ui.nav_file(2)end, {desc = "Go to file 2"})
vim.keymap.set('n', '<leader>bl', function()ui.nav_file(3)end, {desc = "Go to file 3"})
vim.keymap.set('n', '<leader>b:', function()ui.nav_file(4)end, {desc = "Go to file 4"})
