require('catppuccin').setup({
    flavour = 'mocha',
    transparent_background = true,
    term_colors = false,
})

function ColorMyPencils(color)
	color = color or 'catppuccin'
	vim.cmd.colorscheme(color)
end

ColorMyPencils()
