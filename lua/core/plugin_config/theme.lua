-- Catppuccin theme configuration.

local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  return
end

catppuccin.setup({
  flavour = "mocha",
  transparent_background = false,
  integrations = {
    cmp = true,
    nvimtree = true,
    treesitter = true,
    telescope = true,
  },
})

pcall(vim.cmd.colorscheme, "catppuccin-mocha")
