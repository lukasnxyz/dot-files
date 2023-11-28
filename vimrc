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
set nohlsearch
set nocompatible
set autowriteall

set complete+=kspell
set wildmode=longest,list,full
set completeopt=menuone,longest
set previewpopup=height:15,width:60
set listchars=nbsp:¬,tab:»·,trail:·,extends:>

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
set foldcolumn=1

set updatetime=50
set encoding=UTF-8

set t_Co=256

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
Plug 'tpope/vim-eunuch'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/AutoComplPop'
Plug 'jamessan/vim-gnupg'
Plug 'nanotech/jellybeans.vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

" --- colorscheme
colorscheme jellybeans

" --- keybindings
noremap fj 0cw<bs><cr><esc>
noremap <leader>r :%s///g<Left><Left><Left>
noremap <leader>l :set list!<CR>
noremap <leader>/ :set hlsearch!<CR>

noremap <leader>f :Lexplore<CR>
noremap <leader><CR> :History<CR>
noremap <leader>. :Files ~/<CR>
noremap <leader>cg :Commits<CR>
noremap <leader>g :GitGutterToggle<CR>

noremap <leader>bs :Buffers<CR>
noremap <leader>bn :bnext<CR>
noremap <leader>bd :bdelete %<CR>
noremap <leader>v :vsplit<CR>

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

" --- Gitgutter
let g:gitgutter_enabled = 1
