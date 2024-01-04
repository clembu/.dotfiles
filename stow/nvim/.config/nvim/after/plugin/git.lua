require('neogit').setup{kind='replace'}
vim.keymap.set('n', '<leader>gg', function () require('neogit').open() end, {desc = 'Git Status'})

require('blame').setup()
vim.keymap.set('n', '<leader>gb', vim.cmd.ToggleBlame, {desc = 'Git Blame'})

