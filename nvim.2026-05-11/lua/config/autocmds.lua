-- lua/config/autocmds.lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  pattern = "*",
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 }) end,
})

-- AutoReload files if they change
autocmd("FocusGained", {
  desc = "Reload files from disk when we focus vim",
  pattern = "*",
  command = "if getcmdwintype() == '' | checktime | endif",
  --	group = aug,
})
autocmd("BufEnter", {
  desc = "Every time we enter an unmodified buffer, check if it changed on disk",
  pattern = "*",
  command = "if &buftype == '' && !&modified && expand('%') != '' | exec 'checktime ' . expand('<abuf>') | endif",
  --	group = aug,
})


-- Function to check file size and disable folds for large files
local function disable_folds_for_large_files()
  local max_file_size = 1024 * 1024            -- 1 MB, adjust as needed
  local file_path = vim.fn.expand('%:p')       -- Get full file path
  local file_size = vim.fn.getfsize(file_path) -- Get file size in bytes

  if file_size > max_file_size then
    vim.opt_local.foldmethod = "manual" -- Disable automatic folds
    vim.opt_local.foldenable = false    -- Disable folds
    --notify to UI to test if it works
    --vim.notify("Folds disabled for large file: " .. file_path, vim.log.levels.WARN)
  end
end


-- Autocommand to run the function on file read
autocmd({ "BufReadPre", "FileReadPre" }, {
  callback = disable_folds_for_large_files,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "ObsidianNoteEnter",
  callback = function()
    vim.keymap.del("n", "<CR>", { buffer = true })

    local harpoon = require("harpoon")
    vim.keymap.set("n", "<CR>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { noremap = true, desc = "Harpoon: Menu" })
  end,
})
