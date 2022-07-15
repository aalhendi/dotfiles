-- Sets
-- TODO: Move colorscheme
vim.opt.clipboard = "unnamedplus" -- Set clipboardvim.bo.et = true -- Expand tab (spaces instead of tab character)
vim.opt.shiftwidth = 2 -- I like tabs to be 2 spaces
vim.opt.softtabstop = 2 -- Soft tab stop 2 spaces
vim.opt.number = true -- Line numbering
vim.opt.relativenumber = true -- Relative line numbering
vim.opt.cmdheight = 2 -- Command line height for more text
vim.opt.wrap = false -- No line wrap
vim.opt.signcolumn = "yes:1" -- Sign column for linting
vim.opt.errorbells = false -- No error bells, ever. (off by default)
vim.opt.hidden = true -- Keep buffers alive without saving
vim.opt.guicursor = "" -- Disable cursor styling
vim.opt.wildmenu = true -- Wildmenu for autocompletes (on by default)
vim.opt.hlsearch = false -- No highligh search
vim.opt.swapfile = false -- No swap file
vim.opt.backup = false -- No backup file
vim.opt.scrolloff = 8 -- Keep an 8 line window when scrolling down
vim.opt.updatetime = 150 -- Shorter update time
vim.opt.incsearch = true -- Incremental search (on by default)
vim.opt.colorcolumn = '80' -- Color column 80 for visual aid. Prevent callback hell
vim.opt.showmatch = true -- Show matching brackets when bracket inserted
vim.opt.encoding = "utf-8" -- Encoding to UTF-8 (utf-8 by default)
vim.opt.termguicolors = true -- Terminal gui colors
vim.cmd [[colorscheme gruvbox]] -- Set colorscheme
vim.opt.cot = "menuone,noinsert,noselect" -- Insert mode completion options
vim.opt.lazyredraw = true -- Lazy redraw.

-- Clipboard settings ? unnamed vs unnamedplus
vim.cmd([[
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
]])
