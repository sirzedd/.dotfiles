---- lua/plugins/init.lua

return {
  require("lazy").setup({
    install = { colorscheme = { "catppuccin" } },
    checker = { enabled = true },                                     -- Auto check for updates
    performance = { rtp = { disabled_plugins = { "netrwPlugin" } } }, -- Faster

  })
}
