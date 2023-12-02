" --- Parameteres
let mapleader = " "
colorscheme minimalist
syntax on
filetype plugin on

set number relativenumber
set nowrap
set showcmd
set noerrorbells
set nohlsearch
set nocompatible
set autowriteall

set complete+=kspell
set wildmode=longest,list,full
set completeopt=menuone,longest
set previewpopup=height:15,width:60

set noswapfile
set undodir=~/.vim/undodir
set viminfo='100,n$HOME/.vim/files/info/viminfo
set nobackup
set undofile

set tabstop=4
set shiftwidth=4
set smartindent
set incsearch
set ignorecase

set updatetime=50
set encoding=UTF-8

autocmd FileType tex setlocal wrap tw=120
autocmd FileType markdown setlocal wrap tw=120
autocmd FileType vimwiki setlocal wrap tw=120

autocmd BufWritePre * %s/\s\+$//e
autocmd BufEnter * silent! :lcd%:p:h

" Auto place cursor where it was last when opening a file
if has("autocmd")
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
			\| exe "normal! g'\"" | endif
endif

" --- Keybindings
command! W w

noremap fj 0cw<bs><cr><esc>
noremap <leader>r :%s///g<Left><Left><Left>
noremap <leader>/ :set hlsearch!<CR>
noremap <leader>f :Lexplore<CR>

noremap <leader><CR> :History<CR>
noremap <leader>. :Files ~/<CR>
noremap <leader>cg :Commits<CR>

noremap <leader>bs :Buffers<CR>
noremap <leader>bn :bnext<CR>
noremap <leader>bd :bdelete %<CR>
