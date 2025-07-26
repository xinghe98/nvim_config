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
		picker = {
			enabled = true,
			win = {
				input = {
					keys = {
						["<Tab>"] = { "list_down", mode = { "i", "n" } },
						["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
						["<c-e>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
					}
				}
			}
		},
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
		{ "<leader>sm", function() Snacks.picker.smart() end, desc = "智能查找" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "查找缓冲区" },
		{ "<C-g>", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<C-f>", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "查找TODO" },
	}
}
