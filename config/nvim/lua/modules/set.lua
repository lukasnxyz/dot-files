vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.wrap = false
vim.opt.showcmd = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.compatible = false
vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.laststatus = 0
