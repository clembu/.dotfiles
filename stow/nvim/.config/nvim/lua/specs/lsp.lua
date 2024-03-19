local mason = {
    "williamboman/mason.nvim",
    config = function()
        require('mason').setup()
    end
}

local none_ls = {
    'nvimtools/none-ls.nvim',
    config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier.with({
                    prefer_local = 'node_modules/.bin',
                    filetypes = {
                        'javascript',
                        'javascriptreact',
                        'typescript',
                        'typescriptreact',
                        'vue',
                        'css',
                        'scss',
                        'less',
                        'html',
                        'json',
                        'jsonc',
                        'yaml',
                        'svelte',
                    },
                }),
            },
        })
    end,
}

local function setup_lua_ls()
    require 'lspconfig'.lua_ls.setup {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            }
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        }
                    }
                })
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
            return true
        end
    }
end

local mason_lspconfig = {
    'williamboman/mason-lspconfig.nvim',
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                lua_ls = setup_lua_ls,
            }
        })
    end
}

local lspconfig = {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        require('lspconfig').ocamllsp.setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        })
        require('lspconfig').gleam.setup({})
        vim.diagnostic.config({
            update_on_insert = true,
            float = {
                style = 'minimal',
                border = 'rounded',
                source = 'always',
                header = '',
                prefix = ''
            }
        })
    end
}

local cmp = {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        { 'L3MON4D3/LuaSnip' },
    },
    config = function()
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }
                },
                {
                    { name = 'buffer' },
                }
            ),
            formatting = {
                -- changing the order of fields so the icon is the first
                fields = { 'menu', 'abbr', 'kind' },
                -- here is where the change happens
                format = function(entry, item)
                    local menu_icon = {
                        nvim_lsp = 'L',
                        luasnip = 'S',
                        buffer = 'B',
                        path = 'P',
                        nvim_lua = 'N',
                    }

                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.confirm({ select = false }),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-j>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
                ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
            })
        })
        local ls = require('luasnip')
        vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, { silent = true })
    end
}

return {
    mason,
    mason_lspconfig,
    cmp,
    lspconfig,
    none_ls,
    {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup()
        end
    }
}
