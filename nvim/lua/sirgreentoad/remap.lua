vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>")

-- Splitting windows
vim.keymap.set("n", "<leader>h", "<cmd>split<cr>")
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<cr>")

-- Closing vim window with leader key
vim.keymap.set("n", "<leader>q", "<cmd>close<cr>")

-- Shrinking and growing vim windows
-- Need to map this to something that makes sense
--vim.keymap.set("n", "<leader><up>", "<C-w>+")
--vim.keymap.set("n", "<leader><down>", "<C-w>-")
--vim.keymap.set("n", "<leader><left>", "<C-w><")


--automove line when highlighting with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Not sure what this is in normal mode
--vim.keymap.set("n", "J", "mzJ`z")

-- Quick map for end line, beginning line, and bracket
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "J", "%")

--ctrl d and u keep in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--keep cursor in middle for search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- paste without copy into buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yank into clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

--goes to next error
--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- substitute visually selected
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make file executable with leader x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--reload source
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("source ~/.config/nvim/init.lua")
end)

--kj acts as escape
vim.keymap.set("i", "kj", "<ESC>")
vim.keymap.set("i", "KJ", "<ESC>")

vim.keymap.set("n", "gb", "<C-O>")

