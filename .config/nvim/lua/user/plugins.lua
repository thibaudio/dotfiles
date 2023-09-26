local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- LSP
  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }
   -- Telescope
   use {
     'nvim-telescope/telescope.nvim',
     requires = { {'nvim-lua/plenary.nvim'} }
   } 

	 use { "nvim-telescope/telescope-file-browser.nvim" }
 
   -- Treesitter
   use {
     "nvim-treesitter/nvim-treesitter",
     run = ":TSUpdate",
   }
	use 'nvim-treesitter/nvim-treesitter-context'

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer'
    },
  }

  -- telekasten
  use {
    "renerocksai/telekasten.nvim",
    requires = {{"nvim-telescope/telescope.nvim"}},
  }

  -- Which key
  use "folke/which-key.nvim"

	-- Theme
  use { 
    'dracula/vim',
    config = function()
      vim.cmd([[colorscheme dracula]])
    end
  }

  use 'nvim-lualine/lualine.nvim'

	-- Comments
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("tpope/vim-commentary")

	-- Pairs
	use("windwp/nvim-autopairs")

	-- git
	use("tpope/vim-fugitive")
	use({ "lewis6991/gitsigns.nvim"})

	use({ "akinsho/toggleterm.nvim"})

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
