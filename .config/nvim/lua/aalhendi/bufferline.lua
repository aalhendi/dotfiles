require("bufferline").setup{}
local nnoremap = require('aalhendi.keymap').nnoremap

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap('<leader>]]', ':BufferLineCycleNext<CR>')
nnoremap('<leader>[[', ':BufferLineCyclePrev<CR>')

-- These commands will move the current buffer backwards or forwards in the bufferline
nnoremap('<leader>{{', ':BufferLineMoveNext<CR>')
nnoremap('<leader>}}', ':BufferLineMovePrev<CR>')




-- These commands will sort buffers by directory, language, or a custom criteria
nnoremap('<leader>be', ':BufferLineSortByExtension<CR>')
nnoremap('<leader>bd', ':BufferLineSortByDirectory<CR>')
--nnoremap('<leader>bd', ':lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>')
