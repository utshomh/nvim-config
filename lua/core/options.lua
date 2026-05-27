-- Basic editor settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 400
opt.ignorecase = true
opt.smartcase = true
opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.completeopt = { "menu", "menuone", "noselect" }

-- Helpful filetype mappings for JS/TS/Bun projects
vim.filetype.add({
  extension = {
    jsx = "javascriptreact",
    tsx = "typescriptreact",
  },
})
