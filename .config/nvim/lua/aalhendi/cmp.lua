local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load("")

-- Utils
local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local lsp_symbols = {
    Text = "   (Text) ",
    Method = "   (Method)",
    Function = "   (Function)",
    Constructor = "   (Constructor)",
    Field = " ﴲ  (Field)",
    Variable = "[] (Variable)",
    Class = "   (Class)",
    Interface = " ﰮ  (Interface)",
    Module = "   (Module)",
    Property = "  (Property)",
    Unit = "   (Unit)",
    Value = "   (Value)",
    Enum = " ℰ (Enum)",
    Keyword = "   (Keyword)",
    Snippet = "   (Snippet)",
    Color = "   (Color)",
    File = "   (File)",
    Reference = "   (Reference)",
    Folder = "   (Folder)",
    EnumMember = "   (EnumMember)",
    Constant = " ﲀ  (Constant)",
    Struct = " ﳤ  (Struct)",
    Event = "   (Event)",
    Operator = "   (Operator)",
    TypeParameter = "   (TypeParameter)",
}

cmp.setup {
    confirmation = { default_behaviour = cmp.ConfirmBehavior.Replace },
    sources = {
        { name = "nvim_lsp", priority = 8 },
        { name = "cmp_tabnine", priority = 8, max_item_count = 3 },
        { name = "treesitter", priority = 7 },
        { name = "buffer", priority = 7, keyword_length = 5 },
        { name = "nvim_lua", priority = 5 },
        { name = "luasnip", priority = 5 },
        { name = "copilot", priority = 5, max_item_count = 3 },
        { name = "path", priority = 4 },
    },

    sorting = {
        priority_weight = 1.0,
        comparators = {
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            cmp.config.compare.order,
        },
    },

    mapping = {
        ["<CR>"] = cmp.mapping.confirm { select = false },
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    formatting = {
        fields = {"kind", "abbr", "menu"},
        format = function(entry, item)
            item.kind = string.format("%s", lsp_symbols[item.kind])
            if entry.source.name == "cmp_tabnine" then
                item.kind = "   (TabNine)"
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    item.kind = "   (" .. entry.completion_item.data.detail .. ")"
                end
            end
            item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                path = "[Path]",
                buffer = "[Buffer]",
                cmp_tabnine = "[T9]",
                nvim_lua = "[NLUA]",
                treesitter = "[TS]",
                copilot = "[CoPilot]",
            })[entry.source.name]
            return item
        end,
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            scrollbar = "║",
            autocomplete = {
                require("cmp.types").cmp.TriggerEvent.InsertEnter,
                require("cmp.types").cmp.TriggerEvent.TextChanged,
            },
        },
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            scrollbar = "║",
        },
    },
    experimental = {
        ghost_text = true,
    },
}
