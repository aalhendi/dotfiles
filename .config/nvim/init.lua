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

-- Packer for Plugins
require("aalhendi.packer")

-- Sets
require('aalhendi.sets')

-- Maps
require('aalhendi.maps')

-- Colorizer setup
require('aalhendi.colorizer')

-- Telescope setup
require('aalhendi.telescope')

-- Compe setup
require('aalhendi.compe')

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

--Neogit Setup
local neogit = require('neogit')

neogit.setup {}

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
