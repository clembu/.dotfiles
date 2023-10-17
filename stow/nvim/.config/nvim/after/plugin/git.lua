require('neogit').setup{kind='replace'}
vim.keymap.set('n', '<leader>gg', function () require('neogit').open() end, {desc = 'Git Status'})
