return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "rust",
                    "javascript",
                    "typescript"
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
        'folke/todo-comments.nvim',
        config = function()
            require('todo-comments').setup()
        end
    },
}
