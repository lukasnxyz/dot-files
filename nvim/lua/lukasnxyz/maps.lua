vim.g.mapleader = " "

vim.keymap.set("n", "<leader>r", ":%s///g<Left><Left><Left>")

vim.keymap.set("n", "<leader>n", ":set number! relativenumber!<cr>")
vim.keymap.set("n", "<leader>l", ":set list!<cr>")
vim.keymap.set("n", "<leader>s", ":set hlsearch!<cr>")
vim.keymap.set("n", "<leader>f", ":Lexplore<cr>")

vim.keymap.set("n", "<leader>bn", ":bnext<cr>")
vim.keymap.set("n", "<leader>bp", ":bprevious<cr>")
vim.keymap.set("n", "<leader>bd", ":bdelete %<cr>")

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "gp", "`[v`]")
