local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
    -- formatting
    b.formatting.stylua,
    --   conditional enabling
    --   b.formatting.stylua.with({
    --     condition = function(utils)
    --         return utils.root_has_file("stylua.toml")
    --     end,
    -- }),
}

null_ls.setup {
    sources = sources,
    on_attach = require("lsp.utils").on_attach,
}
