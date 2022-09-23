vim.lsp.set_log_level "warn"

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

if vim.fn.has "mac" == 1 then
    require "aalhendi.lsp.mac-configs"
    require("aalhendi.lsp.handlers").setup()
    require "aalhendi.lsp.null-ls"
    require("nvim-lsp-installer").setup({
	automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
	ui = {
	    icons = {
		server_installed = "✓",
		server_pending = "➜",
		server_uninstalled = "✗"
	    }
	}
    })
elseif vim.fn.has "unix" == 1 then
    require "aalhendi.lsp.linux-configs"
    require("aalhendi.lsp.handlers").setup()
    require "aalhendi.lsp.null-ls"
    require("mason").setup({
	ui = {
	    icons = {
		server_installed = "✓",
		server_pending = "➜",
		server_uninstalled = "✗"
	    }
	}
    })
else
    print "Unable to start LSP, unsupported platform"
end

