" --- Parameteres
let mapleader = " "
syntax on
filetype plugin on

set number relativenumber
set nowrap
set showcmd
set noerrorbells
set nohlsearch
set nocompatible
set autowriteall

set noswapfile
set undodir=~/.config/vim/undodir
set nobackup
set undofile

set softtabstop=0
set tabstop=2
set shiftwidth=2

set incsearch
set ignorecase
set smartindent

set backspace=indent,eol,start

" --- Keybindings
noremap <leader>r :%s///g<Left><Left><Left>
noremap <leader>l :set hlsearch!<CR>
noremap <leader>bs :Buffers<CR>
noremap <leader>bn :bnext<CR>
noremap <leader>bp :bprev<CR>
noremap <leader>bd :bdelete %<CR>
