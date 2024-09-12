vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.listchars = "space:·,tab:->>"

vim.opt.wrap = false
vim.opt.showcmd = true
vim.opt.hlsearch = false

vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

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
