-- Load plugin configuration modules in a predictable order.
-- Each module is protected with pcall so a broken/missing plugin does not stop
-- the rest of Neovim from starting.

local modules = {
  "core.plugin_config.theme",
  "core.plugin_config.tree",
  "core.plugin_config.telescope",
  "core.plugin_config.treesitter",
  "core.plugin_config.cmp",
  "core.plugin_config.conform",
  "core.plugin_config.lsp",
  "core.plugin_config.autopairs",
}

for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify("Failed loading " .. module .. ":\n" .. err, vim.log.levels.ERROR)
  end
end
