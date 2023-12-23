vim.g.fzf_layout = { down = '40%' }

vim.keymap.set("n", "<leader><CR>", ":History<CR>")
vim.keymap.set("n", "<leader>.", ":Files ~/<CR>")
vim.keymap.set("n", "<leader>cg", ":Commits<CR>")
vim.keymap.set("n", "<leader>bs", ":Buffers<CR>")
