local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

configs.setup({
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "lua",
    "luadoc",
    "python",
    "rust",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "jsonc",
    "html",
    "css",
    "toml",
    "yaml",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})
