local function on_attach()
    --Dunno
    require'compe'
end

require'lspconfig'.pyright.setup{on_attach=on_attach}
require'lspconfig'.tsserver.setup{on_attach=on_attach}
require'lspconfig'.clangd.setup{
    on_attach=on_attach,
    root_dir = function() return vim.loop.cwd() end
}


local opts ={
    highlight_hovered_item = true,
    show_guides = true,
}

require('symbols-outline').setup(opts)
