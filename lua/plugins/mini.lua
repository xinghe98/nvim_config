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
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
		main = "ibl",
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
		},
		opts = {
			scope = { enabled = false },
		},
		--[[ config = function()
			require("packsettings.indentline")
		end, ]]
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = "BufRead", -- 事件触发插件加载
		opts = {
			mappings = {
				-- Textobjects
				object_scope = "",
				object_scope_with_border = "",

				-- Motions (jump to respective border line; if not present - body line)
				goto_top = "[t",
				goto_bottom = "]t",
			},
			symbol = "┃", -- 缩进线的符号
			options = { try_as_border = true }, -- 配置项
		},
		init = function()
			-- 禁用特定文件类型的缩进高亮
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"lazy",
					"mason",
					"neo-tree",
					"Trouble",
					"toggleterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	} }
