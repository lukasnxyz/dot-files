" local filetype settings
autocmd FileType tex setlocal wrap tw=100
autocmd FileType markdown setlocal wrap tw=100
autocmd FileType vimwiki setlocal wrap tw=100

autocmd InsertEnter * set cursorcolumn
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorcolumn
autocmd InsertLeave * set nocursorline

autocmd BufWritePre * %s/\s\+$//e
autocmd BufEnter * silent! :lcd%:p:h

" auto place cursor where it was last when opening a file
if has("autocmd")
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
			\| exe "normal! g'\"" | endif
endif
