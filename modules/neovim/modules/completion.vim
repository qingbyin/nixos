"
" Autocompletion and lsp support
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
" Add common extensions
let g:coc_global_extensions = ['coc-lists', 'coc-snippets', 'coc-pairs']

" Config coc
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
highlight CocHighlightText  guibg=#646470 ctermbg=223
" Set highlight for the selected line when using CocList grep
highlight CocListLine ctermfg=237 guibg=#13354A

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" -------------------------------------------------------------------
"  Key mappings
" -------------------------------------------------------------------
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gf <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Show outline in tree view
nnoremap go :CocOutline<CR>
" Find symbol of current document.
nnoremap <silent><nowait> <Leader>o  :<C-u>CocList outline<cr>
" Mouse hover
nnoremap <silent> gh :call CocActionAsync('doHover')<CR>
" Diagnostics (similar to VS Code problem windows)
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" Show all diagnostics.
nnoremap <silent><nowait> ga  :<C-u>CocList diagnostics<cr>

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" Toggle fix suggestions for a word (used to fix spell error, code error...)
nmap <C-space> <Plug>(coc-codeaction-selected)w

" Remap <C-b> and <C-f> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Search files from current cwd
" List opened files (i.e. buffers)
nmap <C-p> :CocList buffers<CR>
" Mimic quick open key in VS Code
nmap <M-p> :CocList files<CR>

" Find word in current buffer
nmap <silent> <space>f :CocList words<CR>
" Find current word in current buffer (and enter normal mode in the list)
nmap <silent> <space>w :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
" Find in current cwd
nmap <silent> <space>F :CocList grep<CR>

" Show all commands (Similar to ctrl+shift+p in VS Code)
nnoremap <silent><nowait> <space>x  :<C-u>CocList commands<cr>

" -------------------------------------------------------------------
" Snippet config
" Jump after inserting a snippet
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for "visual mode" placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Make <tab> used for trigger completion, completion confirm,
" Use <TAB> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ?
    \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ CheckBackSpace() ? "\<TAB>" :
    \ coc#refresh()

  function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Do not use <Enter> key to trigger completion
inoremap <expr> <CR> pumvisible() ? "\<C-E>\<CR>" : "\<CR>"
