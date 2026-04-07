-- lua/plugins/editing.lua
return {
  -- Surround (ysiw" etc. - very intuitive)
  {
    "echasnovski/mini.surround",  -- Modern Lua alternative to tpope/vim-surround
    version = "*",
    config = function() require("mini.surround").setup() end,
  },

  -- Todo comments highlight
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("todo-comments").setup() end,
    -- :TodoTelescope or :TodoQuickFix to list
  },

  -- Command line in popup (wilder.nvim or Noice for full cmd popup)
  -- Simple enhancement: use folke/noice.nvim for beautiful cmdline popup
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        cmdline = { enabled = true, view = "cmdline_popup" },
        messages = { enabled = true },
      })
    end,
  },
}
