-- auto-install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand to reloads neovim on packer.lua file save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  -- Terminals
  use {"akinsho/toggleterm.nvim", tag = '*', config = function() require("toggleterm").setup() end}
  -- Core
  use {
	  "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }
  use 'lukas-reineke/indent-blankline.nvim'
  use {'numToStr/Comment.nvim',config = function() require('Comment').setup() end }
  use {'JoosepAlviste/nvim-ts-context-commentstring'}
  use 'mbbill/undotree' -- Undo tree with undo history

  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use {'nvim-telescope/telescope-fzy-native.nvim', requires = {'nvim-telescope/telescope.nvim'}}
  use {'nvim-telescope/telescope-media-files.nvim', requires = {'nvim-telescope/telescope.nvim'}}
  use { 'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons' }}

  -- AST
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/playground', requires = {'nvim-treesitter/nvim-treesitter'} }
  use {'nvim-treesitter/nvim-treesitter-textobjects',  requires = {'nvim-treesitter/nvim-treesitter'} }
  use {'nvim-treesitter/nvim-treesitter-context',  requires = {'nvim-treesitter/nvim-treesitter'} }
  use 'norcalli/nvim-colorizer.lua' -- Colorizer for hex

  -- LSP
  use {"williamboman/mason.nvim"}
  use {"williamboman/mason-lspconfig.nvim"}
  use { "RRethy/vim-illuminate"}
  use {'neovim/nvim-lspconfig'}
  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim',
    config = function ()
    	require("flutter-tools").setup{}
    end
  }
  -- CMP
  use {'hrsh7th/nvim-cmp', config = function() require('aalhendi.cmp') end }
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-nvim-lsp") -- Buffer complete
  use("hrsh7th/cmp-path") -- Path complete
  use("nvim-lua/lsp_extensions.nvim")
  use 'simrat39/symbols-outline.nvim' -- Symbols outline for LSP
  use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup{}
  end
}
  -- Snippets
  use {'L3MON4D3/LuaSnip', config = function() require('aalhendi.luasnip') end}
  use { 'saadparwaiz1/cmp_luasnip' }
  use "rafamadriz/friendly-snippets"

  -- Git
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use("ThePrimeagen/git-worktree.nvim")
  use("ThePrimeagen/harpoon")

  -- Debug
  use("mfussenegger/nvim-dap")
  use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'} }
  use { 'theHamsta/nvim-dap-virtual-text', requires = { {"mfussenegger/nvim-dap"}, {'nvim-treesitter/nvim-treesitter'} } }
  use 'vim-utils/vim-man' -- Read manuals with viman

  -- Style
  use 'gruvbox-community/gruvbox'
  use 'folke/tokyonight.nvim'
  use { 'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use 'sbdchd/neoformat' -- Prettier formatting for JS and friends

  -- Automatically set up your configuration after cloning packer.nvim
	-- place after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end

end)
