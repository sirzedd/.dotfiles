-- lua/plugins/navigation.lua
return {
  -- Tmux navigation (seamless <C-h/j/k/l> between tmux and nvim panes)
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- fzf-lua: fast file lookup + grep
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({}) -- Excellent defaults

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
        default_file_explorer = true, -- Replace netrw
        -- Optional: nicer defaults
        use_default_keymaps = false,
        keymaps = {
          ["-"] = { "actions.parent", mode = "n" },
          ["<CR>"] = "actions.select",
        },
        watch_for_changes = true,
      })

      vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil (current directory)" })
      -- Your requested mapping: "-" opens Oil in the directory of the current file
      --      vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil (current directory)" })
      --
      --      vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil (current directory)" })
      --
      --      -- Bonus: "_" opens Oil at Neovim's current working directory (project root)
      --      vim.keymap.set("n", "_", function()
      --        require("oil").open(vim.fn.getcwd())
      --      end, { desc = "Open Oil (cwd / project root)" })
    end,
  },
  -- smooth scroll
  { "karb94/neoscroll.nvim", opts = {} },
  -- Surround normal sa(add), sd(delete), sf(find right), sF(find left), sh (highlight surround), sr(replace)
  { "nvim-mini/mini.nvim",   version = false },
  -- Show vim keys inline
  {
    "tris203/precognition.nvim",
    opts = {
      startVisible = false,
      showBlankVirtLine = false,
    },
  },
  -- Harpoon, leap, etc. (unchanged from previous)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      vim.keymap.set("n", "<leader>m", function()
        harpoon:list():add()
      end, { noremap = true, desc = "Harpoon: Add" })
      vim.keymap.set("n", "<CR>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { noremap = true, desc = "Harpoon: Menu" })
      for i = 1, 4 do
        vim.keymap.set("n", "<leader>" .. i, function()
          harpoon:list():select(i)
        end, { noremap = true })
      end
    end,
  },
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup({
        -- show highlights only after keypress
        highlight_on_key = true,

        -- dim all other characters if set to true (recommended!)
        dim = false,

        -- set the maximum number of characters eyeliner.nvim will check from
        -- your current cursor position; this is useful if you are dealing with
        -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
        max_length = 9999,

        -- filetypes for which eyeliner should be disabled;
        -- e.g., to disable on help files:
        -- disabled_filetypes = {"help"}
        disabled_filetypes = {},

        -- buftypes for which eyeliner should be disabled
        -- e.g., disabled_buftypes = {"nofile"}
        disabled_buftypes = {},

        -- add eyeliner to f/F/t/T keymaps;
        -- see section on advanced configuration for more information
        default_keymaps = true,
      })
    end,
  },
}
