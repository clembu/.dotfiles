vim.g.mapleader = " "

-- Config
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/specs<CR>");
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end, { desc = "Source file" })

-- Navigation
vim.keymap.set("n", "<leader><Tab>", "<C-^>", { desc = "Alternate buffer" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project view" })
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Window manipulation prefix" })

-- Quick Toggles
vim.keymap.set("n", "<leader>tw", function ()
    local state = vim.opt.list:get()
    vim.opt.list = not state
end, {desc = "Toggle whitespace display"});

-- Text movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Move next line to end of line" })

-- Jumping adjustments
vim.keymap.set("n", "<C-d>", "<C-d>zz>")
vim.keymap.set("n", "<C-u>", "<C-u>zz>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Search
-- presets substitute with <cword> for quick s&r
vim.keymap.set("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Clipboard
vim.keymap.set("n", "<leader>p", "\"_dP", { desc = "Paste over" })
vim.keymap.set("n", "gp", "\"+p", { desc = "Paste from system" })
vim.keymap.set("n", "gP", "\"+P", { desc = "Paste from system" })
vim.keymap.set("v", "gp", "\"+p", { desc = "Paste from system" })
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to system" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank rest of line to system" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to system" })
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete to void" })

-- Buffer manipulation --
vim.keymap.set("n", "<leader>bd", "<cmd>b#|bd#<CR>", { desc = "Delete current buffer" })

-- Safety net
vim.keymap.set("n", "Q", "<nop>")

-- LSP autocmd
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('SmugAUG', {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>ht', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>hd', vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ra', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rf', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
