-- Core editor options.
-- These settings are deliberately boring and predictable so the LSP/formatter
-- layers can handle language-specific behavior.

-- Leader keys must be set before plugin/keymap configuration is loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- UI -------------------------------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes" -- Prevent diagnostics from shifting text left/right.
opt.wrap = false
opt.mouse = "a"
opt.showmode = false -- Statusline/completion UIs already communicate mode.

-- Editing --------------------------------------------------------------------
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.breakindent = true
opt.undofile = true

-- Search ---------------------------------------------------------------------
opt.ignorecase = true
opt.smartcase = true

-- Windows/splits -------------------------------------------------------------
opt.splitright = true
opt.splitbelow = true

-- Completion/LSP responsiveness ---------------------------------------------
opt.completeopt = { "menu", "menuone", "noselect" }
opt.updatetime = 250
opt.timeoutlen = 400

-- Make common React extensions resolve to the correct Neovim filetypes.
-- These names are used by LSP, Treesitter, completion, and formatting rules.
vim.filetype.add({
  extension = {
    jsx = "javascriptreact",
    tsx = "typescriptreact",
  },
})

-- Go projects should keep real tabs; gofmt/goimports will still be the source
-- of truth, but these local defaults make manual editing feel right.
local go_indent_group = vim.api.nvim_create_augroup("GoIndentOptions", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = go_indent_group,
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})
