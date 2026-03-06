-- ╭─────────────────────────────────────────────────────────╮
-- │                      Lualine Config                      │
-- ╰─────────────────────────────────────────────────────────╯

-- ── Components ────────────────────────────────────────────────────────

local comp_flutter_device = {
	function()
		local decorations = vim.g.flutter_tools_decorations
		if decorations and decorations.device and decorations.device ~= "" then
			return decorations.device
		end
		return ""
	end,
	icon = "",
	cond = function()
		local decorations = vim.g.flutter_tools_decorations
		return decorations ~= nil
			and decorations.device ~= nil
			and decorations.device ~= ""
	end,
}

local comp_codeium = {
	function()
		local ok, vt = pcall(require, "codeium.virtual_text")
		if not ok then return "" end
		local status = vt.status()
		if status.state == "waiting" then
			return "󰔟 …"
		elseif status.state == "completions" and status.total > 0 then
			return string.format("󰚩 %d/%d", status.current, status.total)
		else
			return "󰚩"
		end
	end,
	color = function()
		local ok, vt = pcall(require, "codeium.virtual_text")
		if not ok then return {} end
		local state = vt.status().state
		if state == "completions" then
			return { fg = "#79dac8", gui = "bold" }
		elseif state == "waiting" then
			return { fg = "#d183e8" }
		end
		return {}
	end,
}

local ok_ms, ms = pcall(require, "cc_model_selector")
local comp_ai_model = ok_ms and ms.get_lualine_component() or {
	function() return "" end,
	cond = function() return false end,
}

local comp_cc_spinner =
	require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component()

-- ── Theme ──────────────────────────────────────────────────────────────

local colors = {
	blue   = "#80a0ff",
	cyan   = "#79dac8",
	black  = "#080808",
	white  = "#c6c6c6",
	red    = "#ff5189",
	violet = "#d183e8",
	grey   = "#303030",
	dark   = "#1c1c1c",
	none   = "NONE",
}

local theme = {
	normal   = {
		a = { fg = colors.black, bg = colors.violet, gui = "bold" },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.white, bg = colors.none },
	},
	insert   = { a = { fg = colors.black, bg = colors.cyan, gui = "bold" } },
	visual   = { a = { fg = colors.black, bg = colors.blue, gui = "bold" } },
	replace  = { a = { fg = colors.black, bg = colors.red, gui = "bold" } },
	command  = { a = { fg = colors.black, bg = "#e8b86d", gui = "bold" } },
	inactive = {
		a = { fg = colors.grey, bg = colors.none },
		b = { fg = colors.grey, bg = colors.none },
		c = { fg = colors.grey, bg = colors.none },
	},
}

-- ── Plugin spec ────────────────────────────────────────────────────────

return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	lazy = false,
	opts = {
		options           = {
			theme                = theme,
			globalstatus         = true,
			component_separators = { left = "", right = "" },
			section_separators   = { left = "", right = "" },
			disabled_filetypes   = { statusline = { "dashboard", "alpha", "starter" } },
		},
		sections          = {
			-- ① Mode pill
			lualine_a = {
				{ "mode", separator = { left = "" }, right_padding = 2 },
			},

			-- ② Branch + diff
			lualine_b = {
				{ "branch", icon = "" },
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
					diff_color = {
						added = { fg = colors.green },
						modified = { fg = colors.yellow },
						removed = { fg = colors.red },
					},
				},
			},

			-- ③ Filename + diagnostics
			lualine_c = {
				{
					"filename",
					path = 1,
					symbols = { modified = "  ", readonly = "  ", unnamed = "  " },
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic", "coc" },
					symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
				},
			},

			-- ④ AI / tooling status
			lualine_x = {
				comp_cc_spinner,
				comp_ai_model,
				comp_codeium,
				comp_flutter_device,
				{ "g:coc_status", icon = "󰿘", color = { gui = "italic" } },
			},

			-- ⑤ Filetype pill
			lualine_y = {},

			lualine_z = {
				{ "filetype", separator = { right = "" }, left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = { { "filename", path = 1 } },
			lualine_c = {},
			lualine_x = { "filetype" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline           = {},
		extensions        = { "lazy", "nvim-tree", "trouble", "quickfix" },
	},
}
