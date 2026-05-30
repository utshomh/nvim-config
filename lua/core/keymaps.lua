-- Global keymaps.  LSP-specific keymaps are registered in plugin_config/lsp.lua
-- when a language server attaches to a buffer.

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save / quit ----------------------------------------------------------------
keymap("n", "<leader>w", ":w<CR>", vim.tbl_extend("force", opts, { desc = "Save file" }))
keymap("n", "<leader>q", ":q<CR>", vim.tbl_extend("force", opts, { desc = "Quit window" }))

-- Better window movement ------------------------------------------------------
keymap("n", "<C-h>", "<C-w>h", vim.tbl_extend("force", opts, { desc = "Move to left split" }))
keymap("n", "<C-j>", "<C-w>j", vim.tbl_extend("force", opts, { desc = "Move to lower split" }))
keymap("n", "<C-k>", "<C-w>k", vim.tbl_extend("force", opts, { desc = "Move to upper split" }))
keymap("n", "<C-l>", "<C-w>l", vim.tbl_extend("force", opts, { desc = "Move to right split" }))

-- File explorer ---------------------------------------------------------------
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle file explorer" }))

-- Telescope ------------------------------------------------------------------
keymap("n", "<leader>ff", ":Telescope find_files<CR>", vim.tbl_extend("force", opts, { desc = "Find files" }))
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", vim.tbl_extend("force", opts, { desc = "Live grep" }))
keymap("n", "<leader>fb", ":Telescope buffers<CR>", vim.tbl_extend("force", opts, { desc = "Find buffers" }))
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", vim.tbl_extend("force", opts, { desc = "Find help tags" }))

-- Formatting -----------------------------------------------------------------
-- Uses conform.nvim when available, with LSP formatting as a fallback.
keymap("n", "<leader>f", function()
  local ok, conform = pcall(require, "conform")
  if ok then
    conform.format({ async = true, lsp_format = "fallback" })
  else
    vim.lsp.buf.format({ async = true })
  end
end, vim.tbl_extend("force", opts, { desc = "Format current buffer" }))
