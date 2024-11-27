return {
  --"tomasiser/vim-code-dark",
  --"catppuccin/nvim",
  --"bluz71/vim-moonfly-colors",
  --"EdenEast/nightfox.nvim",
  --"blazkowolf/gruber-darker.nvim",
  "iagorrr/noctishc.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme noctishc")
  end,
}
