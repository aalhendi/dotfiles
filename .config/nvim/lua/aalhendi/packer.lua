-- Packer Setup
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  --Magit for vim, aka git stuff
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use 'jiangmiao/auto-pairs' -- Auto pairs for '(' '[' '{'
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-media-files.nvim'
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } 
  -- Additional textobjects for treesitter
  use {'nvim-treesitter/nvim-treesitter-textobjects' }
  use 'norcalli/nvim-colorizer.lua' -- Colorizer for hex
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-compe' -- Autocompletion plugin
  use 'simrat39/symbols-outline.nvim' -- Symbols outline for LSP
  use {
  'nvim-lualine/lualine.nvim',
  requires = {'kyazdani42/nvim-web-devicons', opt = true}
}
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'gruvbox-community/gruvbox'
  -- Prettier formatting for JS and friends
  --use 'sbdchd/neoformat'
  use {'prettier/vim-prettier', 
    run = 'yarn install', 
    ft = { 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html' }
  }
  use 'mbbill/undotree' -- Undo tree with undo history
  use 'vim-utils/vim-man' -- Read manuals with viman
end)
