-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- TODO: Convert to new autocmd api
vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

-- Packer Setup
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  use 'jiangmiao/auto-pairs' -- Auto pairs for '(' '[' '{'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
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
  use {'neovim/nvim-lspconfig'}
  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim',
    config = function ()
    	require("flutter-tools").setup{}
    end
  }
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("nvim-lua/lsp_extensions.nvim")
  use 'simrat39/symbols-outline.nvim' -- Symbols outline for LSP
  use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup {
      -- default settings
    }
  end
}
  use {
    'hrsh7th/nvim-cmp',
    config = function() require('aalhendi.cmp') end,
  }
  use { 'saadparwaiz1/cmp_luasnip' }
  use {
    'L3MON4D3/LuaSnip',after = 'nvim-cmp',
    config = function() require('aalhendi.luasnip') end,
  }
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
  use { 'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use 'sbdchd/neoformat' -- Prettier formatting for JS and friends

end)
