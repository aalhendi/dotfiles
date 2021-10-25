-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'jiangmiao/auto-pairs' -- Auto pairs for '(' '[' '{'
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-media-files.nvim'
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' } 
  -- Additional textobjects for treesitter
  use {'nvim-treesitter/nvim-treesitter-textobjects', branch = '0.5-compat' }
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

-- Sets
vim.o.clipboard = "unnamedplus" -- Set clipboard
vim.bo.et = true -- Expand tab (spaces instead of tab character)
vim.bo.shiftwidth = 2 -- I like tabs to be 2 spaces 
vim.bo.sts = 2 -- Soft tab stop 2 spaces
vim.o.nu = true -- Line numbering
vim.o.rnu = true -- Relative line numbering
vim.o.ch = 2 -- Command line height for more text
vim.wo.wrap = false -- No line wrap
vim.wo.scl = "yes" -- Sign column for linting
vim.o.eb = false -- No error bells, ever. (off by default)
vim.o.hid = true -- Keep buffers alive without saving
vim.o.gcr = "" -- Disable cursor styling
vim.o.wmnu = true -- Wildmenu for autocompletes (on by default)
vim.o.hls = false -- No highligh search
vim.o.swapfile = false -- No swap file
vim.o.so = 8 -- Keep an 8 line window when scrolling down
vim.o.ut = 150 -- Shorter update time
vim.o.is = true -- Incremental search (on by default)
vim.wo.cc = "80" -- Color column 80 for visual aid. Prevent callback hell
vim.o.bk = false -- No backup before overwriting (off by default)
vim.o.sm = true -- Show matching brackets when bracket inserted
vim.o.enc = "utf-8" -- Encoding to UTF-8 (utf-8 by default)
vim.o.tgc = true -- Terminal gui colors
vim.cmd [[colorscheme gruvbox]] -- Set colorscheme
vim.o.cot = "menuone,noinsert,noselect" -- Insert mode completion options
vim.o.lz = true -- Lazy redraw. 

-- Clipboard settings ? unnamed vs unnamedplus 
vim.cmd([[
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
]])

-- MAPS START --

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Toggle undo tree
vim.api.nvim_set_keymap('n', '<F5>', ':UndotreeToggle<CR>', { noremap = true })

-- Keep cursor centered
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true  })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true  })
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', { noremap = true  })

-- Undo breakpoints
vim.api.nvim_set_keymap('i', ',', ',<c-g>u', { noremap = true  })
vim.api.nvim_set_keymap('i', '.', '.<c-g>u', { noremap = true  })
vim.api.nvim_set_keymap('i', '!', '!<c-g>u', { noremap = true  })
vim.api.nvim_set_keymap('i', '?', '?<c-g>u', { noremap = true  })

-- Jumplist mutations
--vim.api.nvim_set_keymap('n', '<expr> k', '?<c-g>u', { noremap = true  })

-- Moving text
vim.api.nvim_set_keymap('n', '<leader>k', ':m .-2<CR>==', { noremap = true  })
vim.api.nvim_set_keymap('n', '<leader>j', ':m .+1<CR>==', { noremap = true  })
vim.api.nvim_set_keymap('i', '<C-k>', '<esc>:m .-2<CR>==', { noremap = true  })
vim.api.nvim_set_keymap('i', '<C-j>', '<esc>:m .+1<CR>==', { noremap = true  })
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true  })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true  })

-- MAPS END --


-- Colorizer setup
require'colorizer'.setup(
  {'*';},
  {       RGB      = true;         -- #RGB hex codes
	  RRGGBB   = true;         -- #RRGGBB hex codes
	  names    = true;         -- "Name" codes like Blue
	  RRGGBBAA = true;         -- #RRGGBBAA hex codes
	  rgb_fn   = true;         -- CSS rgb() and rgba() functions
	  hsl_fn   = true;         -- CSS hsl() and hsla() functions
	  css      = true;         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	  css_fn   = true;         -- Enable all CSS *functions*: rgb_fn, hsl_fn
  })

