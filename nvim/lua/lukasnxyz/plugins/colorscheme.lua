return {
  {
    "tomasiser/vim-code-dark",
    lazy = false,
  },
  {
    "bluz71/vim-moonfly-colors",
    lazy = false,
  },
  {
    "blazkowolf/gruber-darker.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme gruber-darker")
    end,
  },
  {
    "iagorrr/noctishc.nvim",
    lazy = false,
  }
}
