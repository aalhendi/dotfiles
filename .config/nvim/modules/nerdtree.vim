" NERD TREE
" Allow line numbers
let NERDTreeShowLineNumbers=1
" Open
nmap <C-f> :NERDTreeToggle<CR>
" Comment
augroup NERDTREE
    autocmd!
    " Enable relative line numbers in NERDTree
    autocmd FileType nerdtree setlocal relativenumber
    " Open automatically on start
    " autocmd VimEnter * NERDTree
    " Smart closing
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END
" Make NERDTree scrolling faster (prevent lag)
let NERDTreeHighlightCursorline = 0
set lazyredraw
