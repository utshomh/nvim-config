-- Treesitter syntax highlighting and indentation.
-- The parsers here mirror the language/tooling support documented in README.md.

local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

configs.setup({
  ensure_installed = {
    -- Shell / config files
    "bash",
    "json",
    "jsonc",
    "toml",
    "yaml",

    -- Neovim / Lua
    "lua",
    "luadoc",
    "vim",
    "vimdoc",
    "query",

    -- Web / React / Tailwind projects
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",

    -- Go
    "go",
    "gomod",
    "gowork",
    "gosum",

    -- Rust / Python / C / C++
    "rust",
    "python",
    "c",
    "cpp",

    -- Markdown docs
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
