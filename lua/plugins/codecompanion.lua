return {
	"olimorris/codecompanion.nvim",
	-- dir = "/Users/xinghe/Documents/codecompanion.nvim",
	dependencies = {
		"lalitmee/codecompanion-spinners.nvim",
		"j-hui/fidget.nvim",
		"xinghe98/codecompanion-model-selector.nvim",
	},
	init = function()
		require("config.codecompanion.keymaps")
	end,
	opts = {
		extensions = require("config.codecompanion.extensions"),
		language = "zh-CN",
		strategies = require("config.codecompanion.strategies"),
		prompt_library = require("config.codecompanion.prompts"),
		-- opts = {
		-- 	log_level = "DEBUG", -- TRACE|DEBUG|ERROR|INFO
		-- },
	}
	,
}
