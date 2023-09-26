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

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use { "nvim-telescope/telescope-file-browser.nvim" }

	-- telekasten
	use {
		"renerocksai/telekasten.nvim",
		requires = { { "nvim-telescope/telescope.nvim" } },
	}

	-- LSP
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },           -- Required
			{ 'williamboman/mason.nvim' },         -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional


			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },       -- Required
			{ 'hrsh7th/cmp-nvim-lsp' },   -- Required
			{ 'hrsh7th/cmp-nvim-lua' },   -- Optional

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },           -- Required
			{ 'rafamadriz/friendly-snippets' }, -- Optional
		}
	}

	-- DAP
	use { "mfussenegger/nvim-dap" }
	use { "jay-babu/mason-nvim-dap.nvim" }
	use { "nvim-telescope/telescope-dap.nvim" }
	use { "rcarriga/nvim-dap-ui" }

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}
	use 'nvim-treesitter/nvim-treesitter-context'


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
	use({ "lewis6991/gitsigns.nvim" })

	use({ "akinsho/toggleterm.nvim" })

	use({ "github/copilot.vim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
