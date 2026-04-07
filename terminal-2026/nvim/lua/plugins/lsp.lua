-- lua/plugins/lsp.lua
return {
  -- Treesitter (syntax highlighting, auto based on filetype)
{
    "nvim-treesitter/nvim-treesitter",
    lazy = false,                    -- Load early for reliable highlighting
    build = ":TSUpdate",             -- Automatically update parsers
    config = function()
      require("nvim-treesitter").setup({  -- Note: NOT .configs anymore
        ensure_installed = {
          "lua", "vim", "yaml", "nim", "json", "xml", "bash",
          "markdown", "markdown_inline", "java", "query"  -- query for treesitter itself
        },
        highlight = { enable = true },
        indent = { enable = true },
        -- auto_install = true,          -- Optional: auto install missing parsers
      })
    end,
  },
  -- Mason + LSP servers
  {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "yamlls", "bashls", "jsonls", "lemminx", -- xml
          -- Nim LSP will be installed via nimlang tools below
        },
      })
    end,
  },

  -- Fast completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })
    end,
  },

  -- Dedicated Nim support (best in 2026)
  {
    "alaviss/nim.nvim",
    ft = "nim",                    -- Load only for .nim files
    config = function()
      -- Basic setup - you can expand this later
      require("nim").setup({
        -- Enable LSP via nimlsp (installed by mason or choosenim)
        lsp = { enable = true },
      })
    end,
  },

  -- nvim-java
  { "mfussenegger/nvim-jdtls" },
}
