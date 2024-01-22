return {
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<cr>')
        end
    },
    {
        'NeogitOrg/neogit',
        keys = {
            { '<leader>gg', function()
                require('neogit').open()
            end }
        },
        config = function()
            require('neogit').setup { kind = 'replace' }
        end
    },
    {
        'FabijanZulj/blame.nvim',
        keys = {
            { '<leader>gb', '<cmd>ToggleBlame<cr>' }
        },
        config = function()
            require('blame').setup()
        end
    },
}
