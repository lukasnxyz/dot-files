" -- VIMRC

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

set complete+=kspell
set wildmode=longest,list,full
set completeopt=menuone,longest
set previewpopup=height:15,width:60

set noswapfile
set undodir=~/.vim/undodir
set viminfo='100,n$HOME/.vim/files/info/viminfo
set nobackup
set undofile

set tabstop=2
set shiftwidth=2
set expandtab
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

" --- plug in manager (vim-plug)
call plug#begin('~/.vim/autoload')

Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/AutoComplPop'
Plug 'jamessan/vim-gnupg'

call plug#end()

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

" --- netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_browse_split=4

augroup AutoDeleteNetrwHiddenBuffers
    au!
    au FileType netrw setlocal bufhidden=wipe
augroup end

" --- GnuPG
let g:GPGPreferArmor=1
let g:GPGPreferSign=1

augroup GnuPGExtra
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function SetGPGOptions()
    set updatetime=60000
    set foldmethod=marker
    set foldclose=all
    set foldopen=insert
endfunction

" --- Vimwiki
so $HOME/.vim/vimwiki.vim
