--local mark = require("harpoon.mark")
--local ui = require("harpoon.ui")
--
--vim.keymap.set("n", "<leader>a", mark.add_file)
--vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
--
--
--vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end)
--vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end)
--vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end)
--vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end)


local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-m>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-1>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-2>", function() harpoon:list():next() end)
