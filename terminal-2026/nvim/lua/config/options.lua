-- lua/config/options.lua
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.termguicolors = true
opt.clipboard = "unnamedplus"  -- Sync with system clipboard (copy/paste works out of box)
opt.mouse = "a"
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.showmode = false  -- Statusline shows mode instead

-- Ruler / status: show column starting from 1 (prompt position)
opt.ruler = true
opt.rulerformat = "%l,%c%V %P"  -- line,col virtual-col percent

-- Auto highlight based on filetype (Treesitter will enhance)
opt.syntax = "on"
opt.filetype = "on"  -- :filetype on + plugin + indent

-- Command line popup behavior (Neovim 0.12+ has improvements; plugins enhance further)
opt.wildmenu = true
opt.wildmode = "longest:full,full"
