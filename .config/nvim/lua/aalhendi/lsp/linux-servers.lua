

-- -- SERVERS
-- lspconfig.pyright.setup {
--     capabilites = capabilities,
--     root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
-- }

-- require'lspconfig'.bashls.setup{}
-- require'lspconfig'.vuels.setup{}
-- require'lspconfig'.clangd.setup{
--     root_dir = function() return vim.loop.cwd() end
-- }
-- require'lspconfig'.cmake.setup{}
-- require'lspconfig'.html.setup{capabilities=capabilities}
-- require'lspconfig'.cssls.setup{capabilities=capabilities}
-- require'lspconfig'.graphql.setup{}
-- require'lspconfig'.yamlls.setup{}
-- require'lspconfig'.eslint.setup{}
-- require'lspconfig'.jsonls.setup {
--     commands = {
--       Format = {
--         function()
--           vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
--         end
--       }
--     },
-- }

-- lspconfig.tsserver.setup {
--     capabilites = capabilities,
--     root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
-- }

-- require("nlua.lsp.nvim").setup(require "lspconfig", {
--     capabilites = capabilities,
-- })
