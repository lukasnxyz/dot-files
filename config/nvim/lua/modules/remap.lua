vim.g.mapleader = " "

vim.keymap.set("n", "<leader>r", ":%s///g<Left><Left><Left>")
vim.keymap.set("v", "<leader>q", ":s/\\%V\\(.*\\)\\%V/\"\\1\"/<CR>")

vim.keymap.set("n", "<leader>f", ":Lexplore!<CR>")
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bdelete %<CR>")
vim.keymap.set("n", "<leader><CR>", ":browse oldfiles<CR>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.cmd([[command! W write]])
