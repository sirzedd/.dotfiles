-- ~/.config/nvim/init.lua
-- Neovim 0.12+ modular config with lazy.nvim

---- Bootstrap lazy.nvim (plugin manager)
-- Load Lazy
require("config.lazy") --lazy loads all plugins

-- Load core settings
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.theme")
