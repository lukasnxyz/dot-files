" -- VIMRC

" --- plug in manager (vim-plug)
call plug#begin('~/.vim/autoload')

Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/AutoComplPop'
Plug 'jamessan/vim-gnupg'

call plug#end()

" --- Parameteres and keybindings
so $HOME/.vim/vconf/config.vim

" --- netrw
so $HOME/.vim/vconf/netrw.vim

" --- Vimwiki
so $HOME/.vim/vconf/vimwiki.vim

" --- GnuPG
so $HOME/.vim/vconf/gnupg.vim

" --- fzf
let g:fzf_layout = {'down':  '45%'}
