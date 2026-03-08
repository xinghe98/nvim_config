local config = require("config.lualine")

return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	lazy = false,
	opts = config.get_config(),
}
