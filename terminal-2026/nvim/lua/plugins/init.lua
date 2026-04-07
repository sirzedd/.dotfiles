-- lua/plugins/init.lua
require("lazy").setup({
  spec = {
    -- Import all plugin groups (add new files here easily)
    { import = "plugins.ui" },
    { import = "plugins.navigation" },
    { import = "plugins.editing" },
    { import = "plugins.lsp" },
    { import = "plugins.tools" },
    { import = "plugins.lang" },
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true },  -- Auto check for updates
  performance = { rtp = { disabled_plugins = { "netrwPlugin" } } },  -- Faster
})
