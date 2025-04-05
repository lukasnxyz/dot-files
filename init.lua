-- GENERAL CONFIGS --
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

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
vim.g.netrw_winsize = 15
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
local autocmd = vim.api.nvim_create_autocmd
autocmd('FileType', {
    pattern = 'netrw',
    command = 'setl bufhidden=wipe'
})

-- remove trailing whitespaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- MAPS --
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>r", ":%s///g<Left><Left><Left>")

vim.keymap.set("n", "<leader>n", ":set number! relativenumber!<cr>")
vim.keymap.set("n", "<leader>l", ":set list!<cr>")
vim.keymap.set("n", "<leader>s", ":set hlsearch!<cr>")
vim.keymap.set("n", "<leader>f", ":Lexplore<cr>")

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
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Plugin Definitions
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { disable_filetype = { "TelescopePrompt", "vim" } }
    },
    {
        "blazkowolf/gruber-darker.nvim",
        lazy = false,
        priority = 1000,
        config = function() vim.cmd("colorscheme gruber-darker") end,
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
            local keymap = vim.keymap

            keymap.set("n", "<leader><cr>", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
            keymap.set("n", "<leader><bs>", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
            keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
            keymap.set("n", "<leader>o", "<cmd>Telescope oldfiles<cr>", { desc = "Browse recently opened files" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },

        config = function()
            local cmp = require('cmp')
            local cmp_lsp = require("cmp_nvim_lsp")
            local lspconfig = require("lspconfig")
            local util = lspconfig.util
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )

            require("fidget").setup({})
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "pyright",
                },
                handlers = {
                    function(server_name) -- default handler (optional)
                        lspconfig[server_name].setup { capabilities = capabilities }
                    end,

                    ["clangd"] = function()
                        lspconfig.clangd.setup({
                            capabilities = capabilities,
                            filetypes = {"c", "cpp", "h", "hpp"},
                            root_dir = function(fname)
                                return util.root_pattern(
                                    "compile_commands.json",
                                    "Makefile",
                                    "configure.ac",
                                    ".git"
                                )(fname) or util.path.dirname(fname)
                            end,
                        })
                    end,

                    ["zls"] = function()
                        lspconfig.zls.setup({
                            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                            settings = {
                                zls = {
                                    enable_inlay_hints = true,
                                    enable_snippets = true,
                                    warn_style = true,
                                },
                            },
                        })
                    end,
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = "Lua 5.1" },
                                    diagnostics = {
                                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                    }
                                }
                            }
                        }
                    end,
                }
            })

            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })

            vim.diagnostic.config({
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end
    },
})
