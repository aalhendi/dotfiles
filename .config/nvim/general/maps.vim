nnoremap <F5> :UndotreeToggle<CR>

" Mappings to move lines
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
" inoremap <leader>j <Esc>:m .+1<CR>==gi
" inoremap <leader>k <Esc>:m .-2<CR>==gi
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv

"Compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
