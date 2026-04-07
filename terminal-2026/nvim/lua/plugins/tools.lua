-- lua/plugins/tools.lua
return {
  -- Tmux navigation (seamless <C-h/j/k/l> between tmux and nvim panes)
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- Obsidian.nvim
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = { { name = "vault", path = "~/files/docs" } },  -- Change to your vault
    },
  },

  -- Markdown preview (live in browser; opens on demand)
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 0  -- Don't auto open
      vim.g.mkdp_theme = "dark"
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<CR>", desc = "Markdown: Preview" },
      { "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", desc = "Markdown: Stop preview" },
    },
  },
}
