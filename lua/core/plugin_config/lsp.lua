local mason_ok, mason = pcall(require, "mason")
local mlsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_ok or not mlsp_ok then
  return
end

mason.setup()

local servers = {
  "ts_ls",          -- JavaScript / TypeScript / Bun projects
  "rust_analyzer", -- Rust
  "clangd",        -- C / C++
  "pyright",       -- Python
  "lua_ls",        -- Lua / Neovim config
}

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_enable = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local function on_attach(_, bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gr", vim.lsp.buf.references, "Go to references")
  map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  map("n", "K", vim.lsp.buf.hover, "Hover docs")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, "Format buffer")
  map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostic")
end

local function setup_server(name, opts)
  opts = opts or {}
  opts.capabilities = capabilities
  opts.on_attach = on_attach

  -- Modern Neovim 0.11+ API
  if vim.lsp and vim.lsp.config and vim.lsp.enable then
    vim.lsp.config(name, opts)
    return
  end

  -- Legacy fallback for older Neovim/lspconfig
  local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
  if lspconfig_ok and lspconfig[name] then
    lspconfig[name].setup(opts)
  end
end

setup_server("ts_ls", {
  -- Works for JavaScript, TypeScript, React, and Bun projects.
  -- Bun runtime/types come from your project dependencies, for example: bun add -d @types/bun
  single_file_support = true,
})

setup_server("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      check = { command = "clippy" },
    },
  },
})

setup_server("clangd", {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
})

setup_server("pyright", {})

setup_server("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
})

if vim.lsp and vim.lsp.enable then
  vim.lsp.enable(servers)
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
