-- To Use packer commands use command :so first
-- bug https://github.com/wbthomason/packer.nvim/issues/834
--
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({ 
	  'rose-pine/neovim', 
	  as = 'rose-pine',
	  config = function()
		vim.cmd('colorscheme rose-pine')
	  end
  })


  use({
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup {
			icons = false,
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	end
})


---  use({ 
---      'gruvbox-community/gruvbox',
---      as = "gruvbox",
---      config = function()
---          vim.cmd('colorscheme gruvbox')
---      end
---  })
--
--use({
--    'UtkarshVerma/molokai.nvim',
--    as = 'molokai',
--    config = function()
--        vim.cmd('colorscheme molokai')
--    end
--})



  use { 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'} }
  use("nvim-treesitter/nvim-treesitter-context");
  use 'nvim-lua/plenary.nvim' 
  use 'ThePrimeagen/harpoon'
  use 'mbbill/undotree'

  use 'tpope/vim-fugitive'
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }
  }

  use 'christoomey/vim-tmux-navigator'
  use("eandrju/cellular-automaton.nvim")
  use 'vim-airline/vim-airline'
  use ({
      'vim-airline/vim-airline-themes',
  })

end)
