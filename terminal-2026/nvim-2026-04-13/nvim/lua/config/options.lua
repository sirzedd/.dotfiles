-- lua/config/options.lua
local api = vim.api
local opt = vim.opt

vim.g.lazyvim_cmp = "nvim-cmp"

opt.number = true
opt.relativenumber = true
--opt.tabstop = 2
--opt.shiftwidth = 2
-- Use spaces
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.softtabstop = 2
--
-- use tabs
--opt.expandtab = false
opt.smartindent = true
opt.wrap = false
opt.termguicolors = true
opt.clipboard = "unnamedplus" -- Sync with system clipboard (copy/paste works out of box)
opt.mouse = "a"
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.showmode = false -- Statusline shows mode instead

-- Ruler / status: show column starting from 1 (prompt position)
opt.ruler = true
opt.rulerformat = "%l,%c%V %P" -- line,col virtual-col percent

-- Auto highlight based on filetype (Treesitter will enhance)
opt.syntax = "on"
opt.filetype = "on" -- :filetype on + plugin + indent

-- Command line popup behavior (Neovim 0.12+ has improvements; plugins enhance further)
opt.wildmenu = true
opt.wildmode = "longest:full,full"

--undodir
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- No bell
opt.errorbells = false
opt.visualbell = false

-- Code Folding https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
-- zR opens all folds
-- zM close all folds
-- za toggles fold
-- zk and zj to navigate folds
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--remove extra column during fold
opt.foldcolumn = "0"
--remove syntax highlighting in fold
opt.foldtext = ""

--foldlevel
opt.foldlevel = 99
opt.foldlevelstart = 99

--deeply nested code gets folded
opt.foldnestmax = 4

-- Set plugins f, F colors
api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#ff0000", bold = true, underline = true })
api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#ffffff", underline = true })
