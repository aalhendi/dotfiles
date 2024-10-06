local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim' -- stdpath for OS compat
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- color scheme  
  {'folke/tokyonight.nvim'},
  { "blazkowolf/gruber-darker.nvim" },

  -- Syntax and ease of use
  {'tpope/vim-surround'}, -- HTML, XML, tags, brackets and parens
  {'tpope/vim-commentary'}, -- comment stuff out

  -- Fuzzy finders and search
  -- NOTE: Ripgrep is required for live_grep in telescope
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                          , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },


  -- Persist and toggle multiple terminals 
  {'akinsho/toggleterm.nvim', version = "*", config = true},
  -- UI
  {'nvim-tree/nvim-web-devicons'},
  -- LSP Support
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    }
  },
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'L3MON4D3/LuaSnip'}
    },
  },
})

vim.opt.termguicolors = true
vim.cmd.colorscheme('gruber-darker')

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
  },
})

-- Telescope stuff 
local builtin = require('telescope.builtin')
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', function() builtin.grep_string({search = vim.fn.input("Grep > ") }) end)
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
local cmp = require('cmp')
local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
sources = {
	{name = 'nvim_lsp'},
},
mapping = {
	['<C-l>'] = cmp.mapping.confirm({select = true}),
	['<CR>'] = cmp.mapping.confirm({select = true}),
	['<C-e>'] = cmp.mapping.abort(),
	['<C-u>'] = cmp.mapping.scroll_docs(-4),
	['<C-d>'] = cmp.mapping.scroll_docs(4),
	['<C-k>'] = cmp.mapping.select_prev_item(cmp_select_opts),
	['<C-j>'] = cmp.mapping.select_next_item(cmp_select_opts),
	['<C-p>'] = cmp.mapping(function()
		if cmp.visible() then
			cmp.select_prev_item(cmp_select_opts)
		else
			cmp.complete()
		end
	end),
	['<C-n>'] = cmp.mapping(function()
		if cmp.visible() then
			cmp.select_next_item(cmp_select_opts)
		else
			cmp.complete()
		end
	end),
},
snippet = {
	expand = function(args)
		require('luasnip').lsp_expand(args.body)
	end,
},
window = {
	documentation = {
		max_height = 15,
		max_width = 60,
	}
},
formatting = {
	fields = {'abbr', 'menu', 'kind'},
	format = function(entry, item)
		local short_name = {
			nvim_lsp = 'LSP',
			nvim_lua = 'nvim'
		}

		local menu_name = short_name[entry.source.name] or entry.source.name

		item.menu = string.format('[%s]', menu_name)
		return item
	end,
},
})

vim.wo.relativenumber = true
vim.bo.expandtab =  true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.ai = 2
vim.wo.colorcolumn = 80
