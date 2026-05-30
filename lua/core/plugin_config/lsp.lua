-- Language Server Protocol configuration.
-- This file uses the Neovim 0.11+ vim.lsp.config / vim.lsp.enable APIs.

local mason_ok, mason = pcall(require, "mason")
if mason_ok then
  mason.setup()
end

-- Servers installed by Mason. External formatters are documented in the README
-- because mason-lspconfig only manages LSP servers, not tools like prettier.
local servers = {
  "ts_ls",
  "rust_analyzer",
  "clangd",
  "pyright",
  "lua_ls",
  "gopls",
  "html",
  "cssls",
  "tailwindcss",
}

local mlsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mlsp_ok then
  mason_lspconfig.setup({
    ensure_installed = servers,
    -- Keep server activation explicit so the custom configs below always win.
    automatic_enable = false,
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Shared on_attach behavior for every LSP client.
local lsp_attach_group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_attach_group,
  callback = function(event)
    local bufnr = event.buf

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        silent = true,
        desc = desc,
      })
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gr", vim.lsp.buf.references, "Go to references")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "K", vim.lsp.buf.hover, "Hover docs")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

    -- Prefer conform.nvim so manual formatting matches format-on-save.
    map("n", "<leader>f", function()
      local conform_ok, conform = pcall(require, "conform")
      if conform_ok then
        conform.format({ async = true, lsp_format = "fallback" })
      else
        vim.lsp.buf.format({ async = true })
      end
    end, "Format buffer")

    map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
    map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostic")
  end,
})

-- JavaScript / TypeScript / React -------------------------------------------
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    ".git",
  },
  capabilities = capabilities,
  single_file_support = true,
})

-- Tailwind CSS IntelliSense --------------------------------------------------
-- Works in HTML, CSS, and React class/className attributes.  The experimental
-- regexes also cover common helper patterns such as clsx(), cx(), cva(), and
-- tw`...` template literals.
vim.lsp.config("tailwindcss", {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html",
    "css",
    "scss",
    "sass",
    "postcss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "package.json",
    ".git",
  },
  capabilities = capabilities,
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      includeLanguages = {
        javascript = "javascript",
        javascriptreact = "javascriptreact",
        typescript = "typescript",
        typescriptreact = "typescriptreact",
      },
      experimental = {
        classRegex = {
          [[class(?:Name)?\s*=\s*["'`]([^"'`]*)]],
          [[tw`([^`]*)]],
          [[tw\.[^`]+`([^`]*)]],
          [[clsx\(([^)]*)\)]],
          [[cx\(([^)]*)\)]],
          [[cva\(([^)]*)\)]],
        },
      },
    },
  },
})

-- Rust -----------------------------------------------------------------------
vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = {
    "Cargo.toml",
    "rust-project.json",
    ".git",
  },
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = "clippy",
      },
    },
  },
})

-- Go -------------------------------------------------------------------------
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = {
    "go.work",
    "go.mod",
    ".git",
  },
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        unusedwrite = true,
        shadow = true,
      },
    },
  },
})

-- C / C++ --------------------------------------------------------------------
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
  },
  filetypes = {
    "c",
    "cpp",
    "objc",
    "objcpp",
    "cuda",
  },
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".git",
  },
  capabilities = capabilities,
})

-- Python ---------------------------------------------------------------------
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  capabilities = capabilities,
})

-- Lua ------------------------------------------------------------------------
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".git",
  },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- HTML -----------------------------------------------------------------------
vim.lsp.config("html", {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  root_markers = { "package.json", ".git" },
  capabilities = capabilities,
  single_file_support = true,
})

-- CSS ------------------------------------------------------------------------
vim.lsp.config("cssls", {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
  capabilities = capabilities,
  single_file_support = true,
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
})

vim.lsp.enable(servers)

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
