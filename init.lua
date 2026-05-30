-- ~/.config/nvim/init.lua
-- Entry point for the whole configuration.  Keep this file intentionally small
-- and load feature-specific modules from lua/core/*.

require("core.options")
require("core.keymaps")
require("core.plugins")
require("core.plugin_config")
