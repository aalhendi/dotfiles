local function on_attach()
    --Dunno
    require'compe'
end

--HTML Snippet thng
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.pyright.setup{on_attach=on_attach}
require'lspconfig'.tsserver.setup{on_attach=on_attach}
require'lspconfig'.clangd.setup{
    on_attach=on_attach,
    root_dir = function() return vim.loop.cwd() end
}
require'lspconfig'.html.setup{on_attach=on_attach, capabilities=capabilities}
require'lspconfig'.cssls.setup{on_attach=on_attach, capabilities=capabilities}

local opts ={
    highlight_hovered_item = true,
    show_guides = true,
}

require('symbols-outline').setup(opts)
