" Mimic emacs magit
call minpac#add('TimUntersberger/neogit')
call minpac#add('nvim-lua/plenary.nvim') " Required by neogit
lua require('neogit-config')
nmap <space>M :Neogit kind=split<cr>


" Show git differ on the gutter
call minpac#add('lewis6991/gitsigns.nvim')
lua require('gitsigns-config')
" Set SignColumn background color (same as the lineNumber bg color)
highlight! link SignColumn LineNr

" keymappings
" Disable its default
" hunk info 
nmap <space>gp :Gitsigns preview_hunk<CR>
nmap <space>gd :Gitsigns toggle_deleted<CR>
nmap <space>gu :Gitsigns undo_stage_hunk<CR>
" Stage hunk
nmap gs :Gitsigns stage_hunk<CR>
" Jump to previous/next hunk
nmap gk :Gitsigns prev_hunk<CR>
nmap gj :Gitsigns next_hunk<CR>
