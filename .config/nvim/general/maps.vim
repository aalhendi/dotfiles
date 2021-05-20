nnoremap <F5> :UndotreeToggle<CR>

" Mappings to move lines
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
" inoremap <leader>j <Esc>:m .+1<CR>==gi
" inoremap <leader>k <Esc>:m .-2<CR>==gi
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv
