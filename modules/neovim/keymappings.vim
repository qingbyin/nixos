" Basic key mappings

" Map <space> to <leader>
let mapleader ="\<Space>"
let maplocalleader = "\\"

" Move to the line head/tail
nnoremap H 0
nnoremap L $
" Save the current file
nnoremap <silent> <C-s> :w<CR>

" use alt + hjkl to resize windows
nnoremap <silent> <M-j> :resize -2<CR>
nnoremap <silent> <M-k> :resize +2<CR>
nnoremap <silent> <M-h> :vertical resize -2<CR>
nnoremap <silent> <M-l> :vertical resize +2<CR>
" Switch between buffer windows
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
" Move in the command mode (i.e. in :cmd)
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>

" copy to the system clipboard
nnoremap <silent> <leader>yy "+yy
vnoremap <silent> <leader>y "+y

" Disable build-in help key F1
nmap <F1> <nop>
imap <F1> <nop>
" TODO Add reason
inoremap <c-j> <nop>

" whichkey
call minpac#add('liuchengxu/vim-which-key')
nnoremap <silent> <Leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <Leader> :<c-u>WhichKeyVisual '<Space>'<CR>
