let mapleader ="\<Space>"
" Open Vs Code explorer
nnoremap <leader>e :call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
xnoremap <leader>e :call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>

" Toggle zen mode
nnoremap <leader>z :call VSCodeNotify('workbench.action.toggleZenMode')<CR>
xnoremap <leader>z :call VSCodeNotify('workbench.action.toggleZenMode')<CR>

" Find and Replac
" in local file
nnoremap <leader>f :call VSCodeNotify('editor.action.startFindReplaceAction')<CR>
xnoremap <leader>f :call VSCodeNotify('editor.action.startFindReplaceAction')<CR>
" in project
nnoremap <leader>F :call VSCodeNotify('workbench.action.replaceInFiles')<CR>
xnoremap <leader>F :call VSCodeNotify('workbench.action.replaceInFiles')<CR>

" BookMark
nnoremap <leader>m :call VSCodeNotify('bookmarks.toggle')<CR>
xnoremap <leader>m :call VSCodeNotify('bookmarks.toggle')<CR>
nnoremap <leader>b :call VSCodeNotify('bookmarks.list')<CR>
xnoremap <leader>b :call VSCodeNotify('bookmarks.list')<CR>


" Commentary
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" Better switch between tabs
nmap <Tab> :Tabnext<CR>
nmap <S-Tab> :Tabprev<CR>

" Better Navigation of split windows
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

" Code Navigation (builin + custom)
" Show hover: gh/ K
" Open definition aside: <C-w>gd
" Show Definition: gd / c-]
" Peek Definition: gD
" Show Declaration: gf
" Peek Declaration: gF
" Peek Focus: Tab
" Go to symbol: go

xnoremap <leader>x <Cmd>call VSCodeNotifyVisual('workbench.action.showCommands', 1)<CR>


" Close editor
nnoremap <silent> <leader>q :call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

" Latex
nnoremap <silent> <leader>v :call VSCodeNotify('latex-workshop.synctex')<CR>

" Git
nmap gj :call VSCodeNotify('workbench.action.editor.nextChange')<CR>
nmap gk :call VSCodeNotify('workbench.action.editor.previousChange')<CR>
nnoremap <silent> <leader>gg :call VSCodeNotify('workbench.action.tasks.runTask', 'close_lazygit')<CR>

" Switch input method
" Need to download im-select.exe in https://github.com/daipeihust/im-select
" autocmd InsertLeave * :silent !~/.local/bin/im-select 1033

