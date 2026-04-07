-- lua/plugins/navigation.lua
return {
  -- fzf-lua: fast file lookup + grep
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({})  -- Excellent defaults

      -- Your requested global keymaps
      vim.keymap.set("n", "<C-p>", fzf.files, { desc = "FZF: Find files (Ctrl-P)" })
      vim.keymap.set("n", "<C-g>", fzf.live_grep, { desc = "FZF: Live grep (Ctrl-G)" })

      -- Extra useful ones (keep or remove as you like)
      vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "FZF: Buffers" })
      vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "FZF: Help tags" })
    end,
  },

  -- oil.nvim: file explorer (minus sign opens current directory)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        view_options = { show_hidden = true },
        -- Optional: nicer defaults
        default_file_explorer = true,  -- Replace netrw
      })

      -- Your requested mapping: "-" opens Oil in the directory of the current file
      vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil (current directory)" })

      -- Bonus: "_" opens Oil at Neovim's current working directory (project root)
      vim.keymap.set("n", "_", function()
        require("oil").open(vim.fn.getcwd())
      end, { desc = "Open Oil (cwd / project root)" })
    end,
  },

  -- Harpoon, leap, etc. (unchanged from previous)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end, { desc = "Harpoon: Add" })
      vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })
      for i = 1, 4 do
        vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end)
      end
    end,
  },

  {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end,
  },
}
