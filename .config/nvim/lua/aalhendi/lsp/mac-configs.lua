local status_ok, masonconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = { "jsonls", "sumneko_lua", "pyright", "tsserver", "astro",
		  "cssls", "html",  "clangd",  "graphql", "rust_analyzer",
		  "tailwindcss", "rust_analyzer" }

masonconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("aalhendi.lsp.handlers").on_attach,
		capabilities = require("aalhendi.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "aalhendi.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end
