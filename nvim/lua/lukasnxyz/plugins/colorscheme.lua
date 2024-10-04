return {
  --"tomasiser/vim-code-dark",
  --"catppuccin/nvim",
  "bluz71/vim-moonfly-colors",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme moonfly")
  end,
}
