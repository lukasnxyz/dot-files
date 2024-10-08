return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup()
    local keymap = vim.keymap

    keymap.set("n", "<leader><cr>", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader><bs>", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>o", "<cmd>Telescope oldfiles<cr>", { desc = "Browse recently opened files" })
  end,
}
