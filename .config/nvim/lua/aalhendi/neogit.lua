-- Neogit Setup
local nnoremap = require('aalhendi.keymap').nnoremap
local neogit = require('neogit')
nnoremap("<leader>gs", function()
    neogit.open({ })
end);

nnoremap("<leader>ga", "<cmd>!git fetch --all<CR>");

nnoremap("<leader>gs", function()
    neogit.open({ })
end);

