-- options
vim.opt.nu = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.compatible = false
vim.opt.laststatus = 0
vim.opt.listchars = "space:·,tab:->>"

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.showcmd = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.smartindent = true

vim.opt.softtabstop = 0
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true
vim.opt.clipboard:append("unnamedplus")

vim.api.nvim_set_hl(0, "SignColumn", { bg = "none"})

-- autocmd's
vim.cmd([[autocmd FileType tex setlocal wrap tw=100]])
vim.cmd([[autocmd FileType markdown setlocal wrap tw=100]])

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- -- remove white spaces on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- -- highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '200' })
  end
})

-- -- don't auto comment new lines
autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})

-- remaps
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>r", ":%s///g<Left><Left><Left>")

vim.keymap.set("n", "<leader>l", ":set list!<CR>")
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
vim.keymap.set("n", "<leader>h", ":split<CR>")
vim.keymap.set("n", "<leader>f", ":Lexplore<CR>")
vim.keymap.set("n", "<leader><CR>", ":browse oldfiles<CR>")

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bdelete %<CR>")
vim.keymap.set("n", "<leader><BS>", ":browse buffers<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "gp", "`[v`]")

vim.cmd([[command! W write]])

-- netrw
vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 12
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4

autocmd('FileType', {
  pattern = 'netrw',
  command = 'setl bufhidden=wipe'
})

-- manage plugins (lsp and treesitter)
require "packer"
