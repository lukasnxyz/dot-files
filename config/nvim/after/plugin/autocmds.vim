autocmd BufWritePre * %s/\s\+$//e
autocmd BufEnter * silent! :lcd%:p:h

" auto place cursor where it was last when opening a file
if has("autocmd")
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
			\| exe "normal! g'\"" | endif
endif
