-- lua/config/theme.lua
-- Use catppuccin (beautiful, easy to switch variants)
--vim.cmd.colorscheme("catppuccin-mocha")  -- mocha = dark, or latte/frappe/macchiato
vim.cmd.colorscheme("gruvbox")  -- mocha = dark, or latte/frappe/macchiato
-- To change: edit this or use :Catppuccin <flavor>
-- lua/config/theme.lua
-- Easy dark theme with catppuccin (mocha is the dark variant)

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,           -- Load this first
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",     -- Change to "latte", "frappe", or "macchiato" anytime
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = false,    -- we use oil instead
          treesitter = true,
          telescope = true,
          harpoon = true,
          noice = true,
          -- add more as you install plugins
        },
      })

      -- Apply the colorscheme
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
