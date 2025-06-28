-- GENERAL CONFIGS --
vim.g.mapleader = ' '

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.clipboard = 'unnamedplus'
--vim.opt.colorcolumn = '100'

vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.showcmd = true
vim.opt.hlsearch = false

vim.o.listchars = 'tab:··,trail:-,extends:>,precedes:<,space:·'

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv('HOME') .. '/.local/share/nvim/undodir'
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

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'netrw',
    command = 'setl bufhidden=wipe'
})
vim.keymap.set('n', '<leader>f', ':Lexplore<cr>')

-- remove trailing whitespaces on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

-- GENERAL KEYMAPS --
vim.keymap.set('n', '<leader>r', ':%s///g<Left><Left><Left>')
vim.keymap.set('v', '<leader>r', ':s///g<Left><Left><Left>')

vim.keymap.set('n', '<leader>n', ':set number! relativenumber!<cr>')
vim.keymap.set('n', '<leader>l', ':set list!<cr>')
vim.keymap.set('n', '<leader>s', ':set hlsearch!<cr>')

vim.keymap.set('n', '<leader>bn', ':bnext<cr>')
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>')
vim.keymap.set('n', '<leader>bd', ':bdelete %<cr>')

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv")
vim.keymap.set('n', 'gp', "`[v`]")

-- STATUS LINE
function _G.gitsigns_statusline()
    local gsd = vim.b.gitsigns_status_dict
    if gsd and gsd.head ~= '' then
        return string.format(' [+%s ~%s -%s] | %s ', gsd.added or 0, gsd.changed or 0, gsd.removed or 0, gsd.head)
    end
    return ''
end
vim.o.laststatus = 2
vim.o.statusline = '%f %m%r%h%w %=%{v:lua.gitsigns_statusline()}[%l,%c] %p%% %y'

-- LAZY (PLUGINS) --
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- plugin definitions
require('lazy').setup({
    {
        'blazkowolf/gruber-darker.nvim',
        lazy = false,
        priority = 1000,
        config = function() vim.cmd('colorscheme gruber-darker') end,
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = { disable_filetype = { 'TelescopePrompt', 'vim' } }
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {},
        config = function()
            require('gitsigns').setup()
            vim.keymap.set('n', '<leader>B', '<cmd>Gitsigns blame_line<cr>', { desc = 'git blame on current line' })
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup()
            vim.keymap.set('n', '<leader><cr>', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
            vim.keymap.set('n', '<leader><bs>', '<cmd>Telescope buffers<cr>', { desc = 'Find string in cwd' })
            vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep<cr>', { desc = 'Fuzzy find recent files' })
            vim.keymap.set('n', '<leader>o', '<cmd>Telescope oldfiles<cr>', { desc = 'Browse recently opened files' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/nvim-cmp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'j-hui/fidget.nvim',
        },

        config = function()
            local cmp = require('cmp')
            local lspconfig = require('lspconfig')
            local util = lspconfig.util
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

            require('fidget').setup()
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'clangd', 'pyright', 'rust_analyzer', 'texlab', 'hls' },
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup { capabilities = capabilities }
                    end,
                    ['clangd'] = function()
                        lspconfig.clangd.setup({
                            capabilities = capabilities,
                            filetypes = {'c', 'cpp', 'h', 'hpp'},
                            root_dir = function(fname)
                                return util.root_pattern(
                                    'compile_commands.json',
                                    'Makefile',
                                    'configure.ac',
                                    '.git'
                                )(fname) or util.path.dirname(fname)
                            end,
                        })
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
    {
        'f-person/auto-dark-mode.nvim',
        opts = {
            set_dark_mode = function()
                vim.cmd('colorscheme gruber-darker')
            end,
            set_light_mode = function()
                vim.cmd('colorscheme retrobox')
            end,
            update_interval = 3000,
            fallback = 'dark'
        }
    },

    -- LOCAL CUSTOM PLUGINS --

    {
        require('plugins.llm_stream').setup({
            default_provider = 'google_gemini',
            providers = {
                ollama = { model = 'qwen2.5-coder:latest' },
                google_gemini = { model = 'gemini-2.0-flash' },
            },
        })
    },
})

