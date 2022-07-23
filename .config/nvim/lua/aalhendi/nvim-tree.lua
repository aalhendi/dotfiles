require("nvim-tree").setup()
local nnoremap = require('aalhendi.keymap').nnoremap

nnoremap('<leader>nt', ':NvimTreeToggle<CR>')
nnoremap('<leader>pv', ':NvimTreeToggle<CR>')
nnoremap('<c-b>', ':NvimTreeToggle<CR>')

