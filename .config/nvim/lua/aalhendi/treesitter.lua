local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
  ensure_installed = {"c", "bash", "javascript", "json", "lua", "rust", "typescript", "prisma", "python"},
  highlight = { enable = true },
  context_commentstring = {enable = true },
	ignore_install = { "" }, -- ignore
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "css" } },
})
