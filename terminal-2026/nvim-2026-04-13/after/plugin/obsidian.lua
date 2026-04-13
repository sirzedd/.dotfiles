-- Obsidian.nvim
return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    opts = {
      legacy_commands = false,
      workspaces = { { name = "vault", path = "~/files/docs" } }, -- Change to your vault
      completion = {
        nvim_cmp = true,
        min_chars = 1,
        blink = false,
      },

    },
  },
}
