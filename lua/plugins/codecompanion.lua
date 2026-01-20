return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"lalitmee/codecompanion-spinners.nvim", -- 安装 spinners 扩展
	},
	opts = {
		extensions = {
			spinner = {
				-- enabled = true, -- 这是默认值
				opts = {
					-- 您的 spinner 配置写在这里

					-- style = "cursor-relative",
					style = "lualine",
					["cursor-relative"] = {
						-- spinner 文本字符
						text = "",
						-- 替代方案: text = "",

						-- 动画的高亮位置（start_col, end_col 对）
						hl_positions = {
							{ 0, 3 }, -- 第一个圆
							{ 3, 6 }, -- 第二个圆
							{ 6, 9 }, -- 第三个圆
						},

						-- 动画间隔（毫秒）
						interval = 100,

						-- Highlight groups
						hl_group = "Title", -- 激活高亮
						hl_dim_group = "NonText", -- 暗淡背景
					},
				},
			},
		},
		language = "zh-CN",
		strategies = {
			-- 将所有策略指向你自定义的适配器
			chat = {
				adapter = "yunwu",
			},
			inline = { adapter = "yunwu" },
			-- inline = { adapter = "deepseek" },
			agent = {
				adapter = "yunwu",
				tools = {
					["mcp"] = {
						opts = {
							servers = {
								-- 使用 MCP (Model Context Protocol) 的文件系统服务配置
								["filesystem"] = {
									cmd = "npx",                                               -- 使用 npx 运行服务
									args = { "-y", "@modelcontextprotocol/server-filesystem", vim.fn.getcwd() }, -- -y 标志表示确认，服务包，以及当前目录
								},
							},
						},
					},
				},
			},
		},
		adapters = {
			http = {

				deepseek = function()
					return require("codecompanion.adapters").extend("deepseek", {
						env = {

							-- 2. API Key (推荐使用命令读取环境变量)
							api_key = "cmd:echo $DEEPSEEK_KEY",
						},
						schema = {
							model = {
								-- 🔴 关键：Inline 模式绝对不要用 deepseek-reasoner (R1)
								default = "deepseek-chat",
							},
							temperature = {
								default = 0.0,
							},
						},
					})
				end,
				yunwu = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							-- 1. Base URL (通常是域名，不带 /v1/chat/completions)
							url = "https://yunwu.ai",

							-- 2. API Key (推荐使用命令读取环境变量)
							api_key = "cmd:echo $YUNWU_KEY",

							-- 3. Chat Endpoint (官方文档强调这种分离写法)
							chat_url = "/v1/chat/completions",
						},
						schema = {
							model = {
								default = "gemini-3-pro-preview-thinking", -- 你的模型名称
							},
							-- 可选：针对某些第三方模型可能需要调整参数
							temperature = {
								default = 0.0,
							},
						},
					})
				end,
			},
		},
		keys = {
			-- 3. Inline 模式 (直接在代码里改，类似 Cursor 的 Ctrl+K)
			{
				"ga",
				"<cmd>CodeCompanion<cr>",
				mode = { "n", "v" },
				desc = "行内 AI 提示",
			},

			-- 4. 快速添加到聊天 (将选中的代码加入 Chat 上下文)
			{
				"<leader>ad",
				"<cmd>CodeCompanionChat Add<cr>",
				mode = "v",
				desc = "添加到 AI 聊天",
			},
		},
		-- 在这里添加自定义 Prompt
		prompt_library = {
			["Git Commit (CN)"] = {
				strategy = "chat",
				description = "生成中文 Git 提交信息",
				opts = {
					index = 5, -- 排序位置
					is_slash_cmd = true, -- 允许通过 /commit_cn 调用
					short_name = "commit_cn",
					auto_submit = true, -- 打开聊天后自动发送请求
				},
				prompts = {
					{
						role = "user",
						content = function()
							-- 获取 git diff --staged 的内容
							return "请根据以下暂存代码的变动（git diff --staged），生成一个 Git 提交信息。\n\n"
								.. "要求：\n"
								.. "1. 使用中文。\n"
								.. "2. 遵循 Conventional Commits 规范 (feat, fix, docs, style, refactor, perf, test, chore)。\n"
								.. "3. 格式为：`<type>(<scope>): <subject>`。\n"
								.. "4. 只输出提交信息本身，不要包含解释或其他文字。\n\n"
								.. "Diff 内容:\n"
								.. vim.fn.system("git diff --staged")
						end,
					},
				},
			},
		},
	},
}
