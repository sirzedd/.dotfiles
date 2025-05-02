#
vim.opt.clipboard:append({ 'unnamedplus' })

vim.opt.nu = true
vim.opt.relativenumber = true


vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Ignore search case and smart case searching
-- Ignore case
vim.opt.ignorecase = true
-- smartcase if search is lower the search ignores
-- any caps make it search exact
vim.opt.smartcase = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.errorbells = false
vim.opt.visualbell = false

vim.api.nvim_create_autocmd({"BufLeave", "FocusLost"}, {
  pattern = "*",
  command = "silent! wall",
})


-- Code Folding https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
-- zR opens all folds
-- zM close all folds
-- za toggles fold
-- zk and zj to navigate folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--remove extra column during fold
vim.opt.foldcolumn = "0"
--remove syntax highlighting in fold
vim.opt.foldtext = ""

--foldlevel
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

--deeply nested code gets folded
vim.opt.foldnestmax = 4

-- Function to check file size and disable folds for large files
local function disable_folds_for_large_files()
  local max_file_size = 1024 * 1024 -- 1 MB, adjust as needed
  local file_path = vim.fn.expand('%:p') -- Get full file path
  local file_size = vim.fn.getfsize(file_path) -- Get file size in bytes

  if file_size > max_file_size then
    vim.opt_local.foldmethod = "manual" -- Disable automatic folds
    vim.opt_local.foldenable = false    -- Disable folds
    --notify to UI to test if it works
    --vim.notify("Folds disabled for large file: " .. file_path, vim.log.levels.WARN)
  end
end

-- Autocommand to run the function on file read
vim.api.nvim_create_autocmd({"BufReadPre", "FileReadPre"}, {
  callback = disable_folds_for_large_files,
})

--vim.api.nvim_create_autocmd({"BufReadPre", "FileReadPre"}, {
--  callback = function()
--     local max_filesize = 1024 * 1024 * 2 -- 1 MB * 2 = 2 MB?
--    local file = vim.fn.expand("%:p")
--    if vim.fn.getfsize(file) > max_filesize then
--      -- Example of disabling plugins for large files
--      vim.cmd("syntax off")
--      vim.cmd("setlocal noundofile")
--      vim.cmd("setlocal nocursorline")
--      vim.cmd("setlocal noswapfile")
--      vim.cmd("setlocal nospell")
--      vim.cmd("setlocal noloadplugins")
--
--      -- Optional: Disable specific plugins
--      -- vim.g.loaded_plugin_name = 1
--
--      print("Large file detected. Certain features have been disabled.")
--  end
--end,
--
--})


