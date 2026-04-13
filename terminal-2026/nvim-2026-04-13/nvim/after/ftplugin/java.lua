-- after/ftplugin/java.lua
local jdtls = require("jdtls")
local config = { ... }  -- root_dir, settings, etc. See nvim-jdtls docs
jdtls.start_or_attach(config)
