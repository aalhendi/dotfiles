-- MAPS
local neogit = require('neogit')
local nnoremap = require('aalhendi.keymap').nnoremap
local inoremap = require('aalhendi.keymap').inoremap
local vnoremap = require('aalhendi.keymap').vnoremap

--Remap space as leader key
vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Open file explorer
nnoremap('<leader>pv', ":Ex<CR>")

-- Y yank until the end of line
nnoremap('Y', 'y$')

-- Toggle undo tree
nnoremap('<F5>', ':UndotreeToggle<CR>')

-- Keep cursor centered
nnoremap('n', 'nzzzv')
nnoremap('N', 'Nzzzv')
nnoremap('J', 'mzJ`z')

-- Undo breakpoints
inoremap(',', ',<c-g>u')
inoremap('.', '.<c-g>u')
inoremap('!', '!<c-g>u')
inoremap('?', '?<c-g>u')

-- Jumplist mutations
nnoremap('<expr> k', '?<c-g>u')

-- Moving text
nnoremap('<leader>k', ':m .-2<CR>==')
nnoremap('<leader>j', ':m .+1<CR>==')
inoremap('<C-k>', '<esc>:m .-2<CR>==')
inoremap('<C-j>', '<esc>:m .+1<CR>==')
vnoremap('J', ":m '>+1<CR>gv=gv")
vnoremap('K', ":m '>-2<CR>gv=gv")


-- Telescope
nnoremap('<leader>ps', ":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep for > ') })<CR>")
nnoremap('<leader>pf', ":lua require('telescope.builtin').find_files()<CR>")
nnoremap('<C-p>', ":lua require('telescope.builtin').git_files()<CR>")
nnoremap('<leader>pw', ":lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>')})<CR>")

-- Neogit
local neogit = require('neogit')
nnoremap("<leader>gs", function()
    neogit.open({ })
end);

nnoremap("<leader>ga", "<cmd>!git fetch --all<CR>");
