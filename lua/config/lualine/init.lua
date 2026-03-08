-- Lualine configuration entry point
local M = {}

local theme = require("config.lualine.theme")
local components = require("config.lualine.components")
local colors = theme.colors

-- Mode name mapping
local mode_map = {
	n     = "NORMAL",
	no    = "OP-PEND",
	nov   = "OP-VIS",
	noV   = "OP-LIN",
	ni    = "NORMAL",
	nt    = "TERM",
	ntT   = "TERM",
	v     = "VISUAL",
	vs    = "VISUAL",
	V     = "V-LINE",
	Vs    = "V-LINE",
	s     = "SELECT",
	S     = "S-LINE",
	i     = "INSERT",
	ic    = "INSERT",
	ix    = "INSERT",
	t     = "TERM",
	R     = "REPLACE",
	Rc    = "REPLACE",
	Rx    = "REPLACE",
	Rv    = "V-REPLACE",
	r     = "PENDING",
	rm    = "MORE",
	rQ    = "CONFIRM",
	["!"] = "SHELL",
}

-- Mode icons
local mode_icon = {
	n = "󰣭",
	i = "󰏫",
	v = "󰈔",
	V = "󰈊",
	t = "󱊦",
	R = "󱎕",
}

-- Section definitions
local sections = {
	-- lualine_a: Mode pill
	lualine_a = {
		{
			"mode",
			right_padding = 2,
			fmt = function(mode_name)
				local display_mode = mode_map[mode_name] or mode_name
				return (mode_icon[mode_name] or "") .. display_mode
			end,
		},
	},

	-- lualine_b: Branch + diff
	lualine_b = {
		{
			"branch",
			icon = { "", color = { fg = colors.violet } },
			colored = true,
			color = { bg = colors.grey },
			separator = { left = '', right = '' },
		},
		{
			"diff",
			symbols = {
				added    = "󰸋 ",
				modified = "󰛿 ",
				removed  = "󰍷 ",
			},
			diff_color = {
				added    = { fg = colors.green, gui = "bold" },
				modified = { fg = colors.yellow, gui = "bold" },
				removed  = { fg = colors.red, gui = "bold" },
			},
			color = { bg = colors.grey },
			separator = { left = '', right = '' },
		},
	},

	-- lualine_c: Filename + diagnostics
	lualine_c = {
		{
			"filename",
			path = 1,
			symbols = {
				modified  = "󰷮",
				readonly  = "󰌾",
				unnamed   = "󰈙",
				exclusive = "󰈔",
			},
			color = function()
				if vim.bo.modified then
					return { fg = colors.yellow, gui = "bold" }
				elseif vim.bo.readonly then
					return { fg = colors.red, gui = "bold" }
				end
				return {}
			end,
		},
		{
			"diagnostics",
			sources = { "nvim_diagnostic", "coc" },
			symbols = {
				error = "󰅙",
				warn  = "󰀦",
				info  = "󰋼",
				hint  = "󰌶",
			},
			diagnostics_color = {
				error = { fg = colors.red, gui = "bold" },
				warn  = { fg = colors.orange },
				info  = { fg = colors.cyan },
				hint  = { fg = colors.violet },
			},
		},
	},

	-- lualine_x: AI / tooling status
	lualine_x = {
		components.cc_spinner,
		components.ai_model,
		components.codeium,
		components.flutter_device,
		components.coc_status,
	},

	-- lualine_y: Filetype pill (empty)
	lualine_y = {},

	-- lualine_z: Filetype icon + LSP name
	lualine_z = {
		{
			"filetype",
			left_padding = 1,
			color = { gui = "bold" },
			icon_only = true,
		},
		components.coc_lsp,
	},
}

local inactive_sections = {
	lualine_a = {},
	lualine_b = { { "filename", path = 1 } },
	lualine_c = {},
	lualine_x = { "filetype" },
	lualine_y = {},
	lualine_z = {},
}

function M.get_config()
	return {
		options = {
			theme                = theme.get_theme(),
			globalstatus         = true,
			component_separators = "",
			section_separators   = { left = '', right = '' },
			disabled_filetypes   = { statusline = { "dashboard", "alpha", "starter" } },
			always_divide_middle = true,
			padding              = { left = 1, right = 0 },
		},
		sections          = sections,
		inactive_sections = inactive_sections,
		tabline           = {},
		extensions        = { "lazy", "nvim-tree", "trouble", "quickfix" },
	}
end

return M