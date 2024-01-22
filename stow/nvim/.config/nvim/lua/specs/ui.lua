return {
    {
        'catppuccin/nvim',
        priority = 1000,
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup({
                flavour = 'mocha',
                transparent_background = true,
                term_colors = false,
            })
            vim.cmd.colorscheme('catppuccin')
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            presets = {
                command_palette = true,
                bottom_search = true,
                lsp_doc_border = true,
            },
            notify = { enabled = false },
            messages = { enabled = false },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        }
    }
}
