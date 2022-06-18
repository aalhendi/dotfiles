-- Sets
-- TODO: Move colorscheme 
vim.opt.clipboard = "unnamedplus" -- Set clipboardvim.bo.et = true -- Expand tab (spaces instead of tab character)
vim.bo.shiftwidth = 2 -- I like tabs to be 2 spaces 
vim.bo.sts = 2 -- Soft tab stop 2 spaces
vim.opt.nu = true -- Line numbering
vim.opt.rnu = true -- Relative line numbering
vim.opt.ch = 2 -- Command line height for more text
vim.opt_local.wrap = false -- No line wrap
vim.opt_local.scl = "yes" -- Sign column for linting
vim.opt.eb = false -- No error bells, ever. (off by default)
vim.opt.hid = true -- Keep buffers alive without saving
vim.opt.guicursor = "" -- Disable cursor styling
vim.opt.wmnu = true -- Wildmenu for autocompletes (on by default)
vim.opt.hls = false -- No highligh search
vim.opt.swapfile = false -- No swap file
vim.opt.backup = false -- No backup file
vim.opt.so = 8 -- Keep an 8 line window when scrolling down
vim.opt.ut = 150 -- Shorter update time
vim.opt.is = true -- Incremental search (on by default)
vim.opt_local.cc = "80" -- Color column 80 for visual aid. Prevent callback hell
vim.opt.bk = false -- No backup before overwriting (off by default)
vim.opt.sm = true -- Show matching brackets when bracket inserted
vim.opt.enc = "utf-8" -- Encoding to UTF-8 (utf-8 by default)
vim.opt.tgc = true -- Terminal gui colors
vim.cmd [[colorscheme gruvbox]] -- Set colorscheme
vim.opt.cot = "menuone,noinsert,noselect" -- Insert mode completion options
vim.opt.lz = true -- Lazy redraw. 

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
