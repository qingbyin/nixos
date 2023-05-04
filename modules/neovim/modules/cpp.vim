" Plugins
call add(g:coc_global_extensions, 'coc-clangd')
call add(g:coc_global_extensions, 'coc-clang-format-style-options')
call add(g:coc_global_extensions, 'coc-cmake')

" C/C++ comment style
autocmd FileType c,cpp,java,edp setlocal commentstring=//\ %s
