local augroup = vim.api.nvim_create_augroup
aalhendiGroup = augroup('aalhendi', {})


local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end
})

autocmd({"BufWritePre"}, {
    group = aalhendiGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

autocmd({"BufEnter", "BufRead"}, {
    group = aalhendiGroup,
    pattern = "*.astro",
    callback = function()
      vim.opt_local.filetype = 'astro'
      --nvim_exec('TSBufEnable highlight')
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

require("aalhendi.packer")
-- TODO: Move this
require'nvim-treesitter.configs'.setup { ensure_installed = {"c", "lua", "rust", "typescript", "prisma", "python"}, highlight = { enable = true } }
require('aalhendi.sets')
require('aalhendi.maps')
require('aalhendi.colorizer')
require('aalhendi.telescope')
require('aalhendi.cmp')
require('aalhendi.lualine')
require('aalhendi.nvim-tree')
require('aalhendi.bufferline')
require('aalhendi.neogit')
require('aalhendi.lsp')
require('symbols-outline').setup({highlight_hovered_item = true, show_guides = true})

