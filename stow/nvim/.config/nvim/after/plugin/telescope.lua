local builtin = require('telescope.builtin')

-- Git-aware project pickers
vim.keymap.set('n', '<leader>pf', builtin.git_files, {desc = "List files in project"})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {desc = "Search in project"})
vim.keymap.set('n', '<leader>pS', builtin.grep_string, {desc = "Search <cword> in project"})

-- Global helpful listsFind
vim.keymap.set('n', '<leader>lf', builtin.find_files, {desc = "List files in cwd"})
vim.keymap.set('n', '<leader>lb', builtin.buffers, {desc = "List open buffers"})
vim.keymap.set('n', '<leader>lh', builtin.help_tags, {desc = "List help tags"})
