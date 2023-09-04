"   __   _(_)_ __ ___  _ __ ___
"   \ \ / / | '_ ` _ \| '__/ __|
"    \ V /| | | | | | | | | (__
"     \_/ |_|_| |_| |_|_|  \___|

" --- parameters
let mapleader = " "

syntax on
filetype plugin on
set number relativenumber
set nowrap
set showcmd
set noerrorbells
set foldcolumn=0

set complete+=kspell
set formatoptions-=cro
set wildmode=longest,list,full
set completeopt=menuone,longest
set previewpopup=height:15,width:60

set noswapfile
set undodir=~/.vim/undodir
set viminfo='100,n$HOME/.vim/files/info/viminfo
set nobackup
set undofile

set tabstop=4
set smartindent
set incsearch
set ignorecase

set updatetime=50
set encoding=UTF-8

autocmd FileType tex setlocal wrap tw=100
autocmd FileType markdown setlocal wrap tw=100
autocmd FileType vimwiki setlocal wrap tw=100

autocmd BufWritePre * %s/\s\+$//e
autocmd BufEnter * silent! :lcd%:p:h

" auto place cursor where it was last when opening a file
if has("autocmd")
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
			\| exe "normal! g'\"" | endif
endif

" --- plug in manager (vim-plug)
call plug#begin('~/.vim/autoload')

Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'preservim/nerdcommenter'

Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/AutoComplPop'
Plug 'tpope/vim-eunuch'

call plug#end()

" --- keybindings
noremap fj 0cw<bs><cr><esc>
noremap <leader>r :%s///g<Left><Left><Left>
noremap <leader>q :s/\\%V\\(.*\\)\\%V/\"\\1\"/<CR>

noremap <leader>f :Lexplore<CR>
noremap <leader>. :Files ~/<CR>

noremap <leader>/ :set hlsearch!<CR>

noremap <leader><CR> :History<CR>
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

" --- fzf
let g:fzf_layout = {'down':  '45%'}

" --- Nerdcommenter
let g:NERDCreateDefaultMappings = 1

" --- Vimwiki
so $HOME/.vim/vimwiki.vim
