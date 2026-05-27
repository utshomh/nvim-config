vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

nvim_tree.setup({
  view = {
    width = 32,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
})
