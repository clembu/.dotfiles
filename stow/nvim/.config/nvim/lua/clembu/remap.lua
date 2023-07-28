vim.g.mapleader = " "

-- Config
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/clembu/packer.lua<CR>");
vim.keymap.set("n", "<leader>vps", vim.cmd.PackerSync, {desc = "Vim Packer Sync"})
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end, {desc = "Source file"})

-- Navigation --
vim.keymap.set("n", "<leader><Tab>", "<C-^>", {desc = "Alternate buffer"})
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc = "Project view"})
vim.keymap.set("n", "<leader>w", "<C-w>", {desc = "Window manipulation prefix"})
-- TMUX
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Text movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "Move selection up" })
vim.keymap.set("n", "J", "mzJ`z", {desc = "Move next line to end of line" })

-- Jumping adjustments
vim.keymap.set("n", "<C-d>", "<C-d>zz>")
vim.keymap.set("n", "<C-u>", "<C-u>zz>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Search
-- presets substitute with <cword> for quick s&r
vim.keymap.set("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Clipboard
vim.keymap.set("n", "<leader>p", "\"_dP", {desc = "Paste over" })
vim.keymap.set("n", "gp", "\"+p", {desc = "Paste from system" })
vim.keymap.set("n", "gP", "\"+P", {desc = "Paste from system" })
vim.keymap.set("n", "<leader>y", "\"+y", {desc = "Yank to system"})
vim.keymap.set("n", "<leader>Y", "\"+Y", {desc = "Yank rest of line to system"})
vim.keymap.set({"n","v"}, "<leader>d", "\"_d", {desc = "Delete to void" })

-- Buffer manipulation --
vim.keymap.set("n", "<leader>bd", "<cmd>b#|bd#<CR>", {desc = "Delete current buffer"} )

-- Safety net
vim.keymap.set("n", "Q", "<nop>")
