return {
  "tomasiser/vim-code-dark",
	name = "colorscheme",
  lazy = false,
  priority = 1000,
	config = function()
		vim.cmd("colorscheme codedark")
	end,
}
