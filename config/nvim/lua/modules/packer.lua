-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'jiangmiao/auto-pairs'
    use 'junegunn/fzf.vim'
    use 'mbbill/undotree'
    use 'airblade/vim-gitgutter'
    use 'jamessan/vim-gnupg'
    use 'vimwiki/vimwiki'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nanotech/jellybeans.vim'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }
end)
