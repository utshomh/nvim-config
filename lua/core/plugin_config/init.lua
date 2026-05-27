-- Load plugin configs safely. Missing plugins will not crash first startup.
local modules = {
  "core.plugin_config.theme",
  "core.plugin_config.tree",
  "core.plugin_config.telescope",
  "core.plugin_config.treesitter",
  "core.plugin_config.cmp",
  "core.plugin_config.lsp",
  "core.plugin_config.autopairs",
}

for _, module in ipairs(modules) do
  pcall(require, module)
end
