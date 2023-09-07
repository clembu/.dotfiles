vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-- NAVIGATION
	use {
		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'theprimeagen/harpoon'
	use 'tpope/vim-unimpaired'

	-- HISTORY
	use 'mbbill/undotree'
	use 'tpope/vim-fugitive'

	-- CODE
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use 'nvim-treesitter/playground'
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.api.nvim_command, 'MasonUpdate')
				end,
			},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	}

    use {
        'folke/zen-mode.nvim',
        requires = {
            { 'folke/twilight.nvim' }
        }
    }
	-- MOTIONS, TEXTOBJECTS
	use 'tpope/vim-surround'
	use 'gbprod/substitute.nvim'

	-- COLORS
	use {
		'catppuccin/nvim',
		as = 'catppuccin'
	}
end)
