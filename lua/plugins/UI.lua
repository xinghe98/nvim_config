return {
	{ "xiyaowong/nvim-cursorword",   lazy = false },
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VimEnter",
		build = ":TSUpdate",
		opts = {
			ignore_install = { "help" },
			ensure_installed = { "vim", "vimdoc", "go", "python", "typescript", "markdown", "markdown_inline", "query", "c", "vim", "html", "vue", "lua", "dart" },
			highlight = {
				enable = true,
			},
			-- ...
		},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{ "voldikss/vim-translator",     event = "BufEnter" },
	{
		"tpope/vim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
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
	},

	{ "voldikss/vim-floaterm",    lazy = false },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, event = "VimEnter" },
	{ "ap/vim-css-color",         event = "VimEnter",                         lazy = false },
	{ "theniceboy/nvim-deus",     lazy = false,                               priority = 1000 },
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_current_word = "underline"
			-- 设置补全菜单透明背景
		end,
		lazy = false,
		priority = 1000
	},
	-- lazygit
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
	},
}
