local lsp = require('lsp-zero').preset({})

lsp.nvim_workspace()

require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "clangd" },
}

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-j>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-k>'] = cmp.mapping.select_next_item(cmp_select),
})
lsp.setup_nvim_cmp({ mapping = cmp_mappings })


lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- Inspection
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>hd", function() vim.diagnostic.open_float() end, opts)

    -- Navigation
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "(d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", ")d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.format() end, opts)

    -- Refactoring
    vim.keymap.set("n", "<leader>ra", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)

    -- Inline help
    vim.keymap.set("i", "<C-i>", function() vim.lsp.buf.signature_help() end, opts)
end)

require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            }
            ,
            diagnostics = {
                disable = {
                    "lowercase-global"
                }
            }
        }
    }
})

require('lspconfig').ocamllsp.setup{}

local nls = require('null-ls')
nls.setup({
    sources = {
        nls.builtins.formatting.clang_format.with({
            prefer_local = "lib/linux_x86_64_glibc_228/llvm/bin"
        })
    }
})

lsp.setup()
