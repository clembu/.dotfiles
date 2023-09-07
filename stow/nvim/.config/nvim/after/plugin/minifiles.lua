require('mini.files').setup({
    options = {
        use_as_default_explorer = false
    }
})

vim.keymap.set('n', '<leader>fd', function() require('mini.files').open() end, { desc = 'Fiddle with directory' })
