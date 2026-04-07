-- lua/config/keymaps.lua
--vim.g.mapleader = " "  -- Leader key: Space
--vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Basic
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Clipboard (already synced via options, but explicit if needed)
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
