local vim = vim or {}

-- GENERAL CONFIGS --
vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.listchars = { tab = "··", trail = "-", extends = ">", precedes = "<", space = "·" }

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true

-- per project specific config files (.nvim.lua)
vim.opt.exrc = true
vim.opt.secure = true

-- special settings for indentation only basically
vim.g.python_recommended_style = false
vim.g.markdown_recommended_style = false
vim.g.rust_recommended_style = false

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true
if vim.fn.isdirectory(vim.o.undodir) == 0 then
  vim.fn.mkdir(vim.o.undodir, "p")
end

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- netrw
vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 15
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
vim.keymap.set("n", "<leader>f", ":Explore<cr>")

-- remove trailing whitespaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- auto enable spell check on markdown/tex docs
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "tex", "typst" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
  end,
})

-- GENERAL KEYMAPS --
vim.keymap.set("n", "<leader>r", ":%s///g<Left><Left><Left>")
vim.keymap.set("v", "<leader>r", ":s///g<Left><Left><Left>")

vim.keymap.set("n", "<leader>n", ":set number! relativenumber!<cr>", { desc = "toggle line numbers" })
vim.keymap.set("n", "<leader>l", ":set list!<cr>", { desc = "toggle listchars" })
vim.keymap.set("n", "<leader>h", ":set hlsearch!<cr>", { desc = "toggle search highlighting" })
vim.keymap.set("n", "<leader>=", ":wincmd =<cr>", { desc = "set split size to equal" })
vim.keymap.set("n", "<leader>R", ":e<cr>", { desc = "reload buffer" })
vim.cmd([[cabbrev W w]])

vim.keymap.set("n", "<leader>bn", ":bnext<cr>")
vim.keymap.set("n", "<leader>bp", ":bprevious<cr>")
vim.keymap.set("n", "<leader>bd", ":bdelete<cr>")
vim.keymap.set("n", "<leader>bf", function() vim.lsp.buf.format { async = true } end, { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "gp", "`[v`]", { desc = "highlight recently copied snippet" })

-- STATUS LINE
function _G.gitsigns_statusline()
  local gsd = vim.b.gitsigns_status_dict
  if gsd and gsd.head ~= "" then
    return string.format(" [+%s ~%s -%s] | %s ", gsd.added or 0, gsd.changed or 0, gsd.removed or 0, gsd.head)
  end
  return ""
end
function _G.mode_label()
  local m = vim.fn.mode()
  local map = {
    n  = "normal", i  = "insert", v  = "visual",
    V  = "v-line", ["\22"] = "v-block", -- Ctrl-V
    R  = "replace", c  = "command", t  = "terminal",
  }
  return map[m] or m
end
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.statusline = "%{v:lua.mode_label()} => %f %m%r%h%w %=%{v:lua.gitsigns_statusline()}[%l,%c] %p%% %y"

-- TOGGLING LSP
local lsp_state_file = vim.fn.stdpath("config") .. "/lsp_enabled"
local function is_lsp_enabled()
  return vim.fn.filereadable(lsp_state_file) == 1
end
local function set_lsp_enabled(enabled)
  if enabled then
    vim.fn.writefile({ "1" }, lsp_state_file)
  else
    vim.fn.delete(lsp_state_file)
  end
end
vim.keymap.set("n", "<leader>lt", function()
  local enabled = is_lsp_enabled()
  set_lsp_enabled(not enabled)

  if enabled then
    for _, client in pairs(vim.lsp.get_active_clients()) do
      client.stop()
    end
    print("LSP disabled")
  else
    print("LSP enabled")
    vim.cmd("edit")
  end
end, { desc = "Toggle LSP globally" })

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

local DARK_THEME = "gruber-darker"
local LIGHT_THEME = "modus_operandi"

-- plugin definitions
require("lazy").setup({
  {
    "blazkowolf/gruber-darker.nvim",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd("colorscheme " .. DARK_THEME) end,
  },
  { "miikanissi/modus-themes.nvim", lazy = true },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { disable_filetype = { "TelescopePrompt", "vim" } }
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function(_, opts)
      require("gitsigns").setup(opts)
      vim.keymap.set("n", "<leader>B", "<cmd>Gitsigns blame_line<cr>")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader><cr>", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
      vim.keymap.set("n", "<leader><bs>", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
      vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
      vim.keymap.set("n", "<leader>o", "<cmd>Telescope oldfiles<cr>", { desc = "Browse recently opened files" })
      vim.keymap.set("n", "<leader>G", "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        { desc = "Browse recently opened files" })
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
      if not is_lsp_enabled() then
        return
      end

      local cmp = require("cmp")
      local lspconfig = require("lspconfig")
      local util = lspconfig.util
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "<leader>[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "<leader>]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

      require("fidget").setup()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd", "pyright", "rust_analyzer", "zls", "tinymist", "texlab" },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup { capabilities = capabilities }
          end,
          ["clangd"] = function()
            lspconfig.clangd.setup({
              filetypes = { "c", "cpp", "h", "hpp", "cxx", "cc" },
              cmd = {
                "clangd",
                "--header-insertion=never",
                "--query-driver=clang++",
                "--compile-commands-dir=."
              },
              root_dir = function(fname)
                return util.root_pattern(
                  "compile_commands.json",
                  "build/compile_commands.json",
                  "Makefile",
                  "configure.ac",
                  ".git"
                )(fname) or util.path.dirname(fname)
              end,
            })
          end,
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                }
              }
            }
          end,
          ["rust_analyzer"] = function()
            lspconfig.rust_analyzer.setup {
              settings = {
                ["rust-analyzer"] = {
                  diagnostics = {
                    disabled = {
                      "dead_code",
                      "unreachable_code",
                      "inactive_code",
                      "unused",
                    },
                  },
                  rustfmt = { extraArgs = { "+nightly" } },
                },
              },
            }
          end,
          --["hls"] = function()
          --  lspconfig.hls.setup {
          --    filetypes = { "haskell", "lhaskell", "cabal" },
          --    settings = {
          --      haskell = {
          --        formattingProvider = "ormolu",
          --        maxCompletions = 40,
          --        checkProject = true,
          --        checkParents = "CheckOnSave",
          --        sessionLoading = "singleComponent",
          --      }
          --    }
          --  }
          --end,
          ["tinymist"] = function()
            lspconfig.tinymist.setup {
              settings = { formatterIndentSize = 2 },
            }
          end,
        }
      })

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        }
      })

      vim.diagnostic.config({
        float = { border = "rounded", source = "always" },
      })
    end
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function() vim.cmd("colorscheme " .. DARK_THEME) end,
      set_light_mode = function() vim.cmd("colorscheme " .. LIGHT_THEME) end,
    }
  },
})
