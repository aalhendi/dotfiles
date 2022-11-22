-- MAPS
--local neogit = require('neogit')
local nnoremap = require('aalhendi.keymap').nnoremap
local inoremap = require('aalhendi.keymap').inoremap
local vnoremap = require('aalhendi.keymap').vnoremap
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
nnoremap('<leader>k', ':m .-2<CR>==')
nnoremap('<leader>j', ':m .+1<CR>==')
inoremap('<C-k>', '<esc>:m .-2<CR>==')
inoremap('<C-j>', '<esc>:m .+1<CR>==')
vnoremap('J', ":m '>+1<CR>gv=gv")
vnoremap('K', ":m '>-2<CR>gv=gv")
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)
-- Visual Block --
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
