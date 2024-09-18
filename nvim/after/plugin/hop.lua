require'hop'.setup()

vim.api.nvim_set_keymap("n", "<Leader>;", "<cmd>HopWord<CR>", {noremap=false})
vim.api.nvim_set_keymap("n", "f", "<cmd>HopChar2AC<CR>", {noremap=false})
vim.api.nvim_set_keymap("n", "F", "<cmd>HopChar2BC<CR>", {noremap=false})
