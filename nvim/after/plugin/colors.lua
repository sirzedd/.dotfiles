require('rose-pine').setup({
    disable_background = true
})

function ColorMyPencils(color) 
	color = color or "rose-pine"
	--color = color or "molokia"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

function ColorMyBar(color) 
	color = color or "base16_black_metal"
	--color = color or "molokia"
	vim.cmd('AirlineTheme ' .. color)

end

ColorMyPencils()
ColorMyBar()