-- Telescope setup
require("telescope").setup {
  defaults = {
    -- Your defaults config goes in here
    'rg',
    '--with-filename',
    '--no-heading',
    '--line-number',
    '--column',
    '--smart-case'
  },
  prompt_position = "bottom",
  prompt_prefix = " >",
  selection_caret = "> ",
  entry_prefix = "  ",
  initial_mode = "insert",
  selection_strategy = "reset",
  sorting_strategy = "descending",
  layout_strategy = "horizontal",
  layout_defaults = {
    horizontal = {
      mirror = false,
    },
    vertical = {
      mirror = false,
    },
  },
  file_sorter =  require'telescope.sorters'.get_fzy_sorter,
  file_ignore_patterns = {},
  generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
  shorten_path = true,
  winblend = 0,
  width = 0.75,
  preview_cutoff = 120,
  results_height = 1,
  results_width = 0.8,
  border = {},
  borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  color_devicons = true,
  use_less = true,
  set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
  file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
  grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
  qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  pickers = {
    -- Your special builtin config goes in here
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
          ["<C-x>"] = false,
          ["<C-q>"] = require("telescope.actions").send_to_qflist,
        },
        n = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        }
      }
    },
    find_files = {
      theme = "dropdown"
    }
  },
  extensions = {
    -- Your extension config goes in here
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
      },
    media_files =  {
      find_cmd = "rg",
      filetypes = {"png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf"},
    },
  }
}
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('media_files')


-- Telescope mappings--
vim.api.nvim_set_keymap('n', '<leader>ps', ":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep for > ') })<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pf', ":lua require('telescope.builtin').find_files()<CR>", { noremap = true } )
vim.api.nvim_set_keymap('n', '<C-p>', ":lua require('telescope.builtin').git_files()<CR>", {noremap = true})

-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

-- Compe mappings
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- LSP setup
local function on_attach()
    --Dunno
    require('compe')
end

--HTML Snippet thng
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.pyright.setup{on_attach=on_attach}
require'lspconfig'.tsserver.setup{on_attach=on_attach}
require'lspconfig'.clangd.setup{on_attach=on_attach}
require'lspconfig'.bashls.setup{on_attach=on_attach}
require'lspconfig'.vuels.setup{on_attach=on_attach}
require'lspconfig'.clangd.setup{
    on_attach=on_attach,
    root_dir = function() return vim.loop.cwd() end
}
require'lspconfig'.cmake.setup{on_attach=on_attach}
require'lspconfig'.html.setup{on_attach=on_attach, capabilities=capabilities}
require'lspconfig'.cssls.setup{on_attach=on_attach, capabilities=capabilities}
require'lspconfig'.graphql.setup{on_attach=on_attach}
require'lspconfig'.yamlls.setup{on_attach=on_attach}
require'lspconfig'.jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    },
    on_attach=on_attach
}

local system_name
local sumneko_root_path
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
  sumneko_root_path = "/Users/aalhendi/Desktop/stuff/Development/lua-language-server"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
  sumneko_root_path = "/usr/bin/lua-language-server"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
--local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


local opts ={
    highlight_hovered_item = true,
    show_guides = true,
}

require('symbols-outline').setup(opts)

-- Prettier setup
vim.cmd ([[
nmap <Leader>py <Plug>(Prettier)
let g:prettier#autoformat = 1

" Max line length that prettier will wrap on: a number or 'auto' (use
" textwidth).
" default: 'auto'
let g:prettier#config#print_width = 'auto'

" number of spaces per indentation level: a number or 'auto' (use
" softtabstop)
" default: 'auto'
let g:prettier#config#tab_width = 'auto'

" use tabs instead of spaces: true, false, or auto (use the expandtab setting).
" default: 'auto'
let g:prettier#config#use_tabs = 'auto'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown or empty string
" (let prettier choose).
" default: ''
let g:prettier#config#parser = ''

" cli-override|file-override|prefer-file
" default: 'file-override'
let g:prettier#config#config_precedence = 'file-override'

" always|never|preserve
" default: 'preserve'
let g:prettier#config#prose_wrap = 'preserve'

" css|strict|ignore
" default: 'css'
let g:prettier#config#html_whitespace_sensitivity = 'css'

" false|true
" default: 'false'
let g:prettier#config#require_pragma = 'false'

" Define the flavor of line endings
" lf|crlf|cr|all
" defaut: 'lf'
let g:prettier#config#end_of_line = get(g:, 'prettier#config#end_of_line', 'lf')

]])

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp', 'coc'}}},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {},
  theme = 'gruvbox'
}

-- NERDTREE Setup maybe
--[[
" Allow line numbers
let NERDTreeShowLineNumbers=1
" Open
nmap <C-f> :NERDTreeToggle<CR>
" Comment
augroup NERDTREE
    autocmd!
    " Enable relative line numbers in NERDTree
    autocmd FileType nerdtree setlocal relativenumber
    " Open automatically on start
    " autocmd VimEnter * NERDTree
    " Smart closing
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END
" Make NERDTree scrolling faster (prevent lag)
let NERDTreeHighlightCursorline = 0
--]]
