-- Packer plugin manager bootstrap + plugins
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd("packadd packer.nvim")
end

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- Theme
  use({ "catppuccin/nvim", as = "catppuccin" })

  -- File explorer + icons
  use({ "nvim-tree/nvim-web-devicons" })
  use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } })

  -- Fuzzy finder
  use({ "nvim-lua/plenary.nvim" })
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })

  -- Syntax highlighting; master keeps the classic configs.setup API stable for normal Nvim releases
  use({ "nvim-treesitter/nvim-treesitter", branch = "master", run = ":TSUpdate" })

  -- LSP installer + configs
  use({ "mason-org/mason.nvim" })
  use({ "mason-org/mason-lspconfig.nvim", requires = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" } })
  use({ "neovim/nvim-lspconfig" })

  -- Autocomplete + snippets
  use({ "hrsh7th/nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "L3MON4D3/LuaSnip" })
  use({ "saadparwaiz1/cmp_luasnip" })
  use({ "rafamadriz/friendly-snippets" })

  -- Quality of life
  use({ "windwp/nvim-autopairs" })

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
