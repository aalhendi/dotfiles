local augroup = vim.api.nvim_create_augroup
aalhendiGroup = augroup('aalhendi', {})


local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end
})

autocmd({"BufEnter", "BufWinEnter", "TabEnter"}, {
    group = aalhendiGroup,
    pattern = "*.rs",
    callback = function()
        require("lsp_extensions").inlay_hints{}
    end
})

autocmd({"BufWritePre"}, {
    group = aalhendiGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

require("aalhendi.packer")
require('aalhendi.sets')
require('aalhendi.maps')
require('aalhendi.colorizer')
require('aalhendi.telescope')
require('aalhendi.cmp')
require('aalhendi.lualine')
require('aalhendi.nvim-tree')
require('aalhendi.bufferline')
--require('aalhendi.lsp')
-- TODO: Eventually move to an LSP module which handles everything

-- LSP setup

--HTML Snippet thng
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.vuels.setup{}
require'lspconfig'.clangd.setup{
    root_dir = function() return vim.loop.cwd() end
}
require'lspconfig'.cmake.setup{}
require'lspconfig'.html.setup{capabilities=capabilities}
require'lspconfig'.cssls.setup{capabilities=capabilities}
require'lspconfig'.graphql.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    },
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


require('symbols-outline').setup({highlight_hovered_item = true, show_guides = true})


--Neogit Setup
local neogit = require('neogit')
neogit.setup {}
