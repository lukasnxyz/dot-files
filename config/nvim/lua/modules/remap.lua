vim.g.mapleader = " "

vim.keymap.set("n", "<leader>r", ":%s///g<Left><Left><Left>")
vim.keymap.set("v", "<leader>q", ":s/\\%V\\(.*\\)\\%V/\"\\1\"/<CR>")
vim.keymap.set("v", "<leader>s", ":set spell!<CR>")
vim.keymap.set("n", "<leader>f", ":Lexplore<CR>")

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bdelete %<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.cmd([[command! W write]])
