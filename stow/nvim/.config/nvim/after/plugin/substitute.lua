vim.keymap.set("n", "gx", require('substitute').operator, { noremap = true })
vim.keymap.set("x", "gx", require('substitute').visual, { noremap = true })
