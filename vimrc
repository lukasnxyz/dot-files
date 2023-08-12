"   __   _(_)_ __ ___  _ __ ___
"   \ \ / / | '_ ` _ \| '__/ __|
"    \ V /| | | | | | | | | (__
"     \_/ |_|_| |_| |_|_|  \___|

" --- parameters
syntax on
syntax enable
set nowrap
set mouse=a
set showcmd
set nobackup
set undofile
set t_Co=256
set incsearch
set smartcase
set expandtab
set tabstop=4
set noswapfile
set ignorecase
set smartindent
set nocompatible
set noerrorbells
set shiftwidth=4
set foldcolumn=0
set termguicolors
set updatetime=50
set encoding=UTF-8
filetype plugin on
set complete+=kspell
set formatoptions-=cro
set number relativenumber
set undodir=~/.vim/undodir
set wildmode=longest,list,full
set completeopt=menuone,longest
set previewpopup=height:15,width:60
set viminfo='100,n$HOME/.vim/files/info/viminfo
let mapleader = " "

" local filetype settings
autocmd FileType tex setlocal wrap tw=100
autocmd FileType markdown setlocal wrap tw=100
autocmd FileType vimwiki setlocal wrap tw=100

autocmd BufWritePre * %s/\s\+$//e
autocmd InsertEnter,InsertLeave * set cursorline!
autocmd InsertEnter,InsertLeave * set cursorcolumn!
autocmd BufEnter * silent! :lcd%:p:h

" auto place cursor where it was last when opening a file
if has("autocmd")
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
			\| exe "normal! g'\"" | endif
endif

" auto save and load folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" --- plug in manager (vim-plug)
call plug#begin('~/.vim/autoload')

Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'preservim/nerdcommenter'

Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
"Plug 'dense-analysis/ale'
Plug 'vim-scripts/AutoComplPop'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-eunuch'

Plug 'nanotech/jellybeans.vim'
Plug 'ap/vim-css-color'

call plug#end()

" --- colorscheme
colorscheme jellybeans

" --- keybindings
noremap fj 0cw<bs><cr><esc>
noremap <leader>r :%s///g<Left><Left><Left>
noremap e :term

noremap <leader>b :VimwikiUISelect<CR>
noremap <leader>g :GitGutterToggle<CR>

noremap <leader>f :Lexplore<CR>
noremap <leader>. :Files ~/<CR>

noremap <leader>/ :set hlsearch!<CR>

noremap <leader><CR> :History<CR>
noremap <leader>p :Buffers<CR>
noremap <leader>n :bnext<CR>
noremap <leader>d :bdelete %<CR>

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

" --- Vimwiki
let wiki_1 = {}
let wiki_1.auto_diary_index = 1
let wiki_1.path = '~/doc/vimwiki/'
let wiki_1.path_html = '~/doc/vimwiki/html_doc/'

let g:vimwiki_list = [wiki_1]

" --- fzf
"let g:fzf_layout = {'window':  {'width': 0.8, 'height': 0.6}}
let g:fzf_layout = {'down':  '45%'}

" --- Nerdcommenter
let g:NERDCreateDefaultMappings = 1

" --- gitgutter
let g:gitgutter_enabled = 0
