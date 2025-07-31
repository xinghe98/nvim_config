return {
	"nvim-telescope/telescope.nvim",
	-- replace all Telescope keymaps with only one mapping

	event = "VimEnter",
	-- dependencies = { 'nvim-telescope/telescope-ui-select.nvim' },
	dependencies = {
		'fannheyward/telescope-coc.nvim'
	},
	--
	keys = function()
		return {
			{ "<C-x>", ":Telescope flutter commands<CR>", desc = "flutter" },
			-- { "<leader>gg", ":Telescope coc diagnostics<CR>" }
		}
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
				theme = 'ivy',
				prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
				push_cursor_on_edit = true, -- save the cursor position to jump back in the future
				timeout = 300,  -- timeout for coc commands
			}

		},
	},
}
