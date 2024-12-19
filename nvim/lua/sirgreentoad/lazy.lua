--https://lazy.folke.io/usage
--vim.go.loadplugins = false

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
--require("lazy").setup({
--  spec = {
--    -- import your plugins
--    { import = "plugins" },
--  },
--  -- Configure any other settings here. See the documentation for more details.
--  -- colorscheme that will be used when installing plugins.
--  install = { colorscheme = { "habamax" } },
--  -- automatically check for plugin updates
--  checker = { enabled = true },
--})

require('lazy').setup({
{
  'nvim-telescope/telescope.nvim', tag = '0.1.4',
  -- or                            , branch = '0.1.x',
  dependencies = { {'nvim-lua/plenary.nvim'} }
},

-- Added 2024-07-29
{
    'MeanderingProgrammer/render-markdown.nvim',
--    lazy = true,
    enabled = function() 
     local max_filesize = 2 * 1024 * 1024 -- 2 MB
     local file = vim.fn.expand("%:p")
     return not (vim.fn.getfsize(file) > max_filesize)
--     return false
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
    -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    config = function()
        require('render-markdown').setup({
    checkbox = {
            -- Turn on / off checkbox state rendering
            enabled = true,
            -- Determines how icons fill the available space:
            --  inline:  underlying text is concealed resulting in a left aligned icon
            --  overlay: result is left padded with spaces to hide any additional text
            position = 'inline',
            unchecked = {
                -- Replaces '[ ]' of 'task_list_marker_unchecked' 󰄱
                icon = '󰄱 ',
                -- Highlight for the unchecked icon
                highlight = 'RenderMarkdownUnchecked',
            },
            checked = {
                -- Replaces '[x]' of 'task_list_marker_checked' 󰱒
                icon = '󰱒 ',
                -- Highligh for the checked icon
                highlight = 'RenderMarkdownChecked',
            },
            -- Define custom checkbox states, more involved as they are not part of the markdown grammar
            -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
            -- Can specify as many additional states as you like following the 'todo' pattern below
            --   The key in this case 'todo' is for healthcheck and to allow users to change its values
            --   'raw':       Matched against the raw text of a 'shortcut_link'
            --   'rendered':  Replaces the 'raw' value when rendering
            --   'highlight': Highlight for the 'rendered' icon  [-]
            custom = {
                todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
            },
        },
        bullet = {
            -- Turn on / off list bullet rendering
            enabled = true,
            -- Replaces '-'|'+'|'*' of 'list_item'
            -- How deeply nested the list is determines the 'level'
            -- The 'level' is used to index into the array using a cycle
            -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
            icons = { '●', '○', '◆', '◇' },
            -- Padding to add to the left of bullet point
            left_pad = 0,
            -- Padding to add to the right of bullet point
            right_pad = 0,
            -- Highlight for the bullet icon
            highlight = 'RenderMarkdownBullet',
        },
    
})
    end,
},

{
  'echasnovski/mini.nvim',
   lazy = true,
},
{
'towolf/vim-helm',
lazy = true,
},

{
  'smoka7/hop.nvim',
  tag = '*',
  lazy = true,
  config = function()
    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  end
},


{
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup()
  end,
},


{
  "HakonHarnes/img-clip.nvim",
  lazy = true,
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

},

-- install without yarn or npm

{ 
  "iamcco/markdown-preview.nvim", 
  lazy = true,
  build = "cd app && npm install", 
  setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, 
},



-- https://github.com/epwalsh/obsidian.nvim
{
  "epwalsh/obsidian.nvim",
  -- lazy = true,
  tag = "*",  -- recommended, use latest release instead of latest commit
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
    enabled = function() 
     local max_filesize = 2 * 1024 * 1024 -- 2 MB
     local file = vim.fn.expand("%:p")
     return not (vim.fn.getfsize(file) > max_filesize)
--     return false
    end,
  config = function()
    require("obsidian").setup({
      ui = { enable=false},
      workspaces = {
        {
          name = "work",
          path = "~/files/docs/infor-vault/",
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

    mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gd"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    }
  },
  note_id_func = function(title)
    return title
  end,

})
  end,
},

{ 
  'rose-pine/neovim', 
  as = 'rose-pine',
  priority=1000,
  config = function()
  vim.cmd('colorscheme rose-pine')
  end
},


--https://github.com/folke/trouble.nvim
--A pretty list for showing diagnostics, 
--references, telescope results, quickfix 
--and location lists to help you solve all 
--the trouble your code is causing.
{
  "folke/trouble.nvim",
   enabled = function() 
    local max_filesize = 2 * 1024 * 1024 -- 2 MB
    local file = vim.fn.expand("%:p")
    return not (vim.fn.getfsize(file) > max_filesize)
--    return false
   end,
  config = function()
    require("trouble").setup {
      icons = false,
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
},

{ 
  'nvim-treesitter/nvim-treesitter', 
  build = ':TSUpdate',
--  lazy = true,
   enabled = function() 
    local max_filesize = 2 * 1024 * 1024 -- 2 MB
    local file = vim.fn.expand("%:p")
    return not (vim.fn.getfsize(file) > max_filesize)
--    return false
   end,
   config = function()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "c", "lua", "rust", "java", "kotlin", "scala", "go", "vim", "query" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
   end,
},

"nvim-treesitter/nvim-treesitter-context", 
'nvim-lua/plenary.nvim', 

{
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { {"nvim-lua/plenary.nvim"} }
},

'mbbill/undotree',
'tpope/vim-fugitive',

{
    'hrsh7th/nvim-cmp',
    enabled = function() 
     local max_filesize = 2 * 1024 * 1024 -- 2 MB
     local file = vim.fn.expand("%:p")
     return not (vim.fn.getfsize(file) > max_filesize)
--     return false
    end,

    config = function ()
      require'cmp'.setup {
      snippet = {
        expand = require("lsp-zero").noop,
    --    expand = function(args)
    --    --10/23/2024 changed to nvim_lsp from luasnip, trying to remove md autocomplete
    --      --require'luasnip'.lsp_expand(args.body)
    --      vim.snippet.expand(args.body)
    --    end
      },
   
      sources = {
        --10/23/2024 changed to nvim_lsp from luasnip, trying to remove md autocomplete
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
       -- { name = 'luasnip', option = { show_autosnippets = true, use_show_condition = false } },
       -- more sources
      },
    }
    end
  },

  -- https://github.com/VonHeikemen/lsp-zero.nvim?tab=readme-ov-file#quickstart-for-the-impatient
  -- [ ] - TODO this has been updated to 4.x, need to update it at some point
  -- I would like to get helm-lsp working
  --
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    enabled = function() 
     local max_filesize = 2 * 1024 * 1024 -- 2 MB
     local file = vim.fn.expand("%:p")
     return not (vim.fn.getfsize(file) > max_filesize)
--     return false
    end,
    dependencies = {
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
    },
    config = function()

  local lsp = require("lsp-zero")
  local lua_snip = require("luasnip")

  lua_snip.hidden = true

  lsp.preset("recommended")

  lsp.ensure_installed({
    'rust_analyzer',
  })

   -- (Optional) Configure lua language server for neovim
  lsp.nvim_workspace()

  -- Fix Undefined global 'vim'
  lsp.configure('lua-language-server', {
      settings = {
          Lua = {
              diagnostics = {
                  globals = { 'vim' }
              }
          }
      }
  })


  local cmp = require('cmp')
  local cmp_select = {behavior = cmp.SelectBehavior.Select}
  local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  })


  local cmp_sources = {

     -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'nvim_lsp',
      entry_filter = function(entry)
                  return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
              end },
      { name = 'path' },
      { name = 'nvim_lua' },
  }


  cmp_mappings['<Tab>'] = nil
  cmp_mappings['<S-Tab>'] = nil

  --lsp.setup_nvim_cmp({
  --  mapping = cmp_mappings
  --})

  lsp.setup_nvim_cmp({
      mapping = cmp_mappings, 
      snippet = cmp_snippet,
      sources = cmp_sources, 
  })

  lsp.set_preferences({
      suggest_lsp_servers = false,
      sign_icons = {
          error = 'E',
          warn = 'W',
          hint = 'H',
          info = 'I'
      }
  })

  lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  end)

  lsp.setup()

  vim.diagnostic.config({
      virtual_text = true
  })
    end,
  },

'christoomey/vim-tmux-navigator',

{
  "eandrju/cellular-automaton.nvim",
  lazy = true,
},
'vim-airline/vim-airline',
'vim-airline/vim-airline-themes',

})
