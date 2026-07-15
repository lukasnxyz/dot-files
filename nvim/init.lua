vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "auto:1"
vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.listchars = { tab = "··", trail = "-", extends = ">", precedes = "<", space = "·" }

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true

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

vim.keymap.set("n", "<leader>j", function()
  local date = " " .. os.date("%Y-%m-%d")
  vim.api.nvim_put({ date }, "c", true, true)
end, { desc = "insert current date" })

vim.keymap.set("n", "<leader>n", ":set number! relativenumber!<cr>", { desc = "toggle line numbers" })
vim.keymap.set("n", "<leader>l", ":set list!<cr>", { desc = "toggle listchars" })
vim.keymap.set("n", "<leader>h", ":set hlsearch!<cr>", { desc = "toggle search highlighting" })
vim.keymap.set("n", "<leader>=", ":wincmd =<cr>", { desc = "set split size to equal" })
vim.keymap.set("n", "<leader>R", ":e<cr>", { desc = "reload buffer" })
vim.keymap.set("n", "<leader>s", ":hs<cr>", { desc = "horizontal split" })
vim.keymap.set("n", "<leader>S", ":split<cr>", { desc = "vertical split" })
vim.cmd([[cabbrev W w]])

vim.keymap.set("n", "<leader>bn", ":bnext<cr>")
vim.keymap.set("n", "<leader>bp", ":bprevious<cr>")
vim.keymap.set("n", "<leader>bd", ":bdelete<cr>")
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
    n  = "normal",
    i  = "insert",
    v  = "visual",
    V  = "v-line", ["\22"] = "v-block", -- Ctrl-V
    R  = "replace",
    c  = "command",
    t  = "terminal",
  }
  return map[m] or m
end
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.statusline = "%{v:lua.mode_label()} => %f %m%r%h%w %=%{v:lua.gitsigns_statusline()}[%l,%c] %p%% %y"

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
local LIGHT_THEME = "modus_operandi" --local LIGHT_THEME = "gruvbox"

-- plugin definitions
require("lazy").setup({
  {
    "blazkowolf/gruber-darker.nvim",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd("colorscheme " .. DARK_THEME) end,
  },
  { "miikanissi/modus-themes.nvim", priority = 1001, lazy = true },
  { "ellisonleao/gruvbox.nvim", priority = 1002, lazy = true },
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
    },

    config = function()
      local lspconfig = require("lspconfig")
      local util = lspconfig.util

      -- ----------
      vim.keymap.set("n", "gd", function()
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })

        for _, client in ipairs(clients) do
          if client:supports_method("textDocument/definition") then
            vim.lsp.buf.definition()
            return
          end
        end

        vim.notify("No LSP definition provider attached for this buffer", vim.log.levels.WARN)
      end, { noremap = true, silent = true, desc = "LSP go to definition" })

      vim.keymap.set("n", "<leader>d", function()
        vim.diagnostic.open_float(nil, { scope = "line", focus = false, border = "rounded" })
      end, { noremap = true, silent = true, desc = "Show line diagnostics" })
      -- ----------

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
      end

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "rust_analyzer", "tinymist", "hls" }, -- , "pyright"
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({ on_attach = on_attach })
          end,
          ["clangd"] = function()
            lspconfig.clangd.setup({
              on_attach = on_attach,
              filetypes = { "c", "cpp", "h", "hpp", "cxx", "cc" },
              root_dir = function(fname)
                return util.root_pattern(
                  "compile_commands.json",
                  "build/compile_commands.json",
                  "Makefile"
                )(fname) or util.path.dirname(fname)
              end,
            })
          end,
          ["hls"] = function()
            lspconfig.hls.setup({
              on_attach = on_attach,
              single_file_support = true,
              root_dir = function(fname)
                return util.root_pattern(
                  "hie.yaml",
                  "stack.yaml",
                  "cabal.project",
                  "package.yaml",
                  "*.cabal",
                  ".git"
                )(fname) or util.path.dirname(fname)
              end,
            })
          end,
        }
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
