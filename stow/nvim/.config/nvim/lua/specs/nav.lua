return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            -- Git-aware project pickers
            { '<leader>pf', '<cmd>Telescope git_files<cr>' },
            { '<leader>ps', '<cmd>Telescope live_grep<cr>' },
            -- Grepping
            { '<leader>pS', '<cmd>Telescope grep_string<cr>' },
            {
                '<leader>pw',
                function()
                    require('telescope.builtin').grep_string({
                        search = vim.fn.expand('<cword>')
                    })
                end
            },
            {
                '<leader>pW',
                function()
                    require('telescope.builtin').grep_string({
                        search = vim.fn.expand('<cWORD>')
                    })
                end
            },
            -- Global helpful listsFind
            { '<leader>lf', '<cmd>Telescope find_files<cr>' },
            { '<leader>lb', '<cmd>Telescope buffers<cr>' },
            { '<leader>lh', '<cmd>Telescope help_tags<cr>' },
        }
    },

    {
        'echasnovski/mini.files',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        version = false,
        keys = {
            { '<leader>fd',
                function()
                    require('mini.files').open(vim.api.nvim_buf_get_name(0))
                end }
        },
        config = function()
            require('mini.files').setup({
                options = {
                    use_as_default_explorer = false
                }
            })
        end
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require('harpoon')
            -- REQUIRED (setup autocmds)
            harpoon:setup()


            -- basic telescope configuration
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end

            vim.keymap.set("n", "<leader>bm", function() harpoon:list():append() end)
            vim.keymap.set("n", "<leader>me", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<leader>lm", function() toggle_telescope(harpoon:list()) end)

            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-:>", function() harpoon:list():select(4) end)

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<leader>bh", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<leader>bl", function() harpoon:list():next() end)
        end
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>td", "<cmd>TroubleToggle<cr>" },
            { "<leader>lt", "<cmd>TodoTrouble<cr>" },
            {
                "<leader>dl", function()
                require('trouble').next({ skip_groups = true, jump = true })
            end
            },
            {
                "<leader>dh", function()
                require('trouble').previous({ skip_groups = true, jump = true })
            end
            }
        },
        opts = {},
    }
}
