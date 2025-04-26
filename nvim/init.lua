-- GENERAL CONFIGS --
vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"

vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.showcmd = true
vim.opt.hlsearch = false

vim.o.listchars = "tab:··,trail:-,extends:>,precedes:<,space:·"

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartindent = true

-- netrw
vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 20
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'netrw',
    command = 'setl bufhidden=wipe'
})
vim.keymap.set("n", "<leader>f", ":Lexplore<cr>")

-- remove trailing whitespaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- GENERAL KEYMAPS --
vim.keymap.set("n", "<leader>r", ":%s///g<Left><Left><Left>")

vim.keymap.set("n", "<leader>n", ":set number! relativenumber!<cr>")
vim.keymap.set("n", "<leader>l", ":set list!<cr>")
vim.keymap.set("n", "<leader>s", ":set hlsearch!<cr>")

vim.keymap.set("n", "<leader>v", ":vs<cr>")
vim.keymap.set("n", "<leader>h", ":split<cr>")

vim.keymap.set("n", "<leader>bn", ":bnext<cr>")
vim.keymap.set("n", "<leader>bp", ":bprevious<cr>")
vim.keymap.set("n", "<leader>bd", ":bdelete %<cr>")

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "gp", "`[v`]")

-- LAZY (PLUGINS) --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- plugin definitions
require("lazy").setup({
    {
        "blazkowolf/gruber-darker.nvim",
        lazy = false,
        priority = 1000,
        config = function() vim.cmd("colorscheme gruber-darker") end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { disable_filetype = { "TelescopePrompt", "vim" } }
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup()
            vim.keymap.set("n", "<leader><cr>", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
            vim.keymap.set("n", "<leader><bs>", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
            vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
            vim.keymap.set("n", "<leader>o", "<cmd>Telescope oldfiles<cr>", { desc = "Browse recently opened files" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },

        config = function()
            local cmp = require('cmp')
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

            require('fidget').setup()
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'clangd', 'pyright' },
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup { capabilities = capabilities }
                    end,
                    ['clangd'] = function()
                        lspconfig.clangd.setup { capabilities = capabilities }
                    end,
                    ['lua_ls'] = function()
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = { globals = { 'vim' } }
                                }
                            }
                        }
                    end,
                }
            })

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                }
            })

            vim.diagnostic.config({
                float = { border = 'rounded', source = 'always' },
            })
        end
    },
    --{
    --    require('plugins.ollama_stream').setup({
    --        model = "llama3.1",
    --        system_prompt = [[You are my coding slave that doesn't make any mistakes ever.
    --        You are a 10x dev that can fix all bugs. Keep your responses as short as possible
    --        and only give me code in the case that I ask for you to write code.]],
    --        temperature = 0.7,
    --    })
    --},
})
