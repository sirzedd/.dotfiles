require("oil").setup({
  use_default_keymaps = false,
   keymaps = {
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
    ["-"] = "actions.parent",
    ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
  },

})


vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
