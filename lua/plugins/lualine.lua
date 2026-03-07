-- 声明一个变量用于缓存当前 buffer 的 LSP 名称
local b_coc_lsp_name = ""
local b_coc_lsp_loading = false

-- 创建一个函数异步获取并更新缓存
local function update_coc_lsp_name()
	-- 如果 coc 服务还没初始化，直接跳过
	if vim.g.coc_service_initialized ~= 1 then return end

	local current_ft = vim.bo.filetype

	-- 标记为加载中
	b_coc_lsp_loading = true

	-- 异步获取 coc 所有的服务状态，避免阻塞主线程
	vim.fn.CocActionAsync('services', function(err, res)
		-- 标记加载完成
		b_coc_lsp_loading = false

		if res == vim.NIL or type(res) ~= "table" then return end

		local active_lsps = {}
		for _, lsp in ipairs(res) do
			-- 筛选出状态为 running 的服务
			if lsp.state == "running" then
				-- 检查该 LSP 支持的语言中是否包含当前 buffer 的 filetype
				if type(lsp.languageIds) == "table" then
					for _, lang in ipairs(lsp.languageIds) do
						if lang == current_ft then
							table.insert(active_lsps, lsp.id)
							break
						end
					end
				end
			end
		end

		-- 将结果格式化并缓存
		if #active_lsps > 0 then
			b_coc_lsp_name = table.concat(active_lsps, ", ")
		else
			b_coc_lsp_name = ""
		end
	end)
end

-- 注册自动命令：在进入 buffer 或者光标停留时触发更新
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
	pattern = "*",
	callback = update_coc_lsp_name,
})

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
local comp_ai_model = ok_ms and ms.get_lualine_component(
	{
		icon = "🤖",
		color = { fg = "#a9b665", gui = "bold" },
	}
) or {
	function() return "" end,
	cond = function() return false end,
}

local comp_cc_spinner =
	require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component()

-- ── Theme ──────────────────────────────────────────────────────────────

local colors = {
	blue      = "#80a0ff",
	cyan      = "#79dac8",
	black     = "#080808",
	white     = "#c6c6c6",
	red       = "#ff5189",
	violet    = "#d183e8",
	grey      = "#303030",
	dark      = "#1c1c1c",
	none      = "NONE",
	green     = "#b8e994",
	yellow    = "#f9ca24",
	orange    = "#e8b86d",
	magenta   = "#ff79c6",
	teal      = "#69d3c4",
	gold      = "#ffd700",
	editor_bg = "#1a1b26",
}
local function custom_theme()
	return {
		normal = {
			a = { fg = colors.black, bg = colors.violet, gui = "bold" },
			b = { fg = colors.white, bg = "NONE" }, -- 关键：抽干地毯
			c = { fg = colors.white, bg = "NONE" }, -- 关键：抽干地毯
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = "NONE" },
			z = { fg = colors.black, bg = colors.violet, gui = "bold" },
		},
		insert = {
			a = { fg = colors.black, bg = colors.cyan, gui = "bold" },
			b = { fg = colors.white, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.cyan, gui = "bold" },
		},
		visual = {
			a = { fg = colors.black, bg = colors.blue, gui = "bold" },
			b = { fg = colors.white, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.blue, gui = "bold" },
		},
		replace = {
			a = { fg = colors.black, bg = colors.red, gui = "bold" },
			b = { fg = colors.black, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.red, gui = "bold" },
		},
		command = {
			a = { fg = colors.black, bg = colors.orange, gui = "bold" },
			b = { fg = colors.white, bg = colors.dark },
			c = { fg = colors.white, bg = "NONE" },
			x = { fg = colors.white, bg = "NONE" },
			y = { fg = colors.white, bg = colors.grey },
			z = { fg = colors.black, bg = colors.orange, gui = "bold" },
		},
		inactive = {
			a = { fg = colors.grey, bg = colors.dark },
			b = { fg = colors.grey, bg = colors.dark },
			c = { fg = colors.grey, bg = "NONE" },
			x = { fg = colors.grey, bg = "NONE" },
			y = { fg = colors.grey, bg = colors.dark },
			z = { fg = colors.grey, bg = colors.dark },
		},
	}
