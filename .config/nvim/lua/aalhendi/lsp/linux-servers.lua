-- try to import lspconfig
local lspconfig = require "lspconfig"
if not lspconfig then
    return
end
local utils = require "aalhendi.utils"

-- tell lsp about nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

utils.info("Initilizing LSP server in containers", "LSP")

require("lspconfig").pyright.setup {
    before_init = function(params)
        params.processId = vim.NIL
    end,
    on_init = require("aalhendi.lsp.utils").custom_on_init,
    on_attach = require("aalhendi.lsp.utils").on_attach,
    capabilites = capabilities,
    cmd = require("lspcontainers").command "pyright",
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),

    handlers = {
        -- pyright ignores dynamicRegistration settings
        ["client/registerCapability"] = function(_, _, _, _)
            return {
                result = nil,
                error = nil,
            }
        end,
    },
}

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

require("lspconfig").tsserver.setup {
    before_init = function(params)
        params.processId = vim.NIL
    end,
    on_init = require("aalhendi.lsp.utils").custom_on_init,
    on_attach = require("aalhendi.lsp.utils").on_attach,
    capabilites = capabilities,
    cmd = require("lspcontainers").command "tsserver",
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
}

require("nlua.lsp.nvim").setup(require "lspconfig", {
    on_init = require("aalhendi.lsp.utils").custom_on_init,
    on_attach = require("aalhendi.lsp.utils").on_attach,
    cmd = require'lspcontainers'.command('sumneko_lua'),
    capabilites = capabilities,
    -- Include globals you want to tell the LSP are real :)
    globals = {
        -- Colorbuddy
        "Color",
        "c",
        "Group",
        "g",
        "s",
    },
})
