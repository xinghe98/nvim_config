return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = false },
		picker = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = {
			enabled = false,
		},
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = false },
	},
	keys = {
		-- Top Pickers & Explorer
		{ "<leader>sm", function() Snacks.picker.smart() end,   desc = "Smart Find Files" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<C-g>",      function() Snacks.picker.grep() end,    desc = "Grep" },
		{ "<C-f>",      function() Snacks.picker.files() end,   desc = "Find Files" },
	}
}
