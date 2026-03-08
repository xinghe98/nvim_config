-- Lualine theme configuration
local M = {}

M.colors = {
	blue      = "#80a0ff",
	cyan      = "#79dac8",
	black     = "#080808",
	white     = "#c6c6c6",
	red       = "#ff5189",
	violet    = "#d183e8",
	grey      = "#303030",
	dark      = "#1c1c1c",
	none      = "NONE",
	green     = "#b8e994",
	yellow    = "#f9ca24",
	orange    = "#e8b86d",
	magenta   = "#ff79c6",
	teal      = "#69d3c4",
	gold      = "#ffd700",
	editor_bg = "#1a1b26",
}

function M.get_theme()
	local colors = M.colors
	return {
		normal = {
			a = { fg = colors.black, bg = colors.violet, gui = "bold" },
			b = { fg = colors.white, bg = "NONE" },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = "NONE" },
			z = { fg = colors.black, bg = colors.violet, gui = "bold" },
		},
		insert = {
			a = { fg = colors.black, bg = colors.cyan, gui = "bold" },
			b = { fg = colors.white, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.cyan, gui = "bold" },
		},
		visual = {
			a = { fg = colors.black, bg = colors.blue, gui = "bold" },
			b = { fg = colors.white, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.blue, gui = "bold" },
		},
		replace = {
			a = { fg = colors.black, bg = colors.red, gui = "bold" },
			b = { fg = colors.black, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.red, gui = "bold" },
		},
		command = {
			a = { fg = colors.black, bg = colors.orange, gui = "bold" },
			b = { fg = colors.white, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.orange, gui = "bold" },
		},
		inactive = {
			a = { fg = colors.grey, bg = colors.dark },
			b = { fg = colors.grey, bg = colors.dark },
			c = { fg = colors.grey, bg = "NONE" },
			x = { fg = colors.grey, bg = "NONE" },
			y = { fg = colors.grey, bg = colors.dark },
			z = { fg = colors.grey, bg = colors.dark },
		},
	}
end

return M