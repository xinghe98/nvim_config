return { {
	'echasnovski/mini.nvim',
	version = '*',
	event = "VeryLazy",
	-- Options which control module behavior
	options = {
		-- Function to compute custom 'commentstring' (optional)
		custom_commentstring = nil,

		-- Whether to ignore blank lines when commenting
		ignore_blank_line = false,

		-- Whether to recognize as comment only lines without indent
		start_of_line = false,

		-- Whether to force single space inner padding for comment parts
		pad_comment_parts = true,
	},

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Toggle comment (like `gcip` - comment inner paragraph) for both
		-- Normal and Visual modes
		comment = '<C-_>',

		-- Toggle comment on current line
		comment_line = '<C-_>',

		-- Toggle comment on visual selection
		comment_visual = '<C-_>',

		-- Define 'comment' textobject (like `dgc` - delete whole comment block)
		-- Works also in Visual mode if mapping differs from `comment_visual`
		textobject = 'gc',
	},

	-- Hook functions to be executed at certain stage of commenting
	hooks = {
		-- Before successful commenting. Does nothing by default.
		pre = function() end,
		-- After successful commenting. Does nothing by default.
		post = function() end,
	},
},
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"echasnovski/mini.animate",
		version = false,
		config = function()
			local is_windows = vim.fn.has('win32') == 1
			require("mini.animate").setup({
				-- 开启平滑滚动
				scroll = {
					enable = not is_windows,
				},
				-- 也可以顺便开启光标动画和窗口动画
				cursor = { enable = false },
				open = {
					-- Whether to enable this animation
					enable = false,

					-- Timing of animation (how steps will progress in time)
					-- 'winblend' (window transparency) generator for floating window
				},

				-- Window close
				close = {
					-- Whether to enable this animation
					enable = false,
					-- 'winblend' (window transparency) generator for floating window
				},
				-- Window resize
				resize = {
					-- Whether to enable this animation
					enable = true,

				},

			})
		end
	}
}
