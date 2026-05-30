-- Formatting configuration powered by conform.nvim.
-- Format-on-save is intentionally restricted to the languages requested in the
-- README so unexpected filetypes are not modified on write.

local ok, conform = pcall(require, "conform")
if not ok then
  return
end

-- Prettier is used for the web stack.  If prettierd is installed it is preferred
-- for speed; otherwise prettier is used.  stop_after_first avoids running both.
local function prettier_formatters()
  return { "prettierd", "prettier", stop_after_first = true }
end

-- Filetypes for which this config should format automatically on save.
local autoformat_filetypes = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  rust = true,
  go = true,
  python = true,
  lua = true,
  html = true,
  css = true,
}

conform.setup({
  formatters_by_ft = {
    -- TS/JS + React/JSX/TSX --------------------------------------------------
    javascript = prettier_formatters(),
    javascriptreact = prettier_formatters(),
    typescript = prettier_formatters(),
    typescriptreact = prettier_formatters(),

    -- HTML/CSS ---------------------------------------------------------------
    html = prettier_formatters(),
    css = prettier_formatters(),

    -- Rust -------------------------------------------------------------------
    rust = { "rustfmt", lsp_format = "fallback" },

    -- Go ---------------------------------------------------------------------
    -- goimports also applies gofmt-style formatting and manages imports; gofmt
    -- runs after it as a conservative final normalization step.
    go = { "goimports", "gofmt" },

    -- Python -----------------------------------------------------------------
    -- isort organizes imports before black formats the rest of the file.
    python = { "isort", "black" },

    -- Lua --------------------------------------------------------------------
    lua = { "stylua" },
  },

  -- Called by conform before each save.  Return nil to skip formatting.
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return nil
    end

    if not autoformat_filetypes[vim.bo[bufnr].filetype] then
      return nil
    end

    return {
      timeout_ms = 2000,
      lsp_format = "fallback",
    }
  end,

  notify_on_error = true,
  notify_no_formatters = false,
})

-- Manual formatting command.  Works even when format-on-save has been disabled.
vim.api.nvim_create_user_command("Format", function()
  conform.format({
    bufnr = 0,
    async = true,
    lsp_format = "fallback",
  })
end, { desc = "Format current buffer" })

-- :FormatDisable disables formatting for the current buffer.
-- :FormatDisable! disables formatting globally for the current Neovim session.
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.g.disable_autoformat = true
  else
    vim.b.disable_autoformat = true
  end
end, { bang = true, desc = "Disable format-on-save" })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.g.disable_autoformat = false
  vim.b.disable_autoformat = false
end, { desc = "Enable format-on-save" })
