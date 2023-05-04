" Editor plugins

" Easy to add/delete/change pairs
call minpac#add('tpope/vim-surround')
" Cooporated with surround.vim, so that ds, cs, yss can be repeated
call minpac#add('tpope/vim-repeat')

" Comment using <gcc>
call minpac#add('tpope/vim-commentary')

" Easy motion
call minpac#add('justinmk/vim-sneak')
let g:sneak#label = 1

" Smooth scroll
call minpac#add('psliwka/vim-smoothie')
call minpac#add('rhysd/accelerated-jk')
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" Delete buffers (close files) without closing your windows 
call minpac#add('moll/vim-bbye')
" Kill the buffer without closing the window
nnoremap <silent> <Leader>q :Bdelete<CR>

" Reopen files at the last edit position
call minpac#add('farmergreg/vim-lastplace')

" Explorer
call minpac#add('nvim-tree/nvim-tree.lua')
call minpac#add('nvim-tree/nvim-web-devicons') " For file icons
" Config
lua require('nvim-tree-config')
" Keymapping
nmap <space>e :NvimTreeToggle<cr>

" Auto pair
" all add(g:coc_global_extensions, 'coc-pairs')

" Highlight word under cursor and its occurrences
" also color colorcodes, e.g. #ff0000
" call add(g:coc_global_extensions, 'coc-highlight')
" call add(g:coc_global_extensions, 'coc-spell-checker')

" Highlight yanked text and persist yank list across vim.
" Make sure have `:echo exists('##TextYankPost')`
" call add(g:coc_global_extensions, 'coc-yank')

