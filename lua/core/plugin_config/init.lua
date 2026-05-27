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
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify("Failed loading " .. module .. ":\n" .. err, vim.log.levels.ERROR)
  end
end