end
local theme = custom_theme()

-- ── Plugin spec ────────────────────────────────────────────────────────

return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	lazy = false,
	opts = {
		options           = {
			theme                = theme,
			globalstatus         = true,
			component_separators = "",
			section_separators   = { left = '', right = '' },
			disabled_filetypes   = { statusline = { "dashboard", "alpha", "starter" } },
			always_divide_middle = true,
			padding              = { left = 1, right = 0 },
		},
		sections          = {
			-- ① Mode pill
			lualine_a = {
				{
					"mode",
					-- separator = { left = "", right = "" },
					right_padding = 2,
					fmt = function(mode_name)
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
						local display_mode = mode_map[mode_name] or mode_name
						local icon = {
							n = "󰣭",
							i = "󰏫",
							v = "󰈔",
							V = "󰈊",
							t = "󱊦",
							R = "󱎕",
						}
						return (icon[mode_name] or "") .. " " .. display_mode
					end,
				},
			},

			-- ② Branch + diff
			lualine_b = {
				{
					"branch",
					icon = { "", color = { fg = colors.violet } },
					colored = true,
					-- 魔法 1：强制给这个组件穿上灰色背景
					color = { bg = colors.grey },
					-- 魔法 2：强行切割出左右两端的平行四边形切角
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
					-- 同样给 diff 穿上灰色衣服和切角
					color = { bg = colors.grey },
					separator = { left = '', right = '' },
				},
			},
			-- ③ Filename + diagnostics
			lualine_c = {
				{
					"filename",
					path = 1,
					symbols = {
						modified  = "󰷮 ",
						readonly  = "󰌾 ",
						unnamed   = "󰈙 ",
						exclusive = "󰈔 ",
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
						error = "󰅙 ",
						warn  = "󰀦 ",
						info  = "󰋼 ",
						hint  = "󰌶 ",
					},
					diagnostics_color = {
						error = { fg = colors.red, gui = "bold" },
						warn  = { fg = colors.orange },
						info  = { fg = colors.cyan },
						hint  = { fg = colors.violet },
					},
				},
			},

			-- ④ AI / tooling status
			lualine_x = {
				comp_cc_spinner,
				comp_ai_model,
				comp_codeium,
				comp_flutter_device,
				{
					function() return vim.g.coc_status or "" end,
					cond = function() return vim.g.coc_status ~= nil and vim.g.coc_status ~= "" end,
					icon = "󰿘",
					color = { fg = colors.gold, gui = "italic" },
				},

			},

			-- ⑤ Filetype pill
			lualine_y = {},

			lualine_z = {
				{
					"filetype",
					-- separator = { right = "", left = "" },
					left_padding = 1,
					color = { gui = "bold" },
					icon_only = true,
				},

				{
					function()
						-- 加载中显示动画，完成后显示 LSP 名称
						if b_coc_lsp_loading then
							-- 简单的旋转动画
							local frames = { "󰧱", "󰧲", "󰧳", "󰧴", "󰧵", "󰧶", "󰧷", "󰧸" }
							local i = math.floor(vim.loop.hrtime() / 1e7) % #frames + 1
							return frames[i] .. " LSP"
						else
							return b_coc_lsp_name
						end
					end,
					icon = " ",
					cond = function()
						-- 加载中或识别到具体的 LSP 时都显示
						return b_coc_lsp_loading or b_coc_lsp_name ~= ""
					end,
					color = function()
						if b_coc_lsp_loading then
							return { fg = colors.cyan }
						else
							return { fg = colors.black, gui = "bold" }
						end
					end,
				}
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
