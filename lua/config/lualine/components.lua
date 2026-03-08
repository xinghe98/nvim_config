-- Lualine custom components
local M = {}

local theme = require("config.lualine.theme")
local colors = theme.colors

--------------------------------------------------------------------------------
-- CoC LSP Name Component
--------------------------------------------------------------------------------

-- 缓存当前 buffer 的 LSP 名称
local b_coc_lsp_name = ""
local b_coc_lsp_loading = false
local b_coc_lsp_pending_name = nil -- 异步回调拿到但还在等动画结束
local b_coc_lsp_anim_timer = nil   -- 动画刷新定时器
local MIN_ANIM_MS = 800            -- 动画最少显示时长(毫秒)
local lsp_name_cache = {}          -- 按 filetype 缓存已解析的 LSP 名称

local function stop_anim_timer()
	if b_coc_lsp_anim_timer then
		b_coc_lsp_anim_timer:stop()
		b_coc_lsp_anim_timer:close()
		b_coc_lsp_anim_timer = nil
	end
end

local function finish_loading()
	stop_anim_timer()
	b_coc_lsp_loading = false
	if b_coc_lsp_pending_name then
		b_coc_lsp_name = b_coc_lsp_pending_name
		b_coc_lsp_pending_name = nil
	end
end

-- 创建一个函数异步获取并更新缓存
local function update_coc_lsp_name()
	local current_ft = vim.bo.filetype
	if current_ft == "" then return end

	-- 如果该 filetype 已经解析过，直接使用缓存，不播放动画
	if lsp_name_cache[current_ft] ~= nil then
		b_coc_lsp_name = lsp_name_cache[current_ft]
		b_coc_lsp_loading = false
		return
	end

	-- 首次遇到该 filetype：清除旧名称，标记为加载中
	b_coc_lsp_name = ""
	b_coc_lsp_pending_name = nil
	b_coc_lsp_loading = true

	local anim_start = vim.loop.hrtime()
	local fetched = false -- 是否已发起过异步请求

	-- 启动定时器：驱动动画刷新 + 轮询等待 coc 就绪
	stop_anim_timer()
	b_coc_lsp_anim_timer = vim.loop.new_timer()
	b_coc_lsp_anim_timer:start(0, 80, vim.schedule_wrap(function()
		if not b_coc_lsp_loading then return end
		vim.cmd("redrawstatus")

		-- coc 就绪后发起一次异步请求
		if not fetched and vim.g.coc_service_initialized == 1 then
			fetched = true
			vim.fn.CocActionAsync('services', function(err, res)
				local result_name = ""

				if res ~= vim.NIL and type(res) == "table" then
					local active_lsps = {}
					for _, lsp in ipairs(res) do
						if lsp.state == "running" then
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
					if #active_lsps > 0 then
						result_name = table.concat(active_lsps, ", ")
					end
				end

				-- 计算已过去的时间，确保动画至少显示 MIN_ANIM_MS
				local elapsed_ms = (vim.loop.hrtime() - anim_start) / 1e6
				local remaining = math.max(0, MIN_ANIM_MS - elapsed_ms)

				if remaining <= 0 then
					b_coc_lsp_pending_name = result_name
					finish_loading()
				else
					b_coc_lsp_pending_name = result_name
					vim.defer_fn(function()
						finish_loading()
					end, remaining)
				end

				-- 写入缓存，后续同 filetype 不再播放动画
				lsp_name_cache[current_ft] = result_name
			end)
		end
	end))
end

-- 注册自动命令：在进入 buffer 或者光标停留时触发更新
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
	pattern = "*",
	callback = update_coc_lsp_name,
})

M.coc_lsp = {
	function()
		-- 加载中显示动画，完成后显示 LSP 名称
		if b_coc_lsp_loading then
			-- 简单的旋转动画
			local frames = { "◜", "◠", "◝", "◞", "◡", "◟" }
			local i = math.floor(vim.loop.hrtime() / 1e8) % #frames + 1
			return frames[i] .. " Initing lsp…"
		else
			return b_coc_lsp_name
		end
	end,
	icon = "",
	cond = function()
		-- 加载中或识别到具体的 LSP 时都显示
		return b_coc_lsp_loading or b_coc_lsp_name ~= ""
	end,
	separator = { left = '', right = '' },
	color = function()
		if b_coc_lsp_loading then
			return { fg = colors.violet, bg = colors.grey }
		else
			return { fg = colors.cyan, bg = colors.grey, gui = "bold" }
		end
	end,
}

--------------------------------------------------------------------------------
-- Flutter Device Component
--------------------------------------------------------------------------------

M.flutter_device = {
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

--------------------------------------------------------------------------------
-- Codeium Component
--------------------------------------------------------------------------------

M.codeium = {
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

--------------------------------------------------------------------------------
-- AI Model Component
--------------------------------------------------------------------------------

local ok_ms, ms = pcall(require, "cc_model_selector")
M.ai_model = ok_ms and ms.get_lualine_component(
	{
		icon = "🤖",
		color = { fg = "#a9b665", gui = "bold" },
	}
) or {
	function() return "" end,
	cond = function() return false end,
}

--------------------------------------------------------------------------------
-- CodeCompanion Spinner Component
--------------------------------------------------------------------------------

M.cc_spinner = require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component()

--------------------------------------------------------------------------------
-- Coc Status Component
--------------------------------------------------------------------------------

M.coc_status = {
	function() return vim.g.coc_status or "" end,
	cond = function() return vim.g.coc_status ~= nil and vim.g.coc_status ~= "" end,
	icon = "󰿘",
	color = { fg = colors.gold, gui = "italic" },
}

return M