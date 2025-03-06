return {
	"nvimdev/dashboard-nvim",
	lazy = true,
	opts = {
		--[[ theme = "hyper",
	config = {
		week_header = {
			enable = true,
		},
		shortcut = {
			{ desc = " Update", group = "@property", action = "Lazy update", key = "u" },
			{
				desc = " Files",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
		},
	}, ]]
		theme = "hyper",
		config = {
			week_header = {
				enable = true,
			},
			shortcut = {
				{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
				{
					desc = " NeovimConf",
					group = "DiagnosticHint",
					action = "edit ~/.config/nvim/init.lua",
					key = "n",
				},
				{
					desc = " dotfiles",
					group = "Number",
					action = "edit ~/.config/",
					key = "d",
				},
				{
					desc = "󱠿 Project",
					group = "DiagnosticHint",
					action = "edit ~/Project/",
					key = "p",
				},
			},
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
