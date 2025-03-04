return {
	"nvim-telescope/telescope.nvim",
	version = false,
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Lua 开发模块
		"BurntSushi/ripgrep", -- 文字查找
		"sharkdp/fd",      -- 文件查找
		'fannheyward/telescope-coc.nvim'
	},
	keys = function()
		return {
			{ "<C-f>",      "<cmd>Telescope find_files<cr>",   desc = "Find Files" },
			{ "<C-g>",      "<cmd>Telescope live_grep<cr>",    desc = "Find Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>",      desc = "Find buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>",    desc = "Find help" },
			{ "<C-x>",      ":Telescope flutter commands<CR>", desc = "flutter" },
		}
	end,
	config = function()
		require("packsettings.telescope")
	end,
	opts = {
		defaults = {
			sorting_strategy = "ascending",
			prompt_prefix = "🔍 ", -- 改变提示符样式
			selection_caret = "> ", -- 改变选项前面的符号
			entry_prefix = "  ", -- 删除不需要的符号
			color_devicons = true, -- 启用或禁用图标颜色
			file_ignore_patterns = {
				"%.env",
				"yarn.lock",
				"package-lock.json",
				"lazy-lock.json",
				"init.sql",
				"target/.*",
				".git/.*",
				-- "node_modules",
				"dist",
			},
			mappings = {
				i = {
					-- map actions.which_key to <C-h> (default: <C-/>)
					-- actions.which_key shows the mappings for your picker,
					-- e.g. git_{create, delete, ...}_branch for the git_branches picker
					["<Tab>"] = "move_selection_next",
					["<S-Tab>"] = "move_selection_previous",
					["<C-u>"] = "preview_scrolling_up",
					["<C-e>"] = "preview_scrolling_down",
				},
			},
		},
		extensions = {
			coc = {
				theme = 'dropdown',
				prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
			}
		},
	}
}
