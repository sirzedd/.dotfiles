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

  -- Added 2024-07-29
  use({
    'MeanderingProgrammer/markdown.nvim',
    as = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    after = { 'nvim-treesitter' },
    requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
    -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
    --requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    config = function()
        require('render-markdown').setup({})
    end,
})

-- easy moving around with f and F, t and T
--use 'justinmk/vim-sneak'

use {
  'smoka7/hop.nvim',
  tag = '*',
  config = function()
    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  end
}

-- better : prompts
use {
  'gelguy/wilder.nvim',
  config = function()
    -- config goes here
  end,
}

use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
}

use({
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup()
  end,
})


use({
  "HakonHarnes/img-clip.nvim",
  config = function()
    require("img-clip").setup({
      opts = {
    -- add options here
    -- or leave it empty to use the default settings
      },
      keys = {
        -- suggested keymap
        { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
      },

    })
  end,

})

-- install without yarn or npm

use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })


-- use 'ekickx/clipboard-image.nvim'

-- https://github.com/ekickx/clipboard-image.nvim
-- use({
--   "ekickx/clipboard-image.nvim",
--   config = function()
--     require("clipboard-image").setup({
--       default = {
--         img_dir = "attachments/imgs",
--         img_dir_txt = "attachments/imgs"
--       }
--     })
--   end,
--   })

-- https://github.com/epwalsh/obsidian.nvim
use({
  "epwalsh/obsidian.nvim",
  tag = "*",  -- recommended, use latest release instead of latest commit
  requires = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  config = function()
    require("obsidian").setup({
      ui = { enable=false},
      workspaces = {
        {
          name = "work",
          path = "~/vaultlocation",
        },
      },
       attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "attachments/imgs",  -- This is the default
         -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
        ---@return string
        img_name_func = function()
          -- Prefix image names with timestamp.
          return string.format("%s-", os.time())
        end,
    },
      -- see below for full list of options 👇
      -- Either 'wiki' or 'markdown'.
    preferred_link_style = "wiki",
      -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({"open", url})  -- Mac OS
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
    end,

    })
  end,
})


-- use({
--   "epwalsh/pomo.nvim",
--   tag = "*",  -- Recommended, use latest release instead of latest commit
--   requires = {
--     -- Optional, but highly recommended if you want to use the "Default" timer
--     "rcarriga/nvim-notify",
--   },
--   config = function()
--     require("pomo").setup({
--       -- See below for full list of options 👇
--     })
--   end,
-- })


-- end adding

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
 -- use 'ThePrimeagen/harpoon' legacy

use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
}

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
