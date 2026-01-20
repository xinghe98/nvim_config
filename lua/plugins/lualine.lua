local colors = {
	blue   = '#80a0ff',
	cyan   = '#79dac8',
	black  = '#080808',
	white  = '#c6c6c6',
	red    = '#ff5189',
	violet = '#d183e8',
	grey   = '#303030',
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.violet },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.black, bg = "" },
	},

	insert = { a = { fg = colors.black, bg = colors.blue } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.red } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.black, bg = colors.black },
	},
}
return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	lazy = false,
	checker = {
		-- automatically check for plugin updates
		enabled = true,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 360, -- check for updates every hour
	},
	opts = {
		options = {
			theme = bubbles_theme,
			globalstatus = true,
			component_separators = "|",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "" }, right_padding = 2 },
			},
			lualine_b = {
				"filename",
				{
					'g:coc_status', 'bo:filetype'
				},
				{ function()
					return vim.g.flutter_tools_decorations.device
				end
				},
				{

					"diagnostics",
					sources = { "nvim_diagnostic", "coc" },
					symbols = { error = " ", warn = " ", info = " " },
					diagnostics_color = {
						color_error = { fg = colors.red },
						color_warn = { fg = colors.yellow },
						color_info = { fg = colors.cyan },
					},
				},
				{
					function()
						local status = require("codeium.virtual_text").status()

						if status.state == "idle" then
							-- Output was cleared, for example when leaving insert mode
							return "🐣"
						end

						if status.state == "waiting" then
							-- Waiting for response
							return "🐥"
						end

						if status.state == "completions" and status.total > 0 then
							return string.format("🐥 %d/%d", status.current, status.total)
						end

						return "⛔️"
					end,
				},

			},
			lualine_c = {},
			lualine_x = {
				{

					"diff",
					-- Is it me or the symbol for modified us really weird
					symbols = { added = " ", modified = " ", removed = " " },
					diff_color = {
						added = { fg = colors.green },
						modified = { fg = colors.orange },
						removed = { fg = colors.red },
					},
				},
			},
			lualine_y = {
				require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component(),
				"branch",
				"filetype",
				"progress",
			},
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = { "lazy", "nvim-tree" },
	}
}
