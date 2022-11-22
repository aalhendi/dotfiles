local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end
luasnip.filetype_extend("astro", {"html"})
luasnip.filetype_extend("javascriptreact", {"html"})
luasnip.filetype_extend("typescriptreact", {"html"})

