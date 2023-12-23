function ColorMyPencils(color)
	color = color or "jellybeans"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
end

ColorMyPencils()
