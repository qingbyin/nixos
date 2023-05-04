" Basic config, i.e. build-in parameters without plugins

" Tab settings
set expandtab  " Convert tab to spaces automatically
set tabstop=4  " 1 tab = 4 spaces
set shiftwidth=4
set encoding=utf8

" Vertical ruler
set colorcolumn=80,100,120
" Hybrid line numbers
set number relativenumber

" Hard wrap settings (only break at the end of a word)
set textwidth=80
" Enable Chinese characters wrap, see ":help fo-table"
set formatoptions+=m
" When joning lines, don't insert a space before/after a Chinese characters.
set formatoptions+=M
" Disable soft wrap
set nowrap

" Vertical splits will automatically be to the right
set splitright
" Horizontal splits will automatically be below
set splitbelow

" Enable highlightling of the current line
set cursorline

" Command line auto completion
set wildmode=longest:full,full

" pop menu height
set pumheight=10

" Enable mouse in normal/visual/insert mode
set mouse=nvi

" Immediately update (default is 4000 ms = 4 s, too slow)
" e.g. Immediately update gutter signs
set updatetime=300

" By default the sign column will appear when there are signs to show and
" disappear when there aren't. To always have the sign column
set signcolumn=yes

" Get rid of highlighting matches after searching text
set nohlsearch
